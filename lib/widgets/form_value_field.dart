import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../models/models.dart';

class FormValueField extends StatefulWidget {
  final TallyCounter tallyCounter;
  final String title;
  final int? length;
  final TextEditingController? valueController;

  const FormValueField({
    Key? key,
    required this.tallyCounter,
    required this.title,
    this.length,
    this.valueController,
  }) : super(key: key);

  @override
  State<FormValueField> createState() => _FormValueFieldState();
}

class _FormValueFieldState extends State<FormValueField> {
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
            controller: widget.valueController,
            maxLength: widget.length,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              counterText: '',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(width: 0, style: BorderStyle.none),
              ),
              fillColor: Theme.of(context).textTheme.bodySmall!.color!.withOpacity(0.05),
              filled: true,
            ),
          )
        ],
      ),
    );
  }
}
