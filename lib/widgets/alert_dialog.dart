import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showAlertDialog(
  BuildContext context, {
  required String title,
  required String description,
  String cancelText = 'Cancel',
  required String actionText,
  required Function action,
}) async {
  if (!Platform.isIOS) {
    return showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(description),
        actions: <Widget>[
          TextButton(
            child: Text(cancelText),
            onPressed: () => Navigator.of(dialogContext).pop(false),
          ),
          TextButton(
              child: Text(actionText),
              onPressed: () {
                action();
                Navigator.of(dialogContext).pop(true);
              }),
        ],
      ),
    );
  }

  return showCupertinoDialog(
    context: context,
    builder: (dialogContext) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(description),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text(cancelText),
          onPressed: () => Navigator.of(dialogContext).pop(false),
        ),
        CupertinoDialogAction(
            isDestructiveAction: true,
            child: Text(actionText),
            onPressed: () {
              action();
              Navigator.of(dialogContext).pop(true);
            }),
      ],
    ),
  );
}
