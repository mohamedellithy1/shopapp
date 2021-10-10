import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/Home_Layout.dart';
import 'package:shopapp/layout/shop_layout/cubit_Home/cubit.dart';
import 'package:shopapp/modules/login/login.dart';
import 'package:shopapp/modules/on_boarding/onBoarding.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';
import 'package:shopapp/shared/style/themes.dart';

import 'modules/login/cubit/bloc_observer.dart';
void main()async{
  //بيتاكد ان كل حاجه هنا ف الميثود خلصت و بعدين يفتح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer= MyBlocObserver();
  await DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  String token = CacheHelper.getData(key: 'token');
  if(onBoarding != null){
    if(token != null) widget = HomeLayout();
    else widget = LoginScreen();
  }else{
    widget = OnBoarding();
  }
  runApp(MyApp(startWidget: widget,));
}
class MyApp extends StatelessWidget {
  Widget  startWidget;
  MyApp({this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => ShopCubit() )
      ],
      child: MaterialApp(
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: ThemeMode.light,
                debugShowCheckedModeBanner: false,
                home: startWidget
            ),
    );
  }
}