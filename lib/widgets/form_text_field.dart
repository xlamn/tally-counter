import 'package:flutter/material.dart';

import '../constants/constants.dart';

class FormTextField extends StatefulWidget {
  final String title;
  final int? length;
  final TextEditingController? textController;

  const FormTextField({
    super.key,
    required this.title,
    this.length,
    this.textController,
  });

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
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
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: SizeConstants.small,
          ),
          TextFormField(
            maxLines: 1,
            cursorColor: Colors.blue,
            controller: widget.textController,
            maxLength: widget.length,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(
                SizeConstants.normal,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  RadiusConstants.large,
                ),
                borderSide: const BorderSide(width: 0, style: BorderStyle.none),
              ),
              fillColor: Theme.of(context).textTheme.bodySmall!.color!.withValues(alpha: 0.05),
              filled: true,
            ),
          )
        ],
      ),
    );
  }
}
