import 'package:chatgpt/config/size_config.dart';
import 'package:chatgpt/constants/constants.dart';
import 'package:chatgpt/constants/text_widget.dart';
import 'package:chatgpt/widgets/drop_down.dart';
import 'package:chatgpt/widgets/memory_switch.dart';
import 'package:flutter/material.dart';

class Services {
  static Future<void> showModelSheet({required BuildContext context}) async {
    await showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      backgroundColor: scaffoldBackgroundLight,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: TextWidget(
                      label: 'Choose Model',
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: screenHeight(12),
                    ),
                  ),
                  const Flexible(
                    flex: 2,
                    child: DropDownWidget(),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: TextWidget(
                      label: "Memory (consumes lots of tokens):",
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: screenHeight(12),
                    ),
                  ),
                  const Flexible(flex: 1, child: MemorySwitch()),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
