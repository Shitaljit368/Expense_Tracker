import 'package:exptracker/AppBarTheme/custom_theme.dart';
import 'package:exptracker/Color_Themes/dark_theme.dart';
import 'package:exptracker/Constant/colors.dart';
import 'package:exptracker/Src/Router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Core/cubit/authflow_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    statusBarIconBrightness: Brightness.light,
    statusBarColor: opBlack,
  ));
  FlutterNativeSplash.remove();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AuthflowCubit(),
        ),
      ],
      child: MyAppPage(),
    ),
  );
}

class MyAppPage extends StatelessWidget {
  MyAppPage({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      builder: EasyLoading.init(),
      theme: themeData,
      darkTheme: darkTheme ,
    );
  }
}
