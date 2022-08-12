import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/cubits.dart';
import 'pages/pages.dart';
import 'repositories/repositories.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
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
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => TallyCounterCubit(
          tallyCounterRepository: TallyCounterRepository(),
        )..loadTallyCounters(),
        child: BlocBuilder<TallyCounterCubit, TallyCounterState>(
          builder: (context, state) {
            return TallyCounterPage(
              tallyCounter: state.tallyCounters.first,
            );
          },
        ),
      ),
    );
  }
}
