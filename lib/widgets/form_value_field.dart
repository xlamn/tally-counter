import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/constants.dart';
import 'widgets.dart';

class FormValueField extends StatefulWidget {
  final String title;
  final int? length;
  final TextEditingController? valueController;

  const FormValueField({
    super.key,
    required this.title,
    this.length,
    this.valueController,
  });

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
          Stack(
            alignment: Alignment.center,
            children: [
              TextFormField(
                maxLines: 1,
                cursorColor: Colors.blue,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
                controller: widget.valueController,
                maxLength: widget.length,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(
                    SizeConstants.normal,
                  ),
                  counterText: '',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      RadiusConstants.large,
                    ),
                    borderSide: const BorderSide(width: 0, style: BorderStyle.none),
                  ),
                  fillColor: Theme.of(context).textTheme.bodySmall!.color!.withValues(alpha: 0.05),
                  filled: true,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: SizeConstants.xSmall,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    StepButton(
                      color: Colors.red,
                      icon: FaIcon(
                        FontAwesomeIcons.arrowDown,
                        color: Colors.red.withValues(alpha: 0.8),
                      ),
                      onPressed: () => _onPressed(isUp: false),
                    ),
                    StepButton(
                      color: Colors.green,
                      icon: const FaIcon(
                        FontAwesomeIcons.arrowUp,
                        color: Colors.green,
                      ),
                      onPressed: () => _onPressed(isUp: true),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onPressed({required bool isUp}) {
    int currentValue = int.parse(widget.valueController!.text);
    isUp ? currentValue++ : currentValue--;
    widget.valueController!.text = (currentValue).toString();
  }
}
