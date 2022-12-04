import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/cubits.dart';
import '../../enums/enums.dart';
import '../../extensions/extensions.dart';
import '../../widgets/action_sheet/action_sheet.dart';

void showResetActionSheet(
  BuildContext context, {
  Function? backgroundColorAnimation,
}) {
  showActionSheet(
    context,
    actions: [
      BottomSheetAction(
        title: Text(
          context.local.reset.toCapitalized(),
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        onPressed: (context) {
          Navigator.pop(context);
          context.read<TallyCounterCubit>().updateCount(
                action: TallyCounterAction.reset,
              );
          if (backgroundColorAnimation != null) backgroundColorAnimation(TallyCounterAction.reset);
          HapticFeedback.mediumImpact();
        },
      ),
    ],
    cancelAction: CancelAction(
      title: Text(
        context.local.cancel.toCapitalized(),
      ),
    ),
  );
}
