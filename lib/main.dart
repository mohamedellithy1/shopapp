import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/splash/splash_Screen.dart';
import 'package:shopapp/shared/cubit/bloc_observer.dart';
import 'package:shopapp/shared/cubit/cubit.dart';
import 'package:shopapp/shared/cubit/state.dart';
import 'package:shopapp/shared/style/themes.dart';
void main(){
  runApp(MyApp());
  //بيتاكد ان كل حاجه هنا ف الميثود خلصت و بعدين يفتح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer= MyBlocObserver();
  // await CacheHelper.init();
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: ThemeMode.light,
              debugShowCheckedModeBanner: false,
              home: SplashScreen()
          );
  }
}