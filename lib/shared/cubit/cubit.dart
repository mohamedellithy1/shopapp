import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/login/login_model.dart';
import 'package:shopapp/shared/cubit/state.dart';
import 'package:shopapp/shared/network/end_points.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginState>{
  ShopLoginCubit(): super (ShopInitialState());
static ShopLoginCubit get(context) => BlocProvider.of(context);
void userLogin({
  @required String email,
  @required String password,
}) {
  emit(ShopLoadingLoginState());
  DioHelper.postData(url: Login, data:
  {
    'email': email,
    'password': password,
  },
  ).then((value) {
    print(value.data);
    UserData.fromJson(value.data);
    emit(ShopLoginSuccessesState());
  });
}
}