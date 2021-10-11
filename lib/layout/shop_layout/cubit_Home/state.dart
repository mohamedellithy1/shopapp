abstract class ShopState{}
class ShopInitialState extends ShopState{}
class ShopChangeBottomNavState extends ShopState{}
class ShopLoadingHomeGetData extends ShopState{}
class ShopSuccessHomeGetData extends ShopState{}
class ShopErrorHomeGetData extends ShopState{
  final error;
  ShopErrorHomeGetData({this.error});
}
