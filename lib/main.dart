import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally_counter/constants/constants.dart';

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
    return BlocProvider(
      create: (context) => TallyCounterCubit(
        tallyCounterRepository: TallyCounterRepository(),
      )..loadTallyCounters(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<TallyCounterCubit, TallyCounterState>(
          builder: (context, state) {
            return Material(
              child: PageView(
                controller: PageConstants.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  TallyCountersOverViewPage(
                    tallyCounters: state.tallyCounters,
                  ),
                  const TallyCounterPage(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
