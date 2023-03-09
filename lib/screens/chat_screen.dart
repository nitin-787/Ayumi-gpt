import 'dart:developer';

import 'package:chatgpt/constants/constants.dart';
import 'package:chatgpt/constants/text_widget.dart';
import 'package:chatgpt/providers/models_provider.dart';
import 'package:chatgpt/services/assets_manger.dart';
import 'package:chatgpt/services/services.dart';
import 'package:chatgpt/widgets/chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax/iconsax.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/chat_provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false;

  late TextEditingController textEditingController;
  late ScrollController _listController;
  late FocusNode focusNode;

  Future<void> launchURL(Uri url) async {
    if (await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      log('url launched $url');
    } else {
      log('could not launch $url');
    }
  }

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

  // List<ChatModel> chatList = [];

  @override
  Widget build(BuildContext context) {
    final Uri issueUrl = Uri(
      scheme: 'https',
      host: 'github.com',
      path: 'nitin-787/Ayumi-gpt/issues/new/choose/',
    );
    final Uri aboutUrl = Uri(
      scheme: 'https',
      host: 'nitin-787.github.io',
      path: 'Ayumi-gpt/',
    );
    final modelsProvider = Provider.of<ModelsProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: cardColor,
        title: const Center(
          child: TextWidget(
            label: 'Ayumi',
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await Services.showModelSheet(context: context);
            },
            icon: const Icon(Iconsax.moon),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: drawerColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
          child: ListView(
            children: [
              ClipRRect(
                child: Image.asset(
                  Assetsmanager.ace,
                  height: 100,
                  width: 100,
                ),
              ),
              ListTile(
                leading: const Icon(Iconsax.info_circle),
                iconColor: Colors.black,
                onTap: () async {
                  setState(() {
                    launchURL(aboutUrl);
                  });
                },
                title: const TextWidget(
                  label: "About App",
                  color: Colors.black,
                ),
              ),
              ListTile(
                leading: const Icon(IconlyLight.star),
                iconColor: Colors.black,
                onTap: () async {},
                title: const TextWidget(
                  label: "Rate app",
                  color: Colors.black,
                ),
              ),
              ListTile(
                leading: const Icon(IconlyLight.user),
                iconColor: Colors.black,
                onTap: () async {},
                title: const TextWidget(
                  label: "Invite Friends",
                  color: Colors.black,
                ),
              ),
              ListTile(
                leading: const Icon(Iconsax.danger),
                iconColor: Colors.black,
                onTap: () async {
                  setState(() {
                    launchURL(issueUrl);
                  });
                },
                title: const TextWidget(
                  label: "Report a problem",
                  color: Colors.black,
                ),
              ),
              ListTile(
                leading: const Icon(Iconsax.moon),
                iconColor: Colors.black,
                onTap: () async {},
                title: const TextWidget(
                  label: "dark side",
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                controller: _listController,
                itemCount: chatProvider.getChatList.length, // chatList.length,
                itemBuilder: (context, index) {
                  return ChatWidget(
                    msg: chatProvider
                        .getChatList[index].message, // chatList[index].message,
                    chatIndex: chatProvider.getChatList[index]
                        .chatIndex, // chatList[index].chatIndex,
                  );
                },
              ),
            ),
            if (_isTyping) ...[
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
                            chatProvider: chatProvider,
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
                          chatProvider: chatProvider,
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

  Future<void> sendMessage({
    required ModelsProvider modelsProvider,
    required ChatProvider chatProvider,
  }) async {
    if (_isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(label: "you can't send more than one message"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (textEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(label: "Please enter a message"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    try {
      String message = textEditingController.text;
      setState(() {
        _isTyping = true;
        chatProvider.addUserChat(message: message);
        textEditingController.clear();
        // focusNode.unfocus();
        // chatList.add(
        // ChatModel(
        //   message: textEditingController.text,
        //   chatIndex: 0,
        // ),
        // );
      });
      await chatProvider.sendMsg(
        message: message,
        modelId: modelsProvider.getCurrentModel,
      );
      // chatList.addAll(
      //   await ApiService.sendMessage(
      //     message: textEditingController.text,
      //     modelId: modelsProvider.getCurrentModel,
      //   ),
      // );
      setState(() {});
    } catch (error) {
      log("error $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: TextWidget(label: error.toString()),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        scrollToBottom();
        _isTyping = false;
      });
    }
  }
}
