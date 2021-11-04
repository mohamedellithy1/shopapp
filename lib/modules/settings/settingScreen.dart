import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/cubit_Home/cubit.dart';
import 'package:shopapp/layout/shop_layout/cubit_Home/state.dart';
import 'package:shopapp/modules/login/login.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';
class SettingScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopState>(
    listener: (context , state){
      if (state is ShopSuccessGetSettingData)
        {
          nameController.text = state.loginModel.data.name;
          emailController.text = state.loginModel.data.email;
          phoneController.text = state.loginModel.data.phone;
        }
    },
      builder: (context , state) {
      var cubit = ShopCubit.get(context).modelProfile;
      nameController.text = cubit.data.name;
      emailController.text = cubit.data.email;
      phoneController.text = cubit.data.phone;
      return ConditionalBuilder(
        condition: ShopCubit.get(context).modelProfile != null,
        builder: (context) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                defaultTextForm(
                    controller: nameController,
                    type: TextInputType.text,
                    labelText: 'name',
                    validated: (String value){
                      if(value.isEmpty) {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    prefix: Icons.person
                ),
                SizedBox(height: 15,),
                defaultTextForm(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    labelText: 'Email Address',
                    validated: (String value){
                      if(value.isEmpty) {
                        return 'Email must not be empty';
                      }
                      return null;
                    },
                    prefix: Icons.email
                ),
                SizedBox(
                  height: 15,
                ),
                defaultTextForm(
                    controller: phoneController,
                    type: TextInputType.phone,
                    labelText: 'Phone Number',
                    validated: (String value){
                      if(value.isEmpty) {
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                    prefix: Icons.phone
                ),
                SizedBox(height: 15,),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: defaultButton(
                      text: 'LOGOUT',
                      onTap: (){
                        CacheHelper.removeData(key: 'token').then((value){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ShopLoginScreen()));
                        });
                      },
                    radius: 20,
                    textSize: 20
                  ),
                )
              ],
            ),
          ),
        ),
        fallback: (context)=> Center(child: CircularProgressIndicator()),
      );
      },
    );
  }
}
