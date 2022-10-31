import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/cubits.dart';
import '../../enums/enums.dart';
import '../../extensions/extensions.dart';
import '../../widgets/widgets.dart';

showResetDialog(
  BuildContext context, {
  Function? backgroundColorAnimation,
}) {
  showAlertDialog(
    context,
    title: context.local.warning.toCapitalized(),
    description: context.local.warningDescription,
    cancelText: context.local.cancel.toCapitalized(),
    actionText: context.local.reset.toCapitalized(),
    action: () {
      context.read<TallyCounterCubit>().updateCount(
            action: TallyCounterAction.reset,
          );
      if (backgroundColorAnimation != null) backgroundColorAnimation(TallyCounterAction.reset);
      HapticFeedback.mediumImpact();
    },
  );
}
