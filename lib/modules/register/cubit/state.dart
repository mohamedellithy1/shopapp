
import 'package:shopapp/models/login/login_model.dart';

abstract class ShopRegisterState{}
class ShopRegisterInitialState extends ShopRegisterState{}
class ShopLoadingRegisterState extends ShopRegisterState{}
class ShopRegisterSuccessesState extends ShopRegisterState{
  final LoginModel registerModel;

  ShopRegisterSuccessesState(this.registerModel);
}
class ShopRegisterErrorState extends ShopRegisterState{
  final String error;
  ShopRegisterErrorState(this.error);
}
class ShopPasswordState extends ShopRegisterState{}
class ShopSplashScreenState extends ShopRegisterState{}