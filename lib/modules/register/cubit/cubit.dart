import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/login/login_model.dart';
import 'package:shopapp/modules/register/cubit/state.dart';
import 'package:shopapp/shared/network/end_points.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';
class ShopRegisterCubit extends Cubit<ShopRegisterState>{
  ShopRegisterCubit(): super (ShopRegisterInitialState());
static ShopRegisterCubit get(context) => BlocProvider.of(context);

LoginModel registerModel;
  IconData suffix = Icons.visibility_outlined;
  bool hide = true;
void userRegister({
  @required String email,
  @required String password,
  @required String name,
  @required String phone,
  context,
}) {
  emit(ShopLoadingRegisterState());
  DioHelper.postData(url: Register, data:
  {
    'name': name,
    'phone':phone,
    'email': email,
    'password': password,
  },
  ).then((value) {
    print(value.data);
    registerModel = LoginModel.fromJson(value.data);
    emit(ShopRegisterSuccessesState(registerModel));
  }).catchError((error){
    emit(ShopRegisterErrorState(error.toString()));
  });
}
  void changePasswordState() {
    hide = !hide;
    suffix = hide ? Icons.visibility : Icons.visibility_off;
    emit(ShopPasswordState());
  }
}
