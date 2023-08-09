import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../constants/constants.dart';
import '../helper/color_controller.dart';

class FormColorField extends StatefulWidget {
  final String title;
  final ColorController colorController;

  const FormColorField({
    Key? key,
    required this.title,
    required this.colorController,
  }) : super(key: key);

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
          Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 0.4),
                borderRadius: BorderRadius.circular(50.0),
                color: PageConstants.groupColorController.value,
              ),
              height: 50,
              width: 70,
            ),
            onTap: () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: SingleChildScrollView(
                    child: BlockPicker(
                      pickerColor: widget.colorController.value ?? Colors.black,
                      // availableColors: [],
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