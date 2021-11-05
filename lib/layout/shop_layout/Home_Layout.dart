import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/cubit_Home/cubit.dart';
import 'package:shopapp/layout/shop_layout/cubit_Home/state.dart';
import 'package:shopapp/modules/search/searchScreen.dart';
import 'package:shopapp/modules/settings/settingScreen.dart';
class HomeLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopState>(
      listener: (context,state){

      },
      builder: (context,state){
        var cubit=ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title:Text("Salla",style: TextStyle(color: Colors.black),) ,
            actions: [
             if(cubit.currentIndex == 3)
               IconButton(icon: Icon(Icons.language),
                   onPressed: (){
                   }
               ),
              IconButton(icon: Icon(Icons.search),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>SearchScreen()));
                  })
            ],
          ),
          body:cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeScreen(index);
            },
            items: cubit.bottomItem,
          ),
        );
      },
    );
  }
}