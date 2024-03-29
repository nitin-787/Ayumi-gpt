import 'package:chatgpt/constants/constants.dart';
import 'package:chatgpt/models/chat_model.dart';
import 'package:chatgpt/services/api_service.dart';
import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];
  List<ChatModel> get getChatList {
    return chatList;
  }

  addUserChat({required String message}) {
    chatList.add(ChatModel(
      message: message,
      chatIndex: 0,
      role: ResponseType.user.name,
    ));
    notifyListeners();
  }

  // send message to api
  Future<void> sendMsg({
    required String message,
    required String modelId,
    required bool memory,
  }) async {
    if (modelId.toLowerCase().startsWith('gpt')) {
      chatList.addAll(
        await ApiService.sendMessageGPT(
          message: message,
          modelId: modelId,
          memory: memory,
          chatsList: chatList,
        ),
      );
    } else {
      chatList.addAll(
        await ApiService.sendMessage(
          message: message,
          modelId: modelId,
        ),
      );
      notifyListeners();
    }
  }
}
