import 'package:flutter/material.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';

showToast(BuildContext context, String text, {Duration? duration}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: duration ?? const Duration(seconds: 1),
      content: Text(text),
    ),
  );
}

Future<bool> showPlatformAlert({
  required String title,
  required String message,
  AlertButtonStyle buttonStyle = AlertButtonStyle.yesNo,
}) async {
  try {
    final clickedButton = await FlutterPlatformAlert.showAlert(
      windowTitle: title,
      text: message,
      alertStyle: buttonStyle,
    );

    if (clickedButton == AlertButton.yesButton) {
      print('User clicked Yes');
      return true;
    } else {
      print('User clicked No');
      return false;
    }
  } catch (e) {
    print('error getting platform alert $e');
    return true;
  }
}
