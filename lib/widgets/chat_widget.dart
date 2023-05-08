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
    final bool isSender = chatIndex == 0;
    final Color boxColor = isSender
        ? const Color.fromARGB(255, 157, 80, 215)
        : Theme.of(context).indicatorColor;
    const Color textColor = Colors.white;

    final DateFormat formatter = DateFormat('h:mm a');

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment:
            isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: boxColor,
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        label: msg,
                        fontSize: 16,
                        color: textColor,
                        maxLines: null,
                        overflow: TextOverflow.clip,
                      ),
                      const SizedBox(height: 4),
                      TextWidget(
                        label: formatter.format(DateTime.now()),
                        fontSize: 12,
                        color: textColor.withOpacity(0.5),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
