import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'constants/constants.dart';
import 'cubits/cubits.dart';
import 'helper/helper.dart';
import 'pages/pages.dart';
import 'repositories/repositories.dart';

void main() {
  setUp();
  runApp(const MyApp());
}

void setUp() {
  // Logging Settings
  final cubitDelegateFactory = CubitDelegateFactory();
  if (!cubitDelegateFactory.hasObserverSetup(Bloc.observer)) {
    Bloc.observer = cubitDelegateFactory.create();
  }

  // Status Bar Settings
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TallyGroupCubit(
            tallyCounterRepository: TallyCounterRepository(),
          )..loadTallyGroups(),
        ),
        BlocProvider(
          create: (context) => TallyCounterCubit(
            tallyGroupCubit: BlocProvider.of<TallyGroupCubit>(context),
            tallyCounterRepository: TallyCounterRepository(),
          )..loadTallyCounters(),
        ),
      ],
      child: DynamicColorBuilder(
        builder: ((lightColorScheme, darkColorScheme) {
          return MaterialApp(
            theme: ThemeData(
              fontFamily: "Poppins",
              colorScheme: lightColorScheme ?? ColorConstants.defaultLightColorScheme,
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              fontFamily: "Poppins",
              colorScheme: darkColorScheme ?? ColorConstants.defaultDarkColorScheme,
              useMaterial3: true,
            ),
            themeMode: ThemeMode.system,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('de', ''),
              Locale('se', ''),
            ],
            debugShowCheckedModeBanner: false,
            home: BlocBuilder<TallyCounterCubit, TallyCounterState>(
              builder: (context, state) {
                return Material(
                  child: PageView(
                    controller: PageConstants.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      TallyGroupsOverviewPage(),
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
