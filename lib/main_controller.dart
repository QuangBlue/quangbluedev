import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class MainController extends GetxController {
  final GlobalKey<State<StatefulWidget>> topBannerKey = GlobalKey();
  final GlobalKey<State<StatefulWidget>> summaryKey = GlobalKey();
  final GlobalKey<State<StatefulWidget>> whatIsDoKey = GlobalKey();
  final GlobalKey<State<StatefulWidget>> whatIDidKey = GlobalKey();
  final GlobalKey<State<StatefulWidget>> languageKey = GlobalKey();
  final GlobalKey<State<StatefulWidget>> frameworkSDKKey = GlobalKey();
  final GlobalKey<State<StatefulWidget>> aboutMeKey = GlobalKey();
  final GlobalKey<State<StatefulWidget>> contactMeKey = GlobalKey();
  final GlobalKey<State<StatefulWidget>> footerKey = GlobalKey();

  Future<void> scrollToItem(GlobalKey key) async {
    final BuildContext context = key.currentContext!;

    await Scrollable.ensureVisible(
      context,
      duration: const Duration(
        seconds: 1,
      ),
      curve: Curves.easeIn,
    );
  }
}
