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
              itemBuilder: (context, index) => buildFavoriteItem(ShopCubit.get(context).getFavoritesModel.data.data[index] , context),
              separatorBuilder: (context , index)=> buildSeparator(),
              itemCount: ShopCubit.get(context).getFavoritesModel.data.data.length
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
  Widget buildFavoriteItem(FavoritesData favoritesModel , context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: 120,
              child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children:[
                    Image(
                      image: NetworkImage(favoritesModel.product.image),
                      width: 120,
                      height: 120 ,
                    ),
                    if(favoritesModel.product.discount !=0)
                      Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(color: Colors.red[300],
                            borderRadius: BorderRadius.circular(25)
                        ),
                        child: Center(child: Text('DISCOUNT')),
                      )
                  ]
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(favoritesModel.product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Text(favoritesModel.product.price.toString(),
                          style: TextStyle(fontSize: 14, color: Colors.blueAccent),
                        ),
                        SizedBox(width: 5,),
                        if(0!=0)
                          Text(favoritesModel.product.oldPrice,
                            style: TextStyle(fontSize: 14,
                                decoration: TextDecoration.lineThrough,
                                color: Colors.blueAccent
                            ) ,
                          ),
                        Spacer(),
                        IconButton(
                            icon: CircleAvatar(
                                backgroundColor: ShopCubit.get(context).favorite[favoritesModel.product.id] ? defaultColor : Colors.grey,
                                child:
                                Icon(Icons.favorite_border_outlined, color: Colors.white,)),
                            onPressed: (){
                              ShopCubit.get(context).changeFavorites(favoritesModel.product.id);
                            }
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
