import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/cubit/cubit.dart';
import 'package:shopapp/shared/cubit/state.dart';
import 'package:shopapp/shared/style/color.dart';
class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
        listener: (context, state){},
        builder: (context , state){
          ShopLoginCubit cubit =ShopLoginCubit();
          return GestureDetector(
            onTap: ()=>FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Form(
                    key: formKey ,
                    child: Column(
                      children: [
                        Text('LOGIN' ,
                            style: Theme.of(context).textTheme.headline4.copyWith(
                                fontSize: 40, color: Colors.black
                            )
                        ),
                        Image.asset('assets/image/login.png'),
                        defaultTextForm(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            labelText: 'Enter Your Email',
                            validated: (String value){
                              if(value.isEmpty || value == null){
                                return 'Enter your Email';
                              }
                              return null;
                            },
                            prefix: Icons.email
                        ),
                        SizedBox(height: 20,),
                        defaultTextForm(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            labelText: 'Enter Your Password',
                            validated: (String value){
                              if(value.isEmpty || value == null){
                                return 'Enter the password';
                              }
                              return null;
                            },
                            prefix: Icons.lock,
                            suffix: Icons.visibility_off
                        ),
                        SizedBox(height: 20,),
                        ConditionalBuilder(
                          condition: state is! ShopLoadingLoginState ,
                          builder: (context)=> defaultButton(
                              text:'Login' ,
                              background: defaultColor ,
                              radius: 20 ,
                              onTap: (){
                                if(formKey.currentState.validate())
                               {
                                 cubit.userLogin(
                                     email: emailController.text,
                                     password: passwordController.text
                                 );
                               }
                              },
                              textSize: 18
                          ),
                          fallback:(context)=> CircularProgressIndicator(),
                        ),
                        SizedBox(height: 10,),
                        TextButton(onPressed: (){},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Don't have an account ? "),
                                Row(
                                  children: [
                                    Text('Register', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                                    SizedBox(width: 5,),
                                    Icon(Icons.arrow_forward, size: 20,),
                                  ],
                                )
                              ],
                            ))
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
