import 'package:chatgpt/constants/constants.dart';
import 'package:chatgpt/constants/text_widget.dart';
import 'package:chatgpt/services/assets_manger.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    super.key,
    required this.msg,
    required this.chatIndex,
  });

  final String msg;
  final int chatIndex;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: chatIndex == 0 ? scaffoldBackgroundColor : cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  chatIndex == 0 ? Assetsmanager.avatar : Assetsmanager.bot,
                  height: 40,
                  width: 40,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextWidget(
                    label: msg,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
