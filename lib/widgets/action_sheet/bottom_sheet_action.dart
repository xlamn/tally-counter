part of 'action_sheet.dart';

/// The Actions model that will use on the ActionSheet.
class BottomSheetAction {
  /// The primary content of the action sheet.
  ///
  /// Typically a [Text] widget.
  ///
  /// This should not wrap. To enforce the single line limit, use
  /// [Text.maxLines].
  final Widget title;

  /// The callback that is called when the action item is tapped. (required)
  final void Function(BuildContext context) onPressed;

  /// A widget to display after the title.
  ///
  /// Typically an [Icon] widget.
  final Widget? trailing;

  /// A widget to display before the title.
  ///
  /// Typically an [Icon] or a [CircleAvatar] widget.
  final Widget? leading;

  BottomSheetAction({
    required this.title,
    required this.onPressed,
    this.trailing,
    this.leading,
  });
}
