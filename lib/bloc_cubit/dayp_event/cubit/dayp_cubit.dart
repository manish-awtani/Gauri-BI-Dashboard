import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/dayp_model.dart';
import 'package:flutter_application_1/services/sembast_service.dart';
import '../../../services/api_response.dart';
import '../../../services/http_handler.dart';
import '../../../utils/urls/urls.dart';

part 'dayp_state.dart';

class DaypCubit extends Cubit<DaypState> {
  DaypCubit(
    // SembastService sembastService
  ) : super(DaypInitial());
  List<dynamic>? DaypData;
    void DaypApi({required BuildContext context, required payload}) async {
    // try {
    // final SharedPreferences prefs = await _prefs;
    // emit(DashboardLoadingState());
    // print("$payload=====/=====$context");
    // ignore: use_build_context_synchronously
    APIResponse apiResponse = await HttpHandler.postMethod(
      context: context,
      url: ApiURL.POST_DAYP_EVENT_URL,
      data: payload,
    );
    // print("$payload=====/apiResponse=====$apiResponse");
    // print(apiResponse.statusMessage);
    if (apiResponse.statusCode == 200) {
      //  dashboardAdminModel = dashboardAdminModelFromJson(jsonDecode(apiResponse.data));
      // if (tempData.isNotEmpty) { 
      DaypData = apiResponse.data;
      // print("Daypdatasdasdasdasdatttattattt$dashboardDaypModel");

      print("Daypdatatttattattt $DaypData");
      // }
      emit(DaypLoadedState());
    }
    // } catch (e) {
    //   emit(DashboardErrorState());
    // }
  }
}