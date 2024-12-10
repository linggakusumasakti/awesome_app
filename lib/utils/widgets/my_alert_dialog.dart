import 'package:awesome_app/utils/style/my_text_style.dart';
import 'package:flutter/material.dart';

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: Colors.black,
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  ),
);

Future<void> showMyDialog(BuildContext context, String message,
    {required VoidCallback onPressed}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Error'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text(message),
            ],
          ),
        ),
        actions: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                style: raisedButtonStyle,
                onPressed: onPressed,
                child: Text(
                  'OK',
                  style: MyTextStyle.body.copyWith(color: Colors.white),
                ),
              ),
            ],
          )
        ],
      );
    },
  );
}
