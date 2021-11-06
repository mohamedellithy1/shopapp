import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/search_model/search_model.dart';
import 'package:shopapp/modules/search/cubit_Search/state.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/network/end_points.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';
class ShopSearchCubit extends Cubit<ShopSearchState> {
  ShopSearchCubit() : super (ShopSearchInitialState());
  static ShopSearchCubit get(context) => BlocProvider.of(context);
SearchModel model;
void search(String text){
  emit(ShopLoadingSearchData());
  DioHelper.postData(
      url: SEARCH ,
      token: token
      ,
      data:{
        'text' : text,
      }
  ).then((value){
    model = SearchModel.fromJson(value.data);
    emit(ShopSuccessSearchData());
  }).catchError((error){
    emit(ShopErrorSearchData(error: error));
  });
}
}