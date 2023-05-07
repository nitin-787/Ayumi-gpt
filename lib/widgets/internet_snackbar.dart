import 'package:chatgpt/config/size_config.dart';
import 'package:chatgpt/constants/text_widget.dart';
import 'package:chatgpt/services/assets_manger.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:overlay_support/overlay_support.dart';

class InternetSnackBar {
  static void showTopSnackBar(BuildContext context) {
    // custom snackbar
    showOverlayNotification((context) {
      return Card(
        color: Theme.of(context).indicatorColor,
        margin: const EdgeInsets.only(
          left: 0,
          right: 0,
          bottom: 0,
        ),
        child: Container(
          padding: EdgeInsets.only(
            top: screenHeight(4),
            bottom: screenHeight(7),
          ),
          child: SafeArea(
            child: ListTile(
              leading: LottieBuilder.asset(
                Assetsmanager.internetAnimation,
              ),
              title: Center(
                child: TextWidget(
                  label: 'No Internet Connection',
                  fontSize: screenWidth(12),
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              // add image
              trailing: InkWell(
                onTap: () {
                  // close the snackbar
                  OverlaySupportEntry.of(context)?.dismiss();
                },
                child: Image.asset(
                  Assetsmanager.close,
                  height: screenWidth(30),
                  width: screenWidth(30),
                ),
              ),
            ),
          ),
        ),
      );
    }, duration: const Duration(seconds: 5));
  }
}

bool connectivitySnackBar(ConnectivityResult result) {
  final hasInternet = result != ConnectivityResult.none;
  return hasInternet;
}
