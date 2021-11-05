import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_layout/Home_Layout.dart';
import 'package:shopapp/models/login/cubit/cubit.dart';
import 'package:shopapp/models/login/cubit/state.dart';
import 'package:shopapp/modules/register/registerScreen.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';

class ShopLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey=GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
        listener: (context, state) {
          if(state is ShopLoginSuccessesState){
            if(state.loginModel.status==true){
              print(state.loginModel.message);
              CacheHelper.saveData(value: "${state.loginModel.data.token}", key: "token").then((value) {
                token = state.loginModel.data.token;
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeLayout()),
                        (route) => false);
              });
              toast(
                msg: state.loginModel.message,
                color: Colors.green
              );
            }
            else
            {
              toast(msg: state.loginModel.message, color: Colors.red);
            }

          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: ()=>FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LOGIN",
                          style: Theme.of(context).textTheme.headline5.copyWith(fontSize: 35, fontWeight: FontWeight.bold),
                        ),
                        Text("Login now to browse our hot offers",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.grey)),
                        Image(
                          image: AssetImage("assets/image/login.png"),
                        ),

                        // TextFormField(
                        //   controller: EmailController,
                        //   keyboardType: TextInputType.emailAddress,
                        //   decoration: InputDecoration(
                        //     labelText: "Email",
                        //     prefixIcon: Icon(Icons.email_outlined),
                        //     border: OutlineInputBorder(),
                        //   ),
                        //   validator: (String value) {
                        //     if (value.isEmpty) return "Email must not be empty";
                        //     return null;
                        //   },
                        // ),
                        defaultTextForm(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            labelText: 'Email',
                            validated: (String value) {
                              if (value.isEmpty) return "Email must not be empty";
                              return null;
                            },
                            prefix: Icons.email,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        defaultTextForm(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            labelText: 'Password',
                            validated: (String value) {
                              if (value.isEmpty) return "Password must not be empty";
                              return null;
                              },
                            prefix: Icons.lock,
                            isPassword: ShopLoginCubit.get(context).hide,
                          onSubmit: (value){
                              if(formKey.currentState.validate()){

                              }
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                              },
                            suffix: ShopLoginCubit.get(context).suffix,
                                    onPressed: (){
                                      ShopLoginCubit.get(context).changePasswordState();
                                    }
                                    ),
                        SizedBox(
                          height: 10,
                        ),
                        state is ShopLoadingLoginState
                            ? Center(child: CircularProgressIndicator())
                            : defaultButton(
                          text: 'Login',
                          textSize: 25,
                          radius: 20,
                          background: Colors.deepOrange,
                          onTap:() {
                            if(formKey.currentState.validate()){
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          }
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Dont\'t have an account ?"),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>RegisterScreen()),
                                          );
                                },
                                child: Text("Register now"))
                          ],
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
