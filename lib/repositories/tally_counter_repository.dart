import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';

class TallyCounterRepository {
  //Tally Groups

  Future<void> saveTallyGroups(List<TallyGroup> tallyGroups) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> tallyGroupsEncoded = tallyGroups.map((tallyGroup) => jsonEncode(tallyGroup.toJson())).toList();
    await prefs.setStringList('tallyGroups', tallyGroupsEncoded);
  }

  Future<List<TallyGroup>> getTallyGroups() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> tallyGroupsEncoded = prefs.getStringList('tallyGroups') ?? [];
    if (tallyGroupsEncoded.isNotEmpty) {
      return tallyGroupsEncoded.map((tallyGroup) => TallyGroup.fromJson(jsonDecode(tallyGroup))).toList();
    } else {
      return [];
    }
  }

  // Tally Counters

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

  Future<void> saveLastTallyCounterPosition(int position) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('tallyCounter_position', position);
  }

  Future<int> getLastTallyCounterPosition() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('tallyCounter_position') ?? 0;
  }
}
