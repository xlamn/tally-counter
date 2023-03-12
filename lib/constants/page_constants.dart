import 'package:flutter/widgets.dart';

import '../helper/helper.dart';

class PageConstants {
  static PageController pageController = PageController(
    initialPage: tallyCounterPage,
  );

  static const groupsOverviewPage = 0;
  static const tallyCountersOverviewPage = 1;
  static const tallyCounterPage = 2;

  static TextEditingController titleController = TextEditingController();

  static TextEditingController countController = TextEditingController();

  static TextEditingController stepController = TextEditingController();

  static TextEditingController groupTitleController = TextEditingController();

  static TallyGroupController groupController = TallyGroupController();

}
