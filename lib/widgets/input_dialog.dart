import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

void showInputDialog(
  BuildContext context, {
  required String title,
  String cancelText = 'Cancel',
  required String actionText,
  required Function action,
}) async {
  PageConstants.groupTitleController.value = const TextEditingValue();
  final ValueNotifier<bool> enableCreateButton = ValueNotifier(false);

  if (!Platform.isIOS) {
    return showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              maxLines: 1,
              cursorColor: Colors.blue,
              onChanged: (value) =>
                  value.isNotEmpty ? enableCreateButton.value = true : enableCreateButton.value = false,
              controller: PageConstants.groupTitleController,
              decoration: InputDecoration(
                hintText: "Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                ),
                fillColor: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.05),
                filled: true,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: Text(
              cancelText,
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
            onPressed: () => Navigator.of(dialogContext).pop(false),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: enableCreateButton,
            builder: (context, value, child) => TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: value ? Colors.blue : Colors.grey,
                ),
                onPressed: value
                    ? () {
                        action();
                        Navigator.of(dialogContext).pop(true);
                      }
                    : null,
                child: Text(
                  actionText,
                  style: TextStyle(
                    color: value ? Colors.blue : Colors.grey,
                  ),
                )),
          ),
        ],
      ),
    );
  }

  return showCupertinoDialog(
    context: context,
    builder: (dialogContext) => CupertinoAlertDialog(
      title: Text(title),
      content: Container(
        padding: const EdgeInsets.only(
          top: SizeConstants.normal,
        ),
        child: CupertinoTextFormFieldRow(
          onChanged: (value) => value.isNotEmpty ? enableCreateButton.value = true : enableCreateButton.value = false,
          padding: EdgeInsets.zero,
          controller: PageConstants.groupTitleController,
          cursorColor: CupertinoColors.systemBlue,
          placeholder: "Name",
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: CupertinoDynamicColor.withBrightness(
                color: Color(0xCCF2F2F2),
                darkColor: Color(0xBF1E1E1E),
              )),
        ),
      ),
      actions: <Widget>[
        CupertinoDialogAction(
          isDestructiveAction: true,
          child: Text(cancelText),
          onPressed: () => Navigator.of(dialogContext).pop(false),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: enableCreateButton,
          builder: (context, value, child) => CupertinoDialogAction(
            onPressed: value
                ? () {
                    action();
                    Navigator.of(dialogContext).pop(true);
                  }
                : null,
            child: Text(
              actionText,
              style: TextStyle(
                color: value ? CupertinoColors.activeBlue : CupertinoColors.inactiveGray,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}