import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/cubits.dart';
import '../../enums/enums.dart';
import '../../widgets/widgets.dart';

showResetDialog(
  BuildContext context, {
  Function? backgroundColorAnimation,
}) {
  showAlertDialog(
    context,
    title: 'Warning',
    description: 'Are you sure to reset the Counter?',
    cancelText: 'Cancel',
    actionText: 'Reset',
    action: () {
      context.read<TallyCounterCubit>().updateCount(
            action: TallyCounterAction.reset,
          );
      if (backgroundColorAnimation != null) backgroundColorAnimation(TallyCounterAction.reset);
      HapticFeedback.mediumImpact();
    },
  );
}
