import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';

class TallyCounterRepository {
  Future<void> saveTallyCounters(List<TallyCounter> tallyCounters) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> tallyCountersEncoded = tallyCounters.map((tallyCounter) => jsonEncode(tallyCounter.toJson())).toList();
    await prefs.setStringList('tallyCounters', tallyCountersEncoded);
  }

  Future<List<TallyCounter>> getTallyCounters() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> tallyCountersEncoded = prefs.getStringList('tallyCounters') ?? [];
    if (tallyCountersEncoded.isNotEmpty) {
      return tallyCountersEncoded.map((tallyCounter) => TallyCounter.fromJson(jsonDecode(tallyCounter))).toList();
    } else {
      return [TallyCounter()];
    }
  }
}
