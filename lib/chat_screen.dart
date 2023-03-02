// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chatgpt/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = [];

  OpenAI? chatGPT;

  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    chatGPT = OpenAI.instance;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _sendMessage() {
    ChatMessage _message = ChatMessage(
      text: _textController.text,
      sender: 'user',
    );

    setState(() {
      _messages.insert(0, _message);
    });

    _textController.clear();

    final request = CompleteText(
      prompt: _message.text,
      model: kTranslateModelV3,
      maxTokens: 200,
    );

    _subscription = chatGPT!
        .build(token: "")
        .onCompleteStream(request: request)
        .listen((response) {
      ChatMessage botMessage = ChatMessage(
        text: response!.choices[0].text,
        sender: 'bot',
      );

      setState(() {
        _messages.insert(0, botMessage);
      });
    });

    Widget _buildTextComposer() {
      return Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              onSubmitted: (value) => _sendMessage(),
              decoration: const InputDecoration.collapsed(
                hintText: 'Send a message',
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => _sendMessage(),
          ),
        ],
      ).px(16);
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Chat'),
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return _messages[index];
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: context.cardColor,
                ),
                child: _buildTextComposer(),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildTextComposer() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _textController,
            onSubmitted: (value) => _sendMessage(),
            decoration: const InputDecoration.collapsed(
              hintText: 'Send a message',
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: () => _sendMessage(),
        ),
      ],
    ).px(16);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                reverse: true,
                padding: const EdgeInsets.all(8),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _messages[index];
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: context.cardColor,
              ),
              child: _buildTextComposer(),
            ),
          ],
        ),
      ),
    );
  }
}
