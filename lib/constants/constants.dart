import 'package:chatgpt/constants/text_widget.dart';
import 'package:flutter/material.dart';

Color scaffoldBackgroundColor = Colors.grey;
Color? cardColor = Colors.blue[400];

List<String> models = [
  "MOdel-1",
  "Model-2",
  "Model-3",
  "Model-4",
  "Model-5",
  "Model-6",
  "Model-7",
];

List<DropdownMenuItem<String>>? getModelItem() {
  List<DropdownMenuItem<String>>? modelsitems =
      List<DropdownMenuItem<String>>.generate(
    models.length,
    (index) => DropdownMenuItem(
      value: models[index],
      child: TextWidget(
        label: models[index],
        fontSize: 16,
      ),
    ),
  );
  return modelsitems;
}

final chatMessages = [
  {
    "msg": "Hello who are you?",
    "chatIndex": 0,
  },
  {
    "msg":
        "Hello, I am ChatGPT, a large language model developed by OpenAI. I am here to assist you with any information or questions you may have. How can I help you today?",
    "chatIndex": 1,
  },
  {
    "msg": "What is flutter?",
    "chatIndex": 0,
  },
  {
    "msg":
        "Flutter is an open-source mobile application development framework created by Google. It is used to develop applications for Android, iOS, Linux, Mac, Windows, and the web. Flutter uses the Dart programming language and allows for the creation of high-performance, visually attractive, and responsive apps. It also has a growing and supportive community, and offers many customizable widgets for building beautiful and responsive user interfaces.",
    "chatIndex": 1,
  },
  {
    "msg": "Okay thanks",
    "chatIndex": 0,
  },
  {
    "msg":
        "You're welcome! Let me know if you have any other questions or if there's anything else I can help you with.",
    "chatIndex": 1,
  },
];
