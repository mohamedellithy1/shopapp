import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/cubit_Home/cubit.dart';
import 'package:shopapp/layout/shop_layout/cubit_Home/state.dart';
import 'package:shopapp/modules/login/login.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';
class SettingScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopState>(
    listener: (context , state){

      if (state is ShopSuccessUpdateProfileData) {
        toast(msg: 'UpDated Is Done', color: Colors.green);
      }
    },
      builder: (context , state) {
      var cubit = ShopCubit.get(context).loginModel;
      nameController.text = cubit.data.name;
      emailController.text = cubit.data.email;
      phoneController.text = cubit.data.phone;
      return GestureDetector(
        onTap: ()=>FocusScope.of(context).unfocus(),
        child: ConditionalBuilder(
          condition: ShopCubit.get(context).loginModel != null,
          builder: (context) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if(state is ShopLoadingUpdateProfileData)
                      LinearProgressIndicator(),
                    SizedBox(height: 15,),
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
                      padding: const EdgeInsets.only(top:20),
                      child: defaultButton(
                          width: MediaQuery.of(context).size.width*.7,
                          text: 'update',
                          onTap: (){
                            if(formKey.currentState.validate()){
                              ShopCubit.get(context).updateProfile(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneController.text
                              );
                              FocusScope.of(context).requestFocus(FocusNode());
                            }
                          },
                        radius: 20,
                        textSize: 20
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: defaultButton(
                        width: MediaQuery.of(context).size.width*.7,
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
          ),
          fallback: (context)=> Center(child: CircularProgressIndicator()),
        ),
      );
      },
    );
  }
}
