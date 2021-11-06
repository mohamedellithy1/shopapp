import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/layout/shop_layout/cubit_Home/cubit.dart';
import 'package:shopapp/shared/style/color.dart';

Widget defaultButton ({
  double width = double.infinity,
  Color background = defaultColor,
  @required String text ,
  @required Function onTap,
  double textSize ,
  bool isToUpperCase = true,
  double radius = 0.0,})=> Container(
  decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(radius)
  ),
  width: width,
  child: MaterialButton(
    onPressed: onTap,
   child: Text
     (
     isToUpperCase ? text.toUpperCase() : text
     , style:
   TextStyle(color: Colors.white, fontSize: textSize),),),
);
Widget defaultTextForm({
 @required TextEditingController controller ,
  @required TextInputType type ,
 @required String labelText,
  Function onChanged,
  Function onSubmit,
  bool isPassword = false,
  @required Function validated,
  @required IconData prefix,
  IconData suffix,
  Function onPressed,
  Function onTap,
  bool isClickable = true,
}) =>    TextFormField(
  validator: validated,
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  onTap: onTap,
  enabled: isClickable,
  decoration:InputDecoration(
      labelText: labelText,
      suffixIcon: suffix!=null ?IconButton(
          icon: Icon(suffix, color: Colors.black,),
          onPressed:onPressed
      ) : null
      ,prefixIcon: Icon(prefix, color: Colors.black,),
      border: OutlineInputBorder()
  ) ,
);
Widget buildSeparator()=> Padding(
  padding: const EdgeInsets.symmetric(horizontal: 20),
  child:   Container(

    width: double.infinity,

    height: 1,

    color: Colors.deepOrange[100],

  ),
);
void toast ({
  @required String msg,
  @required Color color
})=> Fluttertoast.showToast(
    msg: msg,
    fontSize: 16,
    backgroundColor: color,
    gravity: ToastGravity.BOTTOM,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_LONG
);
Widget buildProductItem( model , context){
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
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Text(model.price.toString(),
                        style: TextStyle(fontSize: 14, color: Colors.blueAccent),
                      ),
                      SizedBox(width: 5,),
                      if(0!=0)
                        Text(model.oldPrice,
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
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
