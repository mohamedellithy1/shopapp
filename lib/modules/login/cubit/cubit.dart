import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/Home_Layout.dart';
import 'package:shopapp/models/login/login_model.dart';
import 'package:shopapp/modules/login/cubit/state.dart';
import 'package:shopapp/shared/network/end_points.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';
class ShopLoginCubit extends Cubit<ShopLoginState>{
  ShopLoginCubit(): super (ShopInitialState());
static ShopLoginCubit get(context) => BlocProvider.of(context);

LoginModel loginModel;
  IconData suffix = Icons.visibility_outlined;
  bool hide = true;
void userLogin({
  @required String email,
  @required String password,
  context,
}) {
  emit(ShopLoadingLoginState());
  DioHelper.postData(url: Login, data:
  {
    'email': email,
    'password': password,
  },
  ).then((value) {
    print(value.data);
    loginModel = LoginModel.fromJson(value.data);
    emit(ShopLoginSuccessesState(loginModel));
  }).catchError((error){
    emit(ShopLoginErrorState(error.toString()));
  });
}
  void changePasswordState() {
    hide = !hide;
    suffix = hide ? Icons.visibility : Icons.visibility_off;
    emit(ShopPasswordState());
  }
}
