import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/cubit_Home/cubit.dart';
import 'package:shopapp/layout/shop_layout/cubit_Home/state.dart';
import 'package:shopapp/shared/components/components.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopState>(
      listener: (context , state) {},
      builder: (context, state){
        return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder:(context , index)=> buildFavoriteItem(),
            separatorBuilder: (context , index)=> buildSeparator(),
            itemCount: 10
        );
      },
    );
  }
  Widget buildFavoriteItem(){
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
                      image: NetworkImage("https://student.valuxapps.com/storage/uploads/products/1615441020ydvqD.item_XXL_51889566_32a329591e022.jpeg"),
                      width: 120,
                      height: 120 ,
                      fit: BoxFit.cover,
                    ),
                    if(1 !=0)
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
                  Text('Apple MacBook Pro',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Text('2500',
                          style: TextStyle(fontSize: 14, color: Colors.blueAccent),
                        ),
                        SizedBox(width: 5,),
                        if(1 !=0)
                          Text('2000',
                            style: TextStyle(fontSize: 14,
                                decoration: TextDecoration.lineThrough,
                                color: Colors.blueAccent
                            ) ,
                          ),
                        Spacer(),
                        IconButton(
                            icon: CircleAvatar(
                                child:
                                Icon(Icons.favorite_border_outlined, color: Colors.white,)),
                            onPressed: (){
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
