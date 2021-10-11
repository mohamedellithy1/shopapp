import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/cubit_Home/cubit.dart';
import 'package:shopapp/layout/shop_layout/cubit_Home/state.dart';
import 'package:shopapp/models/home_model/home_model.dart';
import 'package:shopapp/shared/network/end_points.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state){},
        builder:(context, state){
        return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel!= null,
            builder: (context) => buildProduct(ShopCubit.get(context).homeModel),
            fallback:(context)=> Center(child: CircularProgressIndicator())
        );
        },
    );
  }
  Widget buildProduct (HomeModel homeModel){
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          CarouselSlider(
              items: homeModel.data.banners.map((e) =>Image(
                  image: NetworkImage('${e.image}'),
                width: double.infinity,
                fit: BoxFit.cover,
              )
              ).toList(),
              options: CarouselOptions(
                height: 200,
                reverse: false,
                autoPlay: true,
                enableInfiniteScroll: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 2),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1.0
              )
          ),
          SizedBox(height: 10,),
          GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1/1.7,
              crossAxisCount: 2,
              children:
              List.generate(homeModel.data.products.length, (index) => buildGridProduct(homeModel.data.products[index]) )
          )
        ],
      ),
    );
  }
  Widget buildGridProduct(ProductsData model){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white,
        child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children:[
                    Image(
                      image: NetworkImage('${model.image}'),
                    width: double.infinity,
                    height: 200 ,
                    fit: BoxFit.cover,
                  ),
                    if(model.discount !=0)
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
                Text('${model.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14),
                ),
                Row(
                  children: [
                    Text('${model.price}',
                      style: TextStyle(fontSize: 14, color: Colors.blueAccent),
                    ),
                    SizedBox(width: 5,),
                    if(model.discount !=0)
                    Text('${model.old_price}',
                      style: TextStyle(fontSize: 14,
                          decoration: TextDecoration.lineThrough,
                        color: Colors.blueAccent
                      ) ,
                    ),
                    Spacer(),
                    IconButton(

                        icon: Icon(Icons.favorite_border_outlined), onPressed: (){}
                    )
                  ],
                ),
              ],
            ),
      ),
    );
  }
}
