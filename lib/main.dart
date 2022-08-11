import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally_counter/repositories/tally_counter_repository.dart';

import 'cubits/cubits.dart';
import 'pages/pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => TallyCounterCubit(
          tallyCounterRepository: TallyCounterRepository(),
        )..loadTallyCounters(),
        child: BlocBuilder<TallyCounterCubit, TallyCounterState>(
          builder: (context, state) {
            return TallyPage(
              tallyCounter: state.tallyCounters.first,
            );
          },
        ),
      ),
    );
  }
}
