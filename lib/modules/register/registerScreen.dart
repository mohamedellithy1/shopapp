import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/register/cubit/cubit.dart';
import 'package:shopapp/modules/register/cubit/state.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit , ShopRegisterState>(
        listener: (context , state) {
          if(state is ShopRegisterSuccessesState){
            if( state.registerModel.status){
              toast(msg: state.registerModel.message,
                  color: Colors.green)
              ;
            }else{
              toast(msg: state.registerModel.message,
                  color: Colors.red);
            }

          }

        },
        builder: (context , state) {
          return GestureDetector(
            onTap: ()=>FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: AppBar(),
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Register.' , style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
                        SizedBox(height: 20,),
                        Image(image: AssetImage('assets/image/Register.png')),
                        SizedBox(height: 10,),
                        defaultTextForm(
                            controller: nameController,
                            type: TextInputType.text,
                            labelText: 'Name',
                            validated: (String value){
                              if(value.isEmpty){
                                return 'Name Must Not Be Empty';
                              }
                              return null;
                            },
                            prefix: Icons.person
                        ),
                        SizedBox(height: 10,),
                        defaultTextForm(
                            controller: phoneController,
                            type: TextInputType.phone,
                            labelText: 'Phone',
                            validated: (String value){
                              if(value.isEmpty){
                                return 'Phone Must Not Be Empty';
                              }
                              return null;
                            },
                            prefix: Icons.phone
                        ),
                        SizedBox(height: 10,),
                        defaultTextForm(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            labelText: 'Email Address',
                            validated: (String value){
                              if(value.isEmpty){
                                return 'Email Address Must Not Be Empty';
                              }
                              return null;
                            },
                            prefix: Icons.email
                        ),
                        SizedBox(height: 10,),
                        defaultTextForm(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            labelText: 'Password',
                            validated: (String value){
                              if(value.isEmpty){
                                return 'Password Must Not Be Empty ';
                              }
                              if(value.length < 6 ){
                                return 'Password Must Be more Then 6';
                              }
                              return null;
                            },
                            prefix: Icons.lock,
                            onTap: (){
                              ShopRegisterCubit.get(context).changePasswordState();
                            },
                            isPassword: ShopRegisterCubit.get(context).hide,
                          suffix: ShopRegisterCubit.get(context).suffix
                        ),
                        SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child:
                          state is ShopLoadingRegisterState
                          ? Center(child: CircularProgressIndicator()): defaultButton(
                              radius: 25,
                              textSize:  25,
                              text: 'Register.',
                              isToUpperCase: false,
                              onTap: (){
                                ShopRegisterCubit.get(context).userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    phone: phoneController.text
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
      },
    ),
    );
  }
}

