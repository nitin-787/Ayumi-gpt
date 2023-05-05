import 'package:chatgpt/config/size_config.dart';
import 'package:chatgpt/constants/text_widget.dart';
import 'package:flutter/material.dart';

class Suggestions extends StatelessWidget {
  const Suggestions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 125, bottom: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: screenHeight(70),
                width: screenWidth(118),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border: Border.all(
                    width: 1.0,
                    color: const Color(0xff666666),
                  ),
                  color: Colors.transparent,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      label: "Explain quantum\ncomputing in simple\n terms",
                      color: Theme.of(context).canvasColor,
                      fontSize: screenHeight(10),
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Container(
                height: screenHeight(70),
                width: screenWidth(118),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border: Border.all(
                    width: 1.0,
                    color: const Color(0xff666666),
                  ),
                  color: Colors.transparent,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      label: "Write a poetry for a\ngirl named Shivani",
                      color: Theme.of(context).canvasColor,
                      fontSize: screenHeight(10),
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: screenHeight(70),
                width: screenWidth(118),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border: Border.all(
                    width: 1.0,
                    color: const Color(0xff666666),
                  ),
                  color: Colors.transparent,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      label:
                          "Who is the master\nof Naruto and his\nfather in anime?",
                      color: Theme.of(context).canvasColor,
                      fontSize: screenHeight(11),
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Container(
                height: screenHeight(70),
                width: screenWidth(118),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border: Border.all(
                    width: 1.0,
                    color: const Color(0xff666666),
                  ),
                  color: Colors.transparent,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      label: "what is flutter? and\nwhich company\nmade it?",
                      color: Theme.of(context).canvasColor,
                      fontSize: screenHeight(11),
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: screenHeight(70),
                width: screenWidth(118),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border: Border.all(
                    width: 1.0,
                    color: const Color(0xff666666),
                  ),
                  color: Colors.transparent,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      label:
                          "Got any creative ideas\nfor a 10 year\n old’s birthday?",
                      color: Theme.of(context).canvasColor,
                      fontSize: screenHeight(10),
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Container(
                height: screenHeight(70),
                width: screenWidth(119),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border: Border.all(
                    width: 1.0,
                    color: const Color(0xff666666),
                  ),
                  color: Colors.transparent,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      label: "How do I make an HTTP\nrequest in Javascript?",
                      color: Theme.of(context).canvasColor,
                      fontSize: screenHeight(10),
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
