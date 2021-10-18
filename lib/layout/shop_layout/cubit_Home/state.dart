import 'package:shopapp/models/Favorite_model/favorites_model.dart';

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


