import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/cubit_Home/cubit.dart';
import 'package:shopapp/layout/shop_layout/cubit_Home/state.dart';
class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopState>(
      listener: (context, state)=>{},
      builder: (context , state){
        ShopCubit cubit =ShopCubit();
        return Scaffold(
          appBar: AppBar(),
          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: cubit.bottomItem,
            onTap: (index){
              cubit.changeScreen(index);
            },
          ),
        );
      },
    );
  }
}
