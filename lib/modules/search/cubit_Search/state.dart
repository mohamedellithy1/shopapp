abstract class ShopSearchState{}
class ShopSearchInitialState extends ShopSearchState{}
class ShopLoadingSearchData extends ShopSearchState{}
class ShopSuccessSearchData extends ShopSearchState{}
class ShopErrorSearchData extends ShopSearchState{
  final error;
  ShopErrorSearchData({this.error});
}