import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/database/dummydata.dart';
import 'package:flutter_application_1/model/dayp_count_model.dart';
import 'package:flutter_application_1/services/sembast_service.dart';
import '../../../services/api_response.dart';
import '../../../services/http_handler.dart';
import '../../../utils/urls/urls.dart';

part 'dayp_count_state.dart';

class DaypCountCubit extends Cubit<DaypCountState> {
  // DaypCountCubit() : super(DaypCountInitial());
  // final SembastService _sembastService;
  final Duration _cacheDuration = const Duration(hours: 1);

  DaypCountCubit(
    // this._sembastService
  ) : super(DaypCountInitial());

  Map<String, dynamic>? daypCountData;
  Map<String, dynamic>? daypComparisonData;
  // String? daypCountData;

Future<void> DaypCountApi({
    required BuildContext context,
    required Map<String, dynamic> payload,
    bool isComparison = false,
  }) async {
    emit(DaypCountLoadingState());

    // final cachedData = await _sembastService.getDaypCountData();
    // final isCachedDataValid = cachedData != null &&
    //     DateTime.now().isBefore(cachedData['fetchedAt'].add(_cacheDuration));

    // if (isCachedDataValid) {
    //   // Use cached data
    //   if (isComparison) {
    //     emit(DaypComparisonCountLoadedState(cachedData));
    //   } else {
    //     emit(DaypCountLoadedState(cachedData));
    //   }
    //   return; // No need to fetch from API if data is valid
    // }
    
    try {
      APIResponse apiResponse = await HttpHandler.postMethod(
        context: context,
        url: ApiURL.POST_DAYP_COUNT_URL,
        data: payload,
      );

      if (apiResponse.statusCode == 200) {
        final data = apiResponse.data;
        data['fetchedAt'] = DateTime.now(); // Add timestamp for cache validity

        // await _sembastService.storeDaypCountData(data);

        // Directly assign the parsed data to daypCountData
        print("apiResponse.data:=========== ${apiResponse.data.runtimeType}");
        debugPrint("DaypCount/ComparisionData:=========== ${apiResponse.data}");
        if (apiResponse.data != null || apiResponse.data != {} || dummy_data != null) {
          if (isComparison) {
            // daypComparisonData = apiResponse.data;
            daypComparisonData = dummy_data["data"];
            emit(DaypComparisonCountLoadedState(daypComparisonData!));
          } else {
            // daypCountData = apiResponse.data;
            daypCountData = dummy_data["data"];
            emit(DaypCountLoadedState(daypCountData!));
          }
        } else {
          emit(DaypCountErrorState("API response data is null/No data found"));
        }
        // final daypCountData = daypCountModelFromJson(apiResponse.data.toString());
      } else {
        emit(DaypCountErrorState(apiResponse.statusMessage ?? "Unknown error"));
      }
    } catch (e) {
      print(e);
      emit(DaypCountErrorState(e.toString()));
    }
  }
}
