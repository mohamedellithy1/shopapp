import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/cubit_Home/cubit.dart';
import 'package:shopapp/layout/shop_layout/cubit_Home/state.dart';
import 'package:shopapp/models/cateogries_model/cateogries_model.dart';
import 'package:shopapp/shared/components/components.dart';
class CateogriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopState>(
    listener: (context , state){},
    builder: (context , state){
      return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) => buildCardItem(ShopCubit.get(context).cateogriesModel.data.data[index]),
          separatorBuilder: (context , index) =>
              buildSeparator(),
          itemCount: ShopCubit.get(context).cateogriesModel.data.data.length
      );
    },
    );
  }
  Widget buildCardItem(DataModel model)=>  Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      color: Colors.grey[200],
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(topRight: Radius.circular(25), bottomRight: Radius.circular(25)),
            child: Image.network( model.image ,loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
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
                 )
            ),
          SizedBox(width: 10,),
          Expanded(
            child: Text(model.name, style:
            TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          Spacer(),
          IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: (){})
        ],
      ),
    ),
  );
}