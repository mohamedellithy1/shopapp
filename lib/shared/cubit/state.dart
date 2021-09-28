abstract class ShopLoginState{}
class ShopInitialState extends ShopLoginState{}
class ShopLoadingLoginState extends ShopLoginState{}
class ShopLoginSuccessesState extends ShopLoginState{}
class ShopLoginErrorState extends ShopLoginState{
  final String error;
  ShopLoginErrorState(this.error);
}