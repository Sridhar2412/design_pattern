import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class CustomDialog {
  const CustomDialog();
  String getName();
  Widget create(BuildContext context);
  Future<void> show(BuildContext context) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: create,
      );
}

class AndroidDialog extends CustomDialog {
  @override
  Widget create(BuildContext context) {
    return AlertDialog(
      title: Text(getName()),
      content: const Text('This is the material-style alert dialog!'),
      actions: <Widget>[
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Close'),
        ),
      ],
    );
  }

  @override
  String getName() => 'Android Dialog';
}

class IosDialog extends CustomDialog {
  @override
  Widget create(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(getName()),
      content: const Text('This is the material-style alert dialog!'),
      actions: <Widget>[
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Close'),
        ),
      ],
    );
  }

  @override
  String getName() => 'iOS Dialog';
}

enum Platform { ANDROID, IOS }
