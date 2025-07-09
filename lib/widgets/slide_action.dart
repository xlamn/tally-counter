import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../extensions/extensions.dart';
import '../constants/constants.dart';

class SlideAction extends StatelessWidget {
  final Widget child;
  final Function(BuildContext) onTap;
  final Color color;
  final Widget icon;
  final EdgeInsets padding;

  const SlideAction({
    super.key,
    required this.child,
    required this.onTap,
    required this.color,
    required this.icon,
    required this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(child.hashCode.toString()),
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const ScrollMotion(),
        children: [
          Builder(
            builder: (context) {
              return GestureDetector(
                onTap: () => onTap(context),
                child: Container(
                  margin: const EdgeInsets.only(left: SizeConstants.normalSmaller),
                  padding: padding,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: context.isDarkMode ? 0.3 : 0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        RadiusConstants.large,
                      ),
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(SizeConstants.normal),
                    child: icon,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      child: child,
    );
  }
}
