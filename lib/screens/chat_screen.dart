import 'dart:developer';

import 'package:chatgpt/constants/constants.dart';
import 'package:chatgpt/models/chat_model.dart';
import 'package:chatgpt/providers/models_provider.dart';
import 'package:chatgpt/services/api_service.dart';
import 'package:chatgpt/services/services.dart';
import 'package:chatgpt/widgets/chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isWriting = false;

  late TextEditingController textEditingController;
  late ScrollController _listController;
  late FocusNode focusNode;

  @override
  void initState() {
    _listController = ScrollController();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  List<ChatModel> chatList = [];

  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text(
          'AI chat assistant',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await Services.showModelSheet(context: context);
            },
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                controller: _listController,
                itemCount: chatList.length,
                itemBuilder: (context, index) {
                  return ChatWidget(
                    msg: chatList[index].message,
                    chatIndex: chatList[index].chatIndex,
                  );
                },
              ),
            ),
            if (_isWriting) ...[
              const SpinKitThreeBounce(
                color: Colors.blue,
                size: 20,
              ),
            ],
            const SizedBox(
              height: 15,
            ),
            Material(
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        focusNode: focusNode,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        controller: textEditingController,
                        onSubmitted: (value) async {
                          await sendMessage(
                            modelsProvider: modelsProvider,
                          );
                        },
                        decoration: const InputDecoration.collapsed(
                          hintText: 'How can I help you?',
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await sendMessage(
                          modelsProvider: modelsProvider,
                        );
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void scrollToBottom() {
    _listController.animateTo(
      _listController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  Future<void> sendMessage({required ModelsProvider modelsProvider}) async {
    try {
      setState(() {
        _isWriting = true;
        chatList.add(
          ChatModel(
            message: textEditingController.text,
            chatIndex: 0,
          ),
        );
        textEditingController.clear();
        focusNode.unfocus();
      });
      chatList.addAll(
        await ApiService.sendMessage(
          message: textEditingController.text,
          modelId: modelsProvider.getCurrentModel,
        ),
      );
      setState(() {});
    } catch (error) {
      log("error $error");
    } finally {
      setState(() {
        scrollToBottom();
        _isWriting = false;
      });
    }
  }
}
