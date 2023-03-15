import 'package:flutter/material.dart';

import '../models/models.dart';

class TallyGroupController extends ChangeNotifier {
  TallyGroupController({this.value});
  TallyGroup? value;

  void setValue(TallyGroup? value) {
    this.value = value;
    notifyListeners();
  }
}
