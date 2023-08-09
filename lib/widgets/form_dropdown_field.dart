import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/constants.dart';
import '../helper/helper.dart';
import '../models/models.dart';

class FormDropdownField extends StatefulWidget {
  final String title;
  final int? length;
  final List<TallyGroup> dropdownItems;
  final TallyGroupController controller;

  const FormDropdownField({
    Key? key,
    required this.title,
    required this.dropdownItems,
    required this.controller,
    this.length,
  }) : super(key: key);

  @override
  State<FormDropdownField> createState() => _FormDropdownFieldState();
}

class _FormDropdownFieldState extends State<FormDropdownField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: SizeConstants.small,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: SizeConstants.small,
          ),
          DropdownButtonFormField(
            value: widget.controller.value,
            decoration: InputDecoration(
              suffixIcon: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: SizeConstants.xSmall,
                ),
                child: IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.trashCan,
                      size: SizeConstants.normalLarger,
                      color: Colors.red.withOpacity(0.5),
                    ),
                    onPressed: () => {
                          setState(() {
                            widget.controller.setValue(null);
                          })
                        }),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(width: 0, style: BorderStyle.none),
              ),
              fillColor: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.05),
              filled: true,
            ),
            items: widget.dropdownItems.map((TallyGroup value) {
              return DropdownMenuItem<TallyGroup>(
                value: value,
                child: Text(value.title),
              );
            }).toList(),
            onChanged: (value) {
              widget.controller.setValue(value as TallyGroup);
            },
          ),
        ],
      ),
    );
  }
}
