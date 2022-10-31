import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:toot_mart/business_logic/cart/cart_cubit.dart';
import 'package:toot_mart/business_logic/category/category_cubit.dart';
import 'package:toot_mart/business_logic/home/home_cubit_cubit.dart';
import 'package:toot_mart/business_logic/setting/setting_cubit.dart';
import 'package:toot_mart/business_logic/social/socialCubit.dart';
import 'package:toot_mart/features/auth/data/business_logic/auth_cubit.dart';
import 'package:toot_mart/features/checkout/business_logic/check_out_cubit.dart';
import 'package:toot_mart/splash.dart';
import 'business_logic/app_cubit/app_cubit.dart';
import 'core/constants/colors.dart';
import 'core/constants/constants.dart';
import 'core/network/local/cache_helper.dart';
import 'core/network/remote/dio_helper.dart';
import 'core/router/router.dart';
import 'core/utiles/bloc_observer.dart';
import 'features/map/map_provider.dart';
import 'translations/codegen_loader.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  await DioHelper.init();
  await CasheHelper.init();
  await startShared();
  await mapIcon();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
  ));

  BlocOverrides.runZoned(
    () => runApp(
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

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    CasheHelper.getToken();
  }

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create: (context) => MapProvider()..start(),
      builder:(context,child)=> MultiBlocProvider(
          providers: [
            BlocProvider<AppCubit>(create: (BuildContext context) => AppCubit()..getIntro()),
            BlocProvider<AuthCubit>(create: (BuildContext context) => AuthCubit()..getUser()),
            BlocProvider<SocialCubit>(
                create: (BuildContext context) => SocialCubit()),
            BlocProvider<CartCubit>(create: (BuildContext context) => CartCubit()),
            BlocProvider<CheckOutCubit>(
                create: (BuildContext context) => CheckOutCubit()..getAreas()),
            BlocProvider<SettingCubit>(
                create: (BuildContext context) => SettingCubit()
                  ..privacypolicy()
                  ..refundsPolicy()),
            BlocProvider<HomeCubitCubit>(
                create: (BuildContext context) => HomeCubitCubit()
                  ..getHomeItems()
                  ..getRooms()),
            BlocProvider(
              create: (BuildContext context) => CategoryCubit(),
            ),
          ],
          // child: ChangeNotifierProvider(
          //   create: (context) => MapProvider(),
            child: MaterialApp(
              navigatorKey: navigatorKey,
              onGenerateRoute: onGenerateRoute,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              theme: ThemeData(
                fontFamily: 'URW DIN Arabic',
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    backgroundColor: Colors.white),
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
                primaryColor: Colors.white, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kMainColor),
              ),
              home: const SplshScreen(),
            ),
          // ),
        
      ),
    );
  }
}
