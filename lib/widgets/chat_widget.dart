import 'package:chatgpt/constants/constants.dart';
import 'package:chatgpt/constants/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    final DateFormat formatter = DateFormat('h:mm a');

    return Row(
      mainAxisAlignment:
          chatIndex == 0 ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: chatIndex == 0 ? darkPrimary : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(chatIndex == 0 ? 16 : 0),
              topRight: const Radius.circular(16),
              bottomLeft: Radius.circular(chatIndex == 0 ? 0 : 16),
              bottomRight: const Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              chatIndex == 1
                  ? TextWidget(
                      label: "Ayumi",
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 4),
              TextWidget(
                label: msg,
                // maxLines: 5,
                fontSize: 16,
                color: chatIndex == 0 ? Colors.white : Colors.black,
              ),
              const SizedBox(height: 4),
              TextWidget(
                label: formatter.format(DateTime.now()),
                fontSize: 12,
                color: Colors.grey.shade500,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
