import 'dart:developer';
import 'package:url_launcher/url_launcher.dart';

class RedirectURL {
  Future<void> redirectUrl(Uri url) async {
    if (await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      log('url launched $url');
    } else {
      log('could not launch $url');
    }
  }

  void issueUrl() {
    redirectUrl(Uri(
      scheme: 'https',
      host: 'github.com',
      path: 'nitin-787/Ayumi-gpt/issues/new/choose/',
    ));
  }

  void developerUrl() {
    redirectUrl(Uri(
      scheme: 'https',
      host: 'github.com',
      path: 'nitin-787/',
    ));
  }

  void aboutUrl() {
    redirectUrl(Uri(
      scheme: 'https',
      host: 'nitin-787.github.io',
      path: 'Ayumi-gpt/',
    ));
  }
}
