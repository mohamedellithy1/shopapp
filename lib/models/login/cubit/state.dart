
import 'package:shopapp/models/login/login_model.dart';

abstract class ShopLoginState{}
class ShopLoginInitialState extends ShopLoginState{}
class ShopLoadingLoginState extends ShopLoginState{}
class ShopLoginSuccessesState extends ShopLoginState{
  final LoginModel loginModel;

  ShopLoginSuccessesState(this.loginModel);
}
class ShopLoginErrorState extends ShopLoginState{
  final String error;
  ShopLoginErrorState(this.error);
}
class ShopLoginPasswordState extends ShopLoginState{}
class ShopSplashScreenState extends ShopLoginState{}