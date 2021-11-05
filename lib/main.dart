import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/Home_Layout.dart';
import 'package:shopapp/layout/shop_layout/cubit_Home/cubit.dart';
import 'package:shopapp/modules/login/login.dart';
import 'package:shopapp/modules/on_boarding/onBoarding.dart';
import 'package:shopapp/modules/splash/splash_Screen.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';
import 'package:shopapp/shared/style/themes.dart';

import 'models/login/cubit/bloc_observer.dart';
void main()async{
  //بيتاكد ان كل حاجه هنا ف الميثود خلصت و بعدين يفتح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer= MyBlocObserver();
  await DioHelper.init();
  await CacheHelper.init();

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // Widget  startWidget;
  MyApp();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) =>
        ShopCubit()..getHomeData()..getCateogries()..getFavoritesData()..getSettingProfile())
      ],
      child: MaterialApp(
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: ThemeMode.light,
                debugShowCheckedModeBanner: false,
                home: SplashScreen()
            ),
    );
  }
}