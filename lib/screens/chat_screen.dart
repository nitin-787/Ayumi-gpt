import 'dart:async';
import 'dart:developer';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:chatgpt/config/size_config.dart';
import 'package:chatgpt/constants/text_widget.dart';
import 'package:chatgpt/providers/models_provider.dart';
import 'package:chatgpt/services/assets_manger.dart';
import 'package:chatgpt/services/redirect.dart';
import 'package:chatgpt/services/services.dart';
import 'package:chatgpt/widgets/chat_widget.dart';
import 'package:chatgpt/widgets/internet_snackbar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax/iconsax.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';

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

  var isListening = false;
  SpeechToText speechToText = SpeechToText();

  @override
  void initState() {
    _listController = ScrollController();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _listController.dispose();
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }
  // List<ChatModel> chatList = [];

  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);

    final brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Center(
          child: TextWidget(
            label: 'Ayumi',
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await Services.showModelSheet(context: context);
            },
            icon: const Icon(Iconsax.setting_2),
          ),
        ],
      ),
      drawer: Drawer(
        width: screenWidth(200),
        backgroundColor: Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      child: Image.asset(
                        Assetsmanager.ace,
                        height: 100,
                        width: 100,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          label: "Nex",
                          color: Theme.of(context).canvasColor,
                          fontSize: screenHeight((17)),
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextWidget(
                          label: "Nitin Sharma",
                          color: Theme.of(context).canvasColor,
                          fontWeight: FontWeight.w500,
                          fontSize: screenHeight(11),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                color: Theme.of(context).canvasColor,
                thickness: 1,
              ),
              SizedBox(
                height: screenHeight(14),
              ),
              ListTile(
                leading: const Icon(Iconsax.user_edit),
                iconColor: Theme.of(context).canvasColor,
                onTap: () async {
                  final result = await Connectivity().checkConnectivity();
                  if (!mounted) return;
                  bool hasInternet = connectivitySnackBar(result);
                  if (!hasInternet) {
                    InternetSnackBar.showTopSnackBar(context);
                  } else {
                    RedirectURL().developerUrl();
                  }
                },
                title: TextWidget(
                  label: "Developer",
                  fontWeight: FontWeight.w600,
                  fontSize: screenHeight(12.5),
                  color: Theme.of(context).canvasColor,
                ),
              ),
              ListTile(
                leading: const Icon(IconlyLight.document),
                iconColor: Theme.of(context).canvasColor,
                onTap: () async {
                  final result = await Connectivity().checkConnectivity();
                  if (!mounted) return;
                  bool hasInternet = connectivitySnackBar(result);
                  if (!hasInternet) {
                    InternetSnackBar.showTopSnackBar(context);
                  } else {
                    RedirectURL().aboutUrl();
                  }
                },
                title: TextWidget(
                  label: "About App",
                  fontWeight: FontWeight.w600,
                  fontSize: screenHeight(12.5),
                  color: Theme.of(context).canvasColor,
                ),
              ),
              ListTile(
                leading: const Icon(IconlyLight.star),
                iconColor: Theme.of(context).canvasColor,
                onTap: () async {},
                title: TextWidget(
                  label: "Rate App",
                  fontWeight: FontWeight.w600,
                  fontSize: screenHeight(12.5),
                  color: Theme.of(context).canvasColor,
                ),
              ),
              ListTile(
                leading: const Icon(IconlyLight.user),
                iconColor: Theme.of(context).canvasColor,
                onTap: () async {},
                title: TextWidget(
                  label: "Invite Friends",
                  fontWeight: FontWeight.w600,
                  fontSize: screenHeight(12.5),
                  color: Theme.of(context).canvasColor,
                ),
              ),
              ListTile(
                leading: const Icon(Iconsax.danger),
                iconColor: Theme.of(context).canvasColor,
                onTap: () async {
                  final result = await Connectivity().checkConnectivity();
                  if (!mounted) return;
                  bool hasInternet = connectivitySnackBar(result);
                  if (!hasInternet) {
                    InternetSnackBar.showTopSnackBar(context);
                  } else {
                    RedirectURL().issueUrl();
                  }
                },
                title: TextWidget(
                  label: "Report a problem",
                  fontWeight: FontWeight.w600,
                  fontSize: screenHeight(12.5),
                  color: Theme.of(context).canvasColor,
                ),
              ),
              ListTile(
                leading: const Icon(Iconsax.moon),
                iconColor: Theme.of(context).canvasColor,
                onTap: () async {},
                title: TextWidget(
                  label: "dark side",
                  fontWeight: FontWeight.w600,
                  fontSize: screenHeight(12.5),
                  color: Theme.of(context).canvasColor,
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
                itemCount: chatProvider.getChatList.length,
                itemBuilder: (context, index) {
                  return ChatWidget(
                    msg: chatProvider.getChatList[index].message,
                    chatIndex: chatProvider.getChatList[index].chatIndex,
                  );
                },
              ),
            ),
            // Builder(
            //   builder: (context) {
            //     if (chatProvider.getChatList.isEmpty) {
            //       return const Suggestions();
            //     } else {
            //       return Flexible(
            //         child: ListView.builder(
            //           controller: _listController,
            //           itemCount: chatProvider.getChatList.length,
            //           itemBuilder: (context, index) {
            //             return ChatWidget(
            //               msg: chatProvider.getChatList[index].message,
            //               chatIndex: chatProvider.getChatList[index].chatIndex,
            //             );
            //           },
            //         ),
            //       );
            //     }
            //   },
            // ),
            if (_isTyping) ...[
              SpinKitThreeBounce(
                color: Theme.of(context).indicatorColor,
                size: 23,
              ),
            ],
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              decoration: BoxDecoration(
                color: Theme.of(context).focusColor,
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                // theme detection bug
                boxShadow: isDarkMode
                    ? [
                        const BoxShadow(
                          color: Color.fromARGB(255, 21, 78, 163),
                          offset: Offset(0, 4),
                          blurRadius: 10,
                        ),
                      ]
                    : [
                        const BoxShadow(
                          color: Color.fromARGB(255, 171, 188, 214),
                          offset: Offset(0, 1),
                          blurRadius: 4,
                        ),
                      ],
              ),
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextField(
                          focusNode: focusNode,
                          style: const TextStyle(
                            fontFamily: 'Gilroy',
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Color(0xff666666),
                          ),
                          controller: textEditingController,
                          onSubmitted: (value) async {
                            await sendMessage(
                              chatProvider: chatProvider,
                              modelsProvider: modelsProvider,
                            );
                          },
                          decoration: InputDecoration.collapsed(
                            hintText: 'Ask me anything...',
                            hintStyle: TextStyle(
                              fontFamily: 'Gilroy',
                              fontWeight: FontWeight.w600,
                              fontSize: screenHeight(12.7),
                              color: Theme.of(context).canvasColor,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      AvatarGlow(
                        endRadius: 25,
                        animate: isListening,
                        glowColor: Colors.blue,
                        repeatPauseDuration: const Duration(milliseconds: 100),
                        repeat: true,
                        duration: const Duration(milliseconds: 2000),
                        showTwoGlows: true,
                        child: GestureDetector(
                          onTapDown: (details) async {
                            if (!isListening) {
                              var available = await speechToText.initialize();
                              if (available) {
                                setState(() {
                                  isListening = true;
                                  speechToText.listen(
                                    onResult: (result) {
                                      setState(() {
                                        textEditingController.text =
                                            result.recognizedWords;
                                        sendMessage(
                                          chatProvider: chatProvider,
                                          modelsProvider: modelsProvider,
                                        );
                                      });
                                    },
                                  );
                                });
                              }
                            }
                          },
                          onTapUp: (details) async {
                            setState(() {
                              isListening = false;
                            });
                            await speechToText.stop();
                            // await sendMessage(
                            //   chatProvider: chatProvider,
                            //   modelsProvider: modelsProvider,
                            // );
                          },
                          child: Icon(
                            isListening
                                ? Iconsax.microphone_25
                                : Iconsax.microphone,
                            size: 30,
                            color: Theme.of(context).indicatorColor,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          final result =
                              await Connectivity().checkConnectivity();
                          if (!mounted) return;
                          bool hasInternet = connectivitySnackBar(result);
                          if (!hasInternet) {
                            InternetSnackBar.showTopSnackBar(context);
                          } else {
                            await sendMessage(
                              modelsProvider: modelsProvider,
                              chatProvider: chatProvider,
                            );
                          }
                        },
                        icon: Icon(
                          size: 30,
                          Iconsax.send_15,
                          color: Theme.of(context).indicatorColor,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  void scrollToBottom() {
    Timer(
      const Duration(milliseconds: 300),
      () => _listController.animateTo(
        _listController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOut,
      ),
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
        focusNode.unfocus();
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
        memory: modelsProvider.hasMemory,
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
      var errorText = error.toString();
      // disable memory if max token reached
      if (errorText.toString().contains("max_length")) {
        errorText = "Max token reached, Memory is disabled for this session";
        modelsProvider.setMemoryEnabled(false);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: TextWidget(
            label: errorText,
          ),
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
