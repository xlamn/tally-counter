import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../constants/constants.dart';
import '../helper/color_controller.dart';

class FormColorField extends StatefulWidget {
  final String title;
  final ColorController colorController;

  const FormColorField({
    super.key,
    required this.title,
    required this.colorController,
  });

  @override
  State<FormColorField> createState() => _FormColorFieldState();
}

class _FormColorFieldState extends State<FormColorField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: SizeConstants.large,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              bottom: SizeConstants.normalSmaller,
            ),
            child: Text(
              widget.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.grey),
                borderRadius: BorderRadius.circular(
                  RadiusConstants.large,
                ),
                color: PageConstants.groupColorController.value,
              ),
              height: 55,
              width: 55,
            ),
            onTap: () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: SizedBox(
                    height: 300,
                    child: BlockPicker(
                      pickerColor: widget.colorController.value ?? Colors.black,
                      availableColors: ColorConstants.tallyGroupColors,
                      onColorChanged: (color) {
                        setState(() {
                          widget.colorController.setValue(color);
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
