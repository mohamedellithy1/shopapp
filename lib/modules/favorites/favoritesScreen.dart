import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/cubit_Home/cubit.dart';
import 'package:shopapp/layout/shop_layout/cubit_Home/state.dart';
import 'package:shopapp/models/get_favorite_model/Get_Favorite_model.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/style/color.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopState>(
      listener: (context , state) {
      },
      builder: (context, state){
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesData ,
          builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildProductItem(ShopCubit.get(context).getFavoritesModel.data.data[index].product , context),
              separatorBuilder: (context , index)=> buildSeparator(),
              itemCount: ShopCubit.get(context).getFavoritesModel.data.data.length
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
