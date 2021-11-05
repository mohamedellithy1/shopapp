import 'package:shopapp/models/Favorite_model/favorites_model.dart';
import 'package:shopapp/models/login/login_model.dart';
abstract class ShopState{}
class ShopInitialState extends ShopState{}
class ShopChangeBottomNavState extends ShopState{}
class ShopLoadingHomeGetData extends ShopState{}
class ShopSuccessHomeGetData extends ShopState{}
class ShopErrorHomeGetData extends ShopState{
  final error;
  ShopErrorHomeGetData({this.error});
}
class ShopSuccessGEtCateogriesData extends ShopState{}
class ShopErrorGEtCateogriesData extends ShopState{
  final error;
  ShopErrorGEtCateogriesData({this.error});
}
class ShopSuccessChangeFavoriteData extends ShopState{
  final ChangeFavoriteModel changeFavoriteModel;

  ShopSuccessChangeFavoriteData(this.changeFavoriteModel);
}
class ShopLoadingChangeFavoriteData extends ShopState{
}
class ShopErrorChangeFavoriteData extends ShopState{
  final error;
  ShopErrorChangeFavoriteData({this.error});
}
class ShopLoadingGetFavoritesData extends ShopState{}
class ShopSuccessGetFavoritesData extends ShopState{}
class ShopErrorGetFavoritesData extends ShopState{
  final error;
  ShopErrorGetFavoritesData({this.error});
}
class ShopLoadingGetSettingData extends ShopState{}
class ShopSuccessGetSettingData extends ShopState{
  final LoginModel loginModel;
  ShopSuccessGetSettingData(this.loginModel);
}
class ShopErrorGetSettingData extends ShopState{
  final error;
  ShopErrorGetSettingData({this.error});
}class ShopLoadingUpdateProfileData extends ShopState{}
class ShopSuccessUpdateProfileData extends ShopState{
  final LoginModel loginModel;
  ShopSuccessUpdateProfileData(this.loginModel);
}
class ShopErrorUpdateProfileData extends ShopState{
  final error;
  ShopErrorUpdateProfileData({this.error});
}
class ShopLoadingDrown extends ShopState{}
class ShopSuccessDrown extends ShopState{}