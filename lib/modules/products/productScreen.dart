import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/cubit_Home/cubit.dart';
import 'package:shopapp/layout/shop_layout/cubit_Home/state.dart';
import 'package:shopapp/models/cateogries_model/cateogries_model.dart';
import 'package:shopapp/models/home_model/home_model.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/style/color.dart';
class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state){
        if(state is ShopSuccessChangeFavoriteData){
          if(state.changeFavoriteModel.status){
            toast(msg: state.changeFavoriteModel.message, color: Colors.green);
          }
          else toast(msg: 'هناك خطأ برجاء المحاوله مره اخري', color: Colors.red);
        }
      },
        builder:(context, state){
        return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel!= null && ShopCubit.get(context).cateogriesModel!= null,
            builder: (context) => buildProduct(ShopCubit.get(context).homeModel, ShopCubit.get(context).cateogriesModel, context),
            fallback:(context)=> Center(child: CircularProgressIndicator())
        );
        },
    );
  }
  Widget buildProduct (HomeModel homeModel, CategoriesModel cateogriesModel, context){
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: homeModel.data.banners.map((e) =>
                  Image.network( e.image ,loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null ?
                        loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                            : null,
                      ),
                    );
                  },
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:  8 ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Cateogries',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)
                  ,
                ),
                SizedBox(height: 10,),
                Container(
                  height: 100,
                  child: ListView.separated(
                      itemBuilder: (context, index)=> buildCateogriesItem(cateogriesModel.data.data[index],),
                      separatorBuilder: (context, index) => SizedBox(width: 10,),
                      itemCount: cateogriesModel.data.data.length,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                  )
                ),
                SizedBox(
                ),
                SizedBox(height: 20,),
                Text('New Product', style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              ],
            ),
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
              List.generate(homeModel.data.products.length, (index) => buildGridProduct(homeModel.data.products[index] , context) )
          )
        ],
      ),
    );
  }
  Widget buildGridProduct(ProductsData model , context ){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white,
        child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children:[
                    Image.network( model.image ,loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null ?
                          loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                              : null,
                        ),
                      );
                    },
                      fit: BoxFit.cover,
                      height: 200,
                      width: double.infinity,
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
                        icon: CircleAvatar(
                          backgroundColor: ShopCubit.get(context).favorite[model.id] ? defaultColor : Colors.grey,
                            child:
                            Icon(Icons.favorite_border_outlined, color: Colors.white,)),
                        onPressed: (){
                          ShopCubit.get(context).changeFavorites(model.id);
                        }
                    )
                  ],
                ),
              ],
            ),
      ),
    );
  }
  Widget buildCateogriesItem(DataModel model)=>  Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children:
    [
      Image.network( model.image ,loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null ?
            loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                : null,
          ),
        );
      },
        fit: BoxFit.cover,
        height: 120,
        width: 120,
      ),
      Container(
          width: 100,
          color: Colors.black.withOpacity(.8),
          child: Text("${model.name}",style:
          TextStyle(color: Colors.white),
            textAlign: TextAlign.center,maxLines: 1,overflow: TextOverflow.ellipsis,)),

    ],
  );
}
