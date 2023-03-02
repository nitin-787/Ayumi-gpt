import 'package:chatgpt/constants/constants.dart';
import 'package:chatgpt/constants/text_widget.dart';
import 'package:chatgpt/widgets/drop_down.dart';
import 'package:flutter/material.dart';

class Services {
  static Future<void> showModelSheet({required BuildContext context}) async {
    await showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      backgroundColor: scaffoldBackgroundColor,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Flexible(
                child: TextWidget(
                  label: 'Choose Model',
                  fontSize: 16,
                ),
              ),
              Flexible(
                flex: 2,
                child: DropDownWidget(),
              )
            ],
          ),
        );
      },
    );
  }
}
