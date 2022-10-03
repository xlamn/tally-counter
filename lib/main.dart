import 'package:dynamic_color/dynamic_color.dart';
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

  static final _defaultLightColorScheme = ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
  );
  static final _defaultDarkColorScheme = ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TallyCounterCubit(
        tallyCounterRepository: TallyCounterRepository(),
      )..loadTallyCounters(),
      child: DynamicColorBuilder(
        builder: ((lightColorScheme, darkColorScheme) {
          return MaterialApp(
            theme: ThemeData(
              colorScheme: lightColorScheme ?? _defaultLightColorScheme,
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              colorScheme: darkColorScheme ?? _defaultDarkColorScheme,
              useMaterial3: true,
            ),
            themeMode: ThemeMode.system,
            debugShowCheckedModeBanner: false,
            home: BlocBuilder<TallyCounterCubit, TallyCounterState>(
              builder: (context, state) {
                return Material(
                  child: PageView(
                    controller: PageConstants.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      TallyCountersOverViewPage(),
                      TallyCounterPage(),
                    ],
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
