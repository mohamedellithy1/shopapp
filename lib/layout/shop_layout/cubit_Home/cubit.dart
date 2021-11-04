import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/cubit_Home/state.dart';
import 'package:shopapp/models/Favorite_model/favorites_model.dart';
import 'package:shopapp/models/cateogries_model/cateogries_model.dart';
import 'package:shopapp/models/get_favorite_model/Get_Favorite_model.dart';
import 'package:shopapp/models/home_model/home_model.dart';
import 'package:shopapp/models/login/login_model.dart';
import 'package:shopapp/modules/cateogries/cateogriesScreen.dart';
import 'package:shopapp/modules/favorites/favoritesScreen.dart';
import 'package:shopapp/modules/products/productScreen.dart';
import 'package:shopapp/modules/settings/settingScreen.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/network/end_points.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopState>{
  ShopCubit(): super (ShopInitialState());
  static ShopCubit get(context)=> BlocProvider.of(context);
  int currentIndex = 0;
  List<BottomNavigationBarItem>bottomItem =[
BottomNavigationBarItem(icon: Icon(Icons.home) ,label: 'Home' ),
BottomNavigationBarItem(icon:Icon(Icons.apps),label: 'Categories' ),
BottomNavigationBarItem(icon: Icon(Icons.favorite) ,label: 'Favorite' ),
BottomNavigationBarItem(icon: Icon(Icons.settings) ,label: 'Settings' ),
  ];
  List <Widget> bottomScreen =[
    ProductScreen(),
    CateogriesScreen(),
    FavoritesScreen(),
    SettingScreen(),
  ];
  void changeScreen(int index ){
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }
  HomeModel homeModel;
  CategoriesModel cateogriesModel;
  Map<int , bool> favorite ={};
  void getHomeData(){
    emit(ShopLoadingHomeGetData());
    DioHelper.getData(url: Home, token: CacheHelper.getData(key: 'token')).then((value){
      homeModel = HomeModel.fromJson(value.data);
      homeModel.data.products.forEach((element) {
        favorite.addAll({
        element.id : element.in_favorites
        }
        );
      });
      print(favorite);
      emit(ShopSuccessHomeGetData());
    }).catchError((error){
      emit(ShopErrorHomeGetData(error: error.toString()));
    });
  }
  void getCateogries(){
    DioHelper.getData(url: Get_Cateogries, token: token).then((value){
      cateogriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessGEtCateogriesData());
    }).catchError((error){
      emit(ShopErrorGEtCateogriesData(error: error.toString()));
    });
  }
  LoginModel loginModel;
  ChangeFavoriteModel changeFavoriteModel;
  void changeFavorites(int productId){
    favorite[productId] = !favorite[productId];
    emit(ShopLoadingChangeFavoriteData());
    DioHelper.postData(
        url: Favorite,
        data: {
          'product_id': productId
        },
      token: CacheHelper.getData(key: 'token')
    ).then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
      if(!changeFavoriteModel.status){
        favorite[productId]=!favorite[productId];
      }else{
        getFavoritesData();
      }
      print(changeFavoriteModel.message);
      print(favorite[productId]);
      print(value.data);
      emit(ShopSuccessChangeFavoriteData(changeFavoriteModel));
    }
    ).catchError((error){
      favorite[productId]=!favorite[productId];
      emit(ShopErrorChangeFavoriteData());
    }
    );
  }
  GetFavoritesModel getFavoritesModel ;
  void getFavoritesData(){
    emit(ShopLoadingGetFavoritesData());
    DioHelper.getData(url: Favorite , token: CacheHelper.getData(key: 'token')
    ).then((value) {
      getFavoritesModel = GetFavoritesModel.fromJson(value.data);
      print(value.data);
      emit(ShopSuccessGetFavoritesData());
    }
    ).catchError((error){
      emit(ShopErrorGEtCateogriesData(error: error));
    });
  }
  LoginModel modelProfile ;
  void getSettingProfile(){
    emit(ShopLoadingGetSettingData());
    DioHelper.getData(url: profile , token: CacheHelper.getData(key: 'token')
    ).then((value) {
      modelProfile = LoginModel.fromJson(value.data);
      print(modelProfile.data.name);
      emit(ShopSuccessGetSettingData(modelProfile));
    }
    ).catchError((error){
      emit(ShopErrorGetSettingData(error: error));
    });
  }
}