import 'package:flutter/widgets.dart';

import '../enums/pages.dart';
import '../helper/helper.dart';

class PageConstants {
  static PageController pageController = PageController(
    initialPage: Pages.tallyCounterPage.value,
  );

  // counter

  static TextEditingController titleController = TextEditingController();

  static TextEditingController countController = TextEditingController();

  static TextEditingController stepController = TextEditingController();

  static TallyGroupController groupController = TallyGroupController();

  // group

  static TextEditingController groupTitleController = TextEditingController();

  static ColorController groupColorController = ColorController();
}
