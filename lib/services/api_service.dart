// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:chatgpt/constants/api_consts.dart';
import 'package:chatgpt/constants/constants.dart';
import 'package:chatgpt/models/chat_model.dart';
import 'package:chatgpt/models/models_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(
        Uri.parse("$BASE_URL/models"),
        headers: {'Authorization': 'Bearer $API_KEY'},
      );

      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        // print("jsonResponse['error'] ${jsonResponse['error']['message']}");
        throw HttpException(jsonResponse['error']['message']);
      }
      // print("response $jsonResponse");
      List temp = [];
      for (var value in jsonResponse['data']) {
        temp.add(value);
        log("temp ${value['id']}");
      }
      return ModelsModel.modelsFromSnapshot(temp);
    } catch (error) {
      print("error $error");
      rethrow;
    }
  }

  // send message using to api (model)
  static Future<List<ChatModel>> sendMessageGPT({
    required String message,
    required String modelId,
    required bool memory,
    required List<ChatModel> chatsList,
  }) async {
    try {
      log("model, $modelId");
      log("memory $memory");
      final memChat = List<Map<String, String>>.empty(growable: true);
      if (memory) {
        // add all previous chats for model to process (consumes token)
        memChat.addAll(chatsList.map((chat) => {
              "role": chat.role,
              "content": chat.message,
            }));
      } else {
        // if no memory, send only the new message
        memChat.add(
          {
            "role": ResponseType.user.name,
            "content": message,
          },
        );
      }
      var response = await http.post(
        Uri.parse("$BASE_URL/chat/completions"),
        headers: {
          'Authorization': 'Bearer $API_KEY',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(
          {
            "model": modelId,
            "messages": memChat,
          },
        ),
      );

      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        // print("jsonResponse['error'] ${jsonResponse['error']['message']}");
        if (jsonResponse['error']['code'] == "Context_length_exceeded") {
          throw const HttpException("Max length");
        }
      }

      List<ChatModel> chatList = [];
      if (jsonResponse['choices'].length > 0) {
        // log("jsonResponse['choices']['text'] ${jsonResponse['choices'][0]['text']}");
        chatList = List.generate(
          jsonResponse['choices'].length,
          (index) {
            return ChatModel(
              message: jsonResponse['choices'][index]['message']['content'],
              chatIndex: 1,
              role: ResponseType.assistant.name,
            );
          },
        );
      }
      return chatList;
    } catch (error) {
      print("error $error");
      rethrow;
    }
  }

  // send message to api
  static Future<List<ChatModel>> sendMessage({
    required String message,
    required String modelId,
  }) async {
    try {
      log(modelId);
      var response = await http.post(
        Uri.parse("$BASE_URL/completions"),
        headers: {
          'Authorization': 'Bearer $API_KEY',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(
          {
            "model": modelId,
            "prompt": message,
            "max_tokens": 4000,
          },
        ),
      );

      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        // print("jsonResponse['error'] ${jsonResponse['error']['message']}");
        throw HttpException(jsonResponse['error']['message']);
      }

      List<ChatModel> chatList = [];
      if (jsonResponse['choices'].length > 0) {
        // log("jsonResponse['choices']['text'] ${jsonResponse['choices'][0]['text']}");
        chatList = List.generate(
          jsonResponse['choices'].length,
          (index) {
            return ChatModel(
              message: jsonResponse['choices'][index]['text'],
              chatIndex: 1,
              role: ResponseType.assistant.name,
            );
          },
        );
      }
      return chatList;
    } catch (error) {
      print("error $error");
      rethrow;
    }
  }
}
