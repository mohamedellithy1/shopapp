import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/cubit_Home/state.dart';
import 'package:shopapp/modules/cateogries/cateogriesScreen.dart';
import 'package:shopapp/modules/favorites/favoritesScreen.dart';
import 'package:shopapp/modules/products/productScreen.dart';
import 'package:shopapp/modules/search/searchScreen.dart';

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
    SearchScreen(),
  ];
  void changeScreen(int index ){
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }
}