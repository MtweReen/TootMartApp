import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/splash.dart';
import 'business_logic/app_cubit/app_cubit.dart';
import 'core/constants/colors.dart';
import 'core/constants/constants.dart';
import 'core/router/router.dart';
import 'core/utiles/bloc_observer.dart';
import 'features/auth/data/business_logic/auth_cubit.dart';
import 'translations/codegen_loader.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await startShared();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
  ));

  BlocOverrides.runZoned(
        () =>  runApp(
          EasyLocalization(
            supportedLocales: const [Locale('ar', ''), Locale('en', '')],
            path: 'assets/translations',
            assetLoader: const CodegenLoader(),
            child: const MyApp(),
          ),
        ),
    blocObserver: MyBlocObserver(),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AppCubit()),
        BlocProvider(create: (BuildContext context) => AuthCubit()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        onGenerateRoute: onGenerateRoute,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          fontFamily: 'URW DIN Arabic',
          bottomNavigationBarTheme:
              const BottomNavigationBarThemeData(backgroundColor: Colors.white),
          scaffoldBackgroundColor: Colors.white,
          backgroundColor: Colors.white,
          // ignore: prefer_const_constructors
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              iconTheme: IconThemeData(color: kMainColor),
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
                statusBarBrightness: Brightness.dark,
              )),
          primaryColor: Colors.white,
        ),
        home: const SplshScreen(),
      ),
    );
  }
}
