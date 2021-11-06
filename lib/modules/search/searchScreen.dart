import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/modules/search/cubit_Search/cubit.dart';
import 'package:shopapp/modules/search/cubit_Search/state.dart';
import 'package:shopapp/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit , ShopSearchState>(
        listener: (context , state) {},
        builder: (context , state){
          return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: defaultTextForm(
                          controller: searchController,
                          type: TextInputType.text,
                          labelText: 'Search',
                          onSubmit: (String text){
                            ShopSearchCubit.get(context).search(searchController.text);
                          },
                          validated: (String value){
                            if(value.isEmpty){
                              return 'Search Must Not Be Empty';
                            }
                            return null;
                          },
                          prefix: Icons.search
                      ),
                    ),
                    defaultButton(
                      width: MediaQuery.of(context).size.width*.4,
                      radius: 25,
                      textSize: 20,
                      isToUpperCase: false,
                        text: 'Search',
                        onTap: (){
                          if(formKey.currentState.validate()){
                            ShopSearchCubit.get(context).search(searchController.text);
                          }
                          FocusScope.of(context).requestFocus(FocusNode());
                        }
                    ),
                    SizedBox(height: 15,),
                    if(state is ShopLoadingSearchData)
                    LinearProgressIndicator(),
                    SizedBox(height: 15,),
                    if(state is ShopSuccessSearchData)
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildProductItem(ShopSearchCubit.get(context).model.data.data[index], context),
                          separatorBuilder: (context , index)=> buildSeparator(),
                          itemCount: ShopSearchCubit.get(context).model.data.data.length
                      ),

                    ),

                  ],
                ),
              )
          );
        },
      ),
    );
  }
}
