import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../constants/constants.dart';
import '../extensions/extensions.dart';
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
                  actions: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.colorController.setValue(null);
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: SizeConstants.normal,
                          horizontal: SizeConstants.large,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(
                            RadiusConstants.large,
                          ),
                        ),
                        child: Text(
                          context.local.delete.toCapitalized(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
