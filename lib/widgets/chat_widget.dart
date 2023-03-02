import 'package:chatgpt/constants/constants.dart';
import 'package:chatgpt/services/assets_manger.dart';
import 'package:flutter/material.dart';


class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset(
                  Assetsmanager.avatar,
                  height: 40,
                  width: 40,
                ),
                const Text(
                  'Hello who are you?',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
