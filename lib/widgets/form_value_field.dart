import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/constants.dart';
import '../extensions/extensions.dart';
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
          Stack(
            alignment: Alignment.center,
            children: [
              TextFormField(
                maxLines: 1,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
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
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: SizeConstants.xSmall,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _ArrowButton(
                      color: Colors.red,
                      icon: FaIcon(
                        FontAwesomeIcons.arrowDown,
                        color: Colors.red.withOpacity(0.8),
                      ),
                      onPressed: () => onPressed(isUp: false),
                    ),
                    _ArrowButton(
                      color: Colors.green,
                      icon: const FaIcon(
                        FontAwesomeIcons.arrowUp,
                        color: Colors.green,
                      ),
                      onPressed: () => onPressed(isUp: true),
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

  void onPressed({required bool isUp}) {
    int currentValue = int.parse(widget.valueController!.text);
    isUp ? currentValue++ : currentValue--;
    widget.valueController!.text = (currentValue).toString();
  }
}

class _ArrowButton extends StatelessWidget {
  final Color color;
  final Widget icon;
  final void Function()? onPressed;

  const _ArrowButton({
    Key? key,
    required this.color,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: SizeConstants.xxSmall,
      ),
      margin: const EdgeInsets.all(SizeConstants.xSmall),
      decoration: BoxDecoration(
        color: color.withOpacity(context.isDarkMode ? 0.2 : 0.4),
        border: Border.all(
          color: color.withOpacity(0.5),
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        iconSize: SizeConstants.normal,
        icon: icon,
        onPressed: onPressed,
      ),
    );
  }
}
