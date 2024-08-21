import 'dart:collection';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/bloc_cubit/dayp_count/cubit/dayp_count_cubit.dart';
import 'package:flutter_application_1/bloc_cubit/dayp_event/cubit/dayp_cubit.dart';
import 'package:flutter_application_1/charts/ColumnBarChart.dart';
import 'package:flutter_application_1/charts/DoughnutChart.dart';
import 'package:flutter_application_1/charts/LineChart.dart';
import 'package:flutter_application_1/charts/PieChart.dart';
import 'package:flutter_application_1/model/dayp_count_model.dart';
import 'package:flutter_application_1/screens/examples/homeScreen.dart';
import 'package:flutter_application_1/widgets/tickertape/ticker_tape.dart';
import 'package:flutter_application_1/utils/constants/colors.dart';
import 'package:flutter_application_1/utils/constants/constants.dart';
import 'package:flutter_application_1/utils/helper/helper_functions.dart';
import 'package:flutter_application_1/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter_application_1/widgets/bottom-sheet-modal/ChartCompareModal.dart';
import 'package:flutter_application_1/widgets/bottom-tab-bar/BottomTabBar.dart';
import 'package:flutter_application_1/widgets/appbar/appbar.dart';
import 'package:flutter_application_1/widgets/buttons/custom_icon_button.dart';
import 'package:flutter_application_1/widgets/cupertino-picker/CustomCupertinoPicker.dart';
import 'package:flutter_application_1/widgets/drawer-menu/DrawerMenu.dart';
import 'package:flutter_application_1/widgets/error-dialog/ErrorDialog.dart';
import 'package:flutter_application_1/widgets/grid-view/grid_view.dart';
import 'package:flutter_application_1/widgets/skeletonizer-view/dayp_dashboard_skeleton.dart';
import 'package:flutter_application_1/widgets/sliding-segmented-button/sliding_segmented_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DaypDashboardCount extends StatefulWidget {
  const DaypDashboardCount({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DaypDashboardCountState createState() => _DaypDashboardCountState();
}

class _DaypDashboardCountState extends State<DaypDashboardCount> {
  bool _skeletonEnabled = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  DateTime? _startDate = null;
  DateTime? _endDate = null;
  DateTime? _comparisonStartDate = null;
  DateTime? _comparisonEndDate = null;
  double selected = 0.0;
  double uploaded = 0.0;
  double confirmed = 0.0;
  double bided = 0.0;
  int _initialValue = 3;
  int criteriaInitialValue = 1;
  bool isChartDropDownVisible = false;
  String selectedChart = 'Line Chart';
  String? selectedComparisonChart = null;
  String selectedData = 'Dayp';
  String stoneType = "selected";
  String dateFilterType = "5Y";
  List pieChartData = [];
  List<ChartData> gridData = <ChartData>[];
  // List stoneTypeArray = ["selected", "uploaded", "confirmed", "bided"];
  List<Map<String, String>> stoneTypeArray = [
    {"Total stock": "selected"},
    {"Stock left": "uploaded"},
    {"Stock sold": "confirmed"},
    {"Stock return": "bided"},
  ];
  List diamondCriteriaArray = [
    "Shape",
    "Clarity",
    "Certificate",
    "Cut",
    "Color"
  ];
  String diamondCriteria = 'shape';
  Map<String, dynamic> daypChartData = {
    '2023': [
      {
        'event_id': 3615,
        'selected': 144,
        'uploaded': 144,
        'confirmed': 41,
        'bided': 144
      },
    ]
  };
  Map<String, dynamic> daypChartComparisionData = {
    '2023': [
      {
        'event_id': 3615,
        'selected': 144,
        'uploaded': 144,
        'confirmed': 41,
        'bided': 144
      },
    ]
  };

  List<TickerData> sampleData = [
    TickerData(symbol: 'SELECTED', price: 150.0, change: 1.5),
    TickerData(symbol: 'UPLOADED', price: 2800.0, change: -20.0),
    TickerData(symbol: 'CONFIRMED', price: 3400.0, change: 15.0),
    TickerData(symbol: 'BIDED', price: 3400.0, change: 15.0),
  ];
  final List<TickerData> GoriSampleData = [
    TickerData(symbol: 'NOOR', price: 150.0, change: 1.5),
    TickerData(symbol: 'ANARKALI', price: 2800.0, change: -20.0),
    TickerData(symbol: 'KASOOR', price: 3400.0, change: 15.0),
    TickerData(symbol: 'GORIX', price: 3400.0, change: 16.0),
    TickerData(symbol: 'ANANYA', price: 3400.0, change: -15.0),
    // Add more sample data as needed
  ];
  // ignore: unused_field
  Future<void>? _tickerDataFuture;
  List<String> intervalLabels = [
    'Days',
    'Months',
    'Years',
    'Decades',
    'Centuries',
  ];
  String selectedScenario = 'timebased';
  String selectedInterval = 'year';
  List<ChartData> filteredData = [
    ChartData(x: DateTime(2020, 1, 1), y: 35),
    ChartData(x: DateTime(2020, 2, 1), y: 28),
  ];
  String xAxisType = 'datetime';
  @override
  void initState() {
    super.initState();
    DaypDashboardCountData();
    _skeletonEnabled = true;
    // updateChartData();
  }

  // ignore: non_constant_identifier_names
  void DaypDashboardCountData({
    String? type = "event_date",
    String? timeFrame = "month",
    String? diamondCriteria = "shape",
    DateTime? startDate,
    DateTime? endDate,
    bool isComparison = false,
  }) async {
    final SharedPreferences prefs = await _prefs;
    // print(
    //     "$timeFrame $type $diamondCriteria ------------------------- $startDate $endDate");
    var payload = {
      "type": type,
      "timeframe": timeFrame,
      "from_date": (startDate != null) ? startDate.toString() : "",
      "to_date": (endDate != null) ? endDate.toString() : "",
      "certificate": diamondCriteria == 'certificate' ? true : false,
      "shape": diamondCriteria == 'shape' ? true : false,
      "clarity": diamondCriteria == 'clarity' ? true : false,
      "color": diamondCriteria == 'color' ? true : false,
      "cut": diamondCriteria == 'cut' ? true : false,
      // "polish": diamondCriteria == 'shape' ? true : false,
      // "symmetry": diamondCriteria == 'shape' ? true : false,
      // "floro": diamondCriteria == 'shape' ? true : false,
    };

    // ignore: use_build_context_synchronously
    context.read<DaypCountCubit>().DaypCountApi(
          context: context,
          payload: payload,
          isComparison: isComparison,
        );
    // ignore: use_build_context_synchronously
  }

  Future<void> _countData(daypChartData) async {
    // print(" vssssssSvssssssSvssssssSvssssssS ${daypChartData} vssssssSvssssssSvssssssSvssssssS");
    double totalSelected = 0.0;
    double totalUploaded = 0.0;
    double totalConfirmed = 0.0;
    double totalBided = 0.0;
    for (String year in daypChartData.keys) {
      List<dynamic> yearData = daypChartData[year]!;
      // if (yearData['selected'] != null) {
      //   totalSelected += yearData["selected"];
      // }
      // if (yearData["uploaded"] != null) {
      //   totalUploaded += yearData["uploaded"];
      // }
      // if (yearData["confirm"] != null) {
      //   totalConfirmed += yearData["confirm"];
      // }

      // old api function
      // yearData.forEach((event) {
      // event["event_data"].forEach((eventItem) {
      // // print("yearyearyearyearyear ${eventItem["selected"]} ");

      //   totalSelected += eventItem['selected'] as int;
      //   totalUploaded += eventItem['uploaded'] as int;
      //   totalConfirmed += eventItem['confirmed'] as int;
      //   totalBided += eventItem['bided'] as int;
      // });
      // });

      for (var element in yearData) {
        List<Map<String, dynamic>> eventData =
            (element['event_data'] as List).cast<Map<String, dynamic>>();
        // for (var event in shape['event_data']) {
        for (var eventItem in eventData) {
          totalSelected += eventItem['selected'] as int;
          totalUploaded += eventItem['uploaded'] as int;
          totalConfirmed += eventItem['confirmed'] as int;
          totalBided += eventItem['bided'] as int;
        }
      }
      // print('yearyearyearyear===== ${totalSelected} ');
    }
    // daypChartData?.forEach((val) {
    //   print('$val vssssssS');
    // });

    setState(() {
      selected = totalSelected;
      uploaded = totalUploaded;
      confirmed = totalConfirmed;
      bided = totalBided;
      sampleData = [
        TickerData(symbol: 'SELECTED', price: selected, change: 1.5),
        TickerData(symbol: 'UPLOADED', price: uploaded, change: -20.0),
        TickerData(symbol: 'CONFIRMED', price: confirmed, change: 15.0),
        TickerData(symbol: 'BIDED', price: bided, change: -15.0),
      ];
      List<TickerData> GoriSampleData = [
        TickerData(symbol: 'NOOR', price: selected, change: 1.5),
        TickerData(symbol: 'ANARKALI', price: uploaded, change: -20.0),
        TickerData(symbol: 'KASOOR', price: confirmed, change: 15.0),
        TickerData(symbol: 'GORIX', price: bided, change: 16.0),
        TickerData(symbol: 'ANANYA', price: 342300.0, change: -15.0),
        // Add more sample data as needed
      ];
    });
  }

  updateDateDuration() {}
// Local + Backend
  updateChartData(
    String type,
    daypChartData,
    String stoneType,
    dateFilterType, [
    String? subtype,
  ]) {
    List<ChartData> data = [];
    List<ChartData> pieData = [];
    List<ChartData> gridData = [];
    List<ChartData> pieGridData = [];
    DateTime startDate = _startDate ?? DateTime(2020, 1, 1);
    DateTime endDate = _endDate ?? DateTime.now();

    switch (type) {
      case 'timebased':
        for (String yearString in daypChartData.keys) {
          print('local--------------r ${yearString}');

          print('local--------------r ${yearString}');
          String yearPart = yearString.split('_')[0];
          String monthPart = yearString.split('_')[1];

          int year = int.parse(yearPart);
          int month = monthStringToInt(monthPart);

          DateTime yearMonthDate = DateTime(year, month);
          if ((yearMonthDate.isAfter(startDate) ||
                  yearMonthDate.isAtSameMomentAs(startDate)) &&
              (yearMonthDate.isBefore(endDate) ||
                  yearMonthDate.isAtSameMomentAs(endDate))) {
            List<dynamic> yearData = daypChartData[yearString]!;
            int count = 0;
            for (var element in yearData) {
              List<Map<String, dynamic>> eventData =
                  (element['event_data'] as List).cast<Map<String, dynamic>>();
              for (var eventItem in eventData) {
                count += eventItem[stoneType] as int;
              }
            }
            data.add(ChartData(
              x: yearString,
              y: count,
            ));
          }
        }
        return data;

      case 'pieChart' || 'Pie Chart' || 'doughnutChart' || 'Doughnut Chart':
        Map<String, Map<String, dynamic>> criteriaCountMap = {};
        var stoneCriteriaObject = {};

        for (String yearString in daypChartData.keys) {
          print('local--------------r ${yearString}');

          print('local--------------r ${yearString}');
          String yearPart = yearString.split('_')[0];
          String monthPart = yearString.split('_')[1];

          int year = int.parse(yearPart);
          int month = monthStringToInt(monthPart);

          DateTime yearMonthDate = DateTime(year, month);
          if ((yearMonthDate.isAfter(startDate) ||
                  yearMonthDate.isAtSameMomentAs(startDate)) &&
              (yearMonthDate.isBefore(endDate) ||
                  yearMonthDate.isAtSameMomentAs(endDate))) {
            List<dynamic> yearData = daypChartData[yearString]!;

            for (var element in yearData) {
              String criteriaName = element['${diamondCriteria}_name'];
              List<dynamic> eventData = element['event_data'];
              int shapeCount = 0;

              for (var event in eventData) {
                shapeCount += event[stoneType] as int;
              }

              if (criteriaCountMap.containsKey(criteriaName)) {
                criteriaCountMap[criteriaName]!['${stoneType}stone_count'] +=
                    shapeCount;
              } else {
                criteriaCountMap[criteriaName] = {
                  '${diamondCriteria}_code': element['${diamondCriteria}_code'],
                  '${diamondCriteria}_name': element['${diamondCriteria}_name'],
                  '${stoneType}stone_count': shapeCount
                };
              }
            }
          }
        }

        switch (subtype) {
          case 'chart':
            List<ChartData> pieData = criteriaCountMap.entries
                .map((entry) => ChartData(
                      x: entry.value['${diamondCriteria}_name'],
                      y: entry.value['${stoneType}stone_count'],
                    ))
                .toList();

            return pieData;

          case 'grid':
            List<ChartData> pieGridData = criteriaCountMap.entries
                .map((entry) => ChartData(
                      x: entry.value['${diamondCriteria}_code'],
                      y: entry.value['${diamondCriteria}_name'],
                      z: entry.value['${stoneType}stone_count'],
                    ))
                .toList();
            // int ind = 1;
            // pieGridData.forEach((data) {
            //     print(
            //         'Index: ${ind}, $data');
            //         ind++;
            //   });
            return pieGridData;
        }

      default:
    }
  }

// Backend
//   updateChartData(
//     String type,
//     daypChartData,
//     String stoneType,
//     dateFilterType, [
//     String? subtype,
//   ]) {
//     List<ChartData> data = [];
//     List<ChartData> pieData = [];
//     List<ChartData> gridData = [];
//     List<ChartData> pieGridData = [];
// print(daypChartData);
//     switch (type) {
//       case 'timebased':
//         for (String year in daypChartData.keys) {
//           List<dynamic> yearData = daypChartData[year]!;
//           int count = 0;
//           for (var element in yearData) {
//             List<Map<String, dynamic>> eventData =
//                 (element['event_data'] as List).cast<Map<String, dynamic>>();
//             // print("======================================== ${element} ");
//             for (var eventItem in eventData) {
//               count += eventItem[stoneType] as int;
//             }
//           }
//           data.add(ChartData(
//             x: year,
//             y: count,
//           ));
//         }
//         return data;

//       case 'pieChart' || 'Pie Chart' || 'doughnutChart' || 'Doughnut Chart':
//         Map<String, Map<String, dynamic>> criteriaCountMap = {};
//         var stoneCriteriaObject = {};

//         for (String year in daypChartData.keys) {
//           List<dynamic> yearData = daypChartData[year];

//           for (var element in yearData) {
//             String criteriaName = element['${diamondCriteria}_name'];
//             List<dynamic> eventData = element['event_data'];
//             int shapeCount = 0;

//             for (var event in eventData) {
//               shapeCount += event[stoneType] as int;
//             }

//             if (criteriaCountMap.containsKey(criteriaName)) {
//               criteriaCountMap[criteriaName]!['${stoneType}stone_count'] +=
//                   shapeCount;
//             } else {
//               criteriaCountMap[criteriaName] = {
//                 '${diamondCriteria}_code': element['${diamondCriteria}_code'],
//                 '${diamondCriteria}_name': element['${diamondCriteria}_name'],
//                 '${stoneType}stone_count': shapeCount
//               };
//             }
//           }
//         }

//         switch (subtype) {
//           case 'chart':
//             List<ChartData> pieData = criteriaCountMap.entries
//                 .map((entry) => ChartData(
//                       x: entry.value['${diamondCriteria}_name'],
//                       y: entry.value['${stoneType}stone_count'],
//                     ))
//                 .toList();

//             return pieData;

//           case 'grid':
//             List<ChartData> pieGridData = criteriaCountMap.entries
//                 .map((entry) => ChartData(
//                       x: entry.value['${diamondCriteria}_code'],
//                       y: entry.value['${diamondCriteria}_name'],
//                       z: entry.value['${stoneType}stone_count'],
//                     ))
//                 .toList();
//             // int ind = 1;
//             // pieGridData.forEach((data) {
//             //     print(
//             //         'Index: ${ind}, $data');
//             //         ind++;
//             //   });
//             return pieGridData;
//         }
//       case 'doughnutChart' || 'Doughnut Chart':
//         Map<String, int> criteriaCountMap = {};

//         for (String year in daypChartData.keys) {
//           List<dynamic> yearData = daypChartData[year];

//           for (var element in yearData) {
//             String criteriaName = element['${diamondCriteria}_name'];
//             List<dynamic> eventData = element['event_data'];
//             int shapeCount = 0;

//             for (var event in eventData) {
//               shapeCount += event[stoneType] as int;
//             }

//             if (criteriaCountMap.containsKey(criteriaName)) {
//               criteriaCountMap[criteriaName] =
//                   criteriaCountMap[criteriaName]! + shapeCount;
//             } else {
//               criteriaCountMap[criteriaName] = shapeCount;
//             }
//           }
//         }

//         List<ChartData> pieData = criteriaCountMap.entries
//             .map((entry) => ChartData(x: entry.key, y: entry.value))
//             .toList();

//         return pieData;

//       default:
//     }
//   }

  updateComparisonChartData(
    String type,
    daypChartData,
    String stoneType,
    dateFilterType, [
    String? subtype,
  ]) {
    List<ChartData> data = [];
    List<ChartData> pieData = [];
    List<ChartData> gridData = [];
    List<ChartData> pieGridData = [];
    DateTime startDate = _comparisonStartDate ?? DateTime(2020, 1, 1);
    DateTime endDate = _comparisonEndDate ?? DateTime.now();

    switch (type) {
      case 'timebased':
        for (String yearString in daypChartData.keys) {
          print('local--------------r ${yearString}');

          print('local--------------r ${yearString}');
          String yearPart = yearString.split('_')[0];
          String monthPart = yearString.split('_')[1];

          int year = int.parse(yearPart);
          int month = monthStringToInt(monthPart);

          DateTime yearMonthDate = DateTime(year, month);
          if ((yearMonthDate.isAfter(startDate) ||
                  yearMonthDate.isAtSameMomentAs(startDate)) &&
              (yearMonthDate.isBefore(endDate) ||
                  yearMonthDate.isAtSameMomentAs(endDate))) {
            List<dynamic> yearData = daypChartData[yearString]!;
            int count = 0;
            for (var element in yearData) {
              List<Map<String, dynamic>> eventData =
                  (element['event_data'] as List).cast<Map<String, dynamic>>();
              for (var eventItem in eventData) {
                count += eventItem[stoneType] as int;
              }
            }
            data.add(ChartData(
              x: yearString,
              y: count,
            ));
          }
        }
        return data;

      case 'pieChart' || 'Pie Chart' || 'doughnutChart' || 'Doughnut Chart':
        Map<String, Map<String, dynamic>> criteriaCountMap = {};
        var stoneCriteriaObject = {};

        for (String yearString in daypChartData.keys) {
          print('local--------------r ${yearString}');

          print('local--------------r ${yearString}');
          String yearPart = yearString.split('_')[0];
          String monthPart = yearString.split('_')[1];

          int year = int.parse(yearPart);
          int month = monthStringToInt(monthPart);

          DateTime yearMonthDate = DateTime(year, month);
          if ((yearMonthDate.isAfter(startDate) ||
                  yearMonthDate.isAtSameMomentAs(startDate)) &&
              (yearMonthDate.isBefore(endDate) ||
                  yearMonthDate.isAtSameMomentAs(endDate))) {
            List<dynamic> yearData = daypChartData[yearString]!;

            for (var element in yearData) {
              String criteriaName = element['${diamondCriteria}_name'];
              List<dynamic> eventData = element['event_data'];
              int shapeCount = 0;

              for (var event in eventData) {
                shapeCount += event[stoneType] as int;
              }

              if (criteriaCountMap.containsKey(criteriaName)) {
                criteriaCountMap[criteriaName]!['${stoneType}stone_count'] +=
                    shapeCount;
              } else {
                criteriaCountMap[criteriaName] = {
                  '${diamondCriteria}_code': element['${diamondCriteria}_code'],
                  '${diamondCriteria}_name': element['${diamondCriteria}_name'],
                  '${stoneType}stone_count': shapeCount
                };
              }
            }
          }
        }

        switch (subtype) {
          case 'chart':
            List<ChartData> pieData = criteriaCountMap.entries
                .map((entry) => ChartData(
                      x: entry.value['${diamondCriteria}_name'],
                      y: entry.value['${stoneType}stone_count'],
                    ))
                .toList();

            return pieData;

          case 'grid':
            List<ChartData> pieGridData = criteriaCountMap.entries
                .map((entry) => ChartData(
                      x: entry.value['${diamondCriteria}_code'],
                      y: entry.value['${diamondCriteria}_name'],
                      z: entry.value['${stoneType}stone_count'],
                    ))
                .toList();
            // int ind = 1;
            // pieGridData.forEach((data) {
            //     print(
            //         'Index: ${ind}, $data');
            //         ind++;
            //   });
            return pieGridData;
        }

      default:
    }
  }

  // updateComparisonChartData(
  //   String type,
  //   daypNewChartData,
  //   String stoneType,
  //   dateFilterType, [
  //   String? subtype,
  // ]) {
  //   List<ChartData> data = [];
  //   List<ChartData> pieData = [];
  //   List<ChartData> gridData = [];
  //   List<ChartData> pieGridData = [];

  //   switch (type) {
  //     case 'timebased':
  //       for (String year in daypNewChartData.keys) {
  //         List<dynamic> yearData = daypNewChartData[year]!;

  //         int count = 0;
  //         for (var element in yearData) {
  //           List<Map<String, dynamic>> eventData =
  //               (element['event_data'] as List).cast<Map<String, dynamic>>();
  //           for (var eventItem in eventData) {
  //             count += eventItem[stoneType] as int;
  //           }
  //         }
  //         data.add(ChartData(
  //           x: year,
  //           y: count,
  //         ));
  //       }
  //       return data;

  //     case 'pieChart' || 'Pie Chart' || 'doughnutChart' || 'Doughnut Chart':
  //       Map<String, Map<String, dynamic>> criteriaCountMap = {};
  //       var stoneCriteriaObject = {};

  //       for (String year in daypNewChartData.keys) {
  //         List<dynamic> yearData = daypNewChartData[year];

  //         for (var element in yearData) {
  //           String criteriaName = element['${diamondCriteria}_name'];
  //           List<dynamic> eventData = element['event_data'];

  //           int shapeCount = 0;
  //           for (var event in eventData) {
  //             shapeCount += event[stoneType] as int;
  //           }

  //           if (criteriaCountMap.containsKey(criteriaName)) {
  //             criteriaCountMap[criteriaName]!['${stoneType}stone_count'] +=
  //                 shapeCount;
  //           } else {
  //             criteriaCountMap[criteriaName] = {
  //               '${diamondCriteria}_code': element['${diamondCriteria}_code'],
  //               '${diamondCriteria}_name': element['${diamondCriteria}_name'],
  //               '${stoneType}stone_count': shapeCount
  //             };
  //           }
  //         }
  //       }

  //       switch (subtype) {
  //         case 'chart':
  //           List<ChartData> pieData = criteriaCountMap.entries
  //               .map((entry) => ChartData(
  //                     x: entry.value['${diamondCriteria}_name'],
  //                     y: entry.value['${stoneType}stone_count'],
  //                   ))
  //               .toList();

  //           return pieData;

  //         case 'grid':
  //           List<ChartData> pieGridData = criteriaCountMap.entries
  //               .map((entry) => ChartData(
  //                     x: entry.value['${diamondCriteria}_code'],
  //                     y: entry.value['${diamondCriteria}_name'],
  //                     z: entry.value['${stoneType}stone_count'],
  //                   ))
  //               .toList();
  //           return pieGridData;
  //       }

  //     default:
  //   }
  // }

  // updateChartData(
  //     String time, daypChartData, String stoneType, dateFilterType) {
  //   List<ChartData> data = [];
  //   List<ChartData> pieData = [];
  //   if (selectedScenario == 'timebased') {
  //     switch (time) {
  //       case 'timebased':
  //         for (String year in daypChartData.keys) {
  //           List<dynamic> yearData = daypChartData[year]!;

  //           int count = 0;
  //           for (var element in yearData) {
  //             List<Map<String, dynamic>> eventData =
  //                 (element['event_data'] as List).cast<Map<String, dynamic>>();
  //             // for (var event in shape['event_data']) {
  //             // print("======================================== ${element} ");
  //             for (var eventItem in eventData) {
  //               count += eventItem[stoneType] as int;
  //             }
  //           }

  //           // old api function
  //           // yearData.forEach((element) {
  //           //   count += element[stoneType] as int;
  //           // });
  //           data.add(ChartData(year, count));
  //         }
  //         return data;

  //       case 'packetRate':
  //         filteredData = [
  //           ChartData('Category A', 35),
  //           ChartData('Category B', 28),
  //           ChartData('Category C', 34),
  //           ChartData('Category D', 32),
  //           ChartData('Category E', 40),
  //         ];
  //         xAxisType = 'category';
  //         break;

  //       case 'pieChart' || 'Pie Chart':
  //         Map<String, Map<String, dynamic>> criteriaCountMap = {};
  //         var stoneCriteriaObject = {};

  //         for (String year in daypChartData.keys) {
  //           List<dynamic> yearData = daypChartData[year];

  //           for (var element in yearData) {
  //             print('---------year ${element}');
  //             String criteriaName = element[diamondCriteria];
  //             List<dynamic> eventData = element['event_data'];
  //             int shapeCount = 0;

  //             for (var event in eventData) {
  //               shapeCount += event[stoneType] as int;
  //             }

  //             if (criteriaCountMap.containsKey(criteriaName)) {
  //               // criteriaCountMap[criteriaName] =
  //               //     criteriaCountMap[criteriaName]! + shapeCount;
  //               print(
  //                   '${criteriaCountMap[criteriaName]} -------------criteriaName');

  //               criteriaCountMap[criteriaName]!['${stoneType}stone_count'] +=
  //                   shapeCount;
  //             } else {
  //               criteriaCountMap[criteriaName] = {
  //                 'shape_code': element['shape_code'],
  //                 'shape_name': element['shape_name'],
  //                 '${stoneType}stone_count': shapeCount
  //               };

  //               // shapeCount;
  //             }
  //           }
  //         }

  //         print('---------chartData ${criteriaCountMap.entries}');
  //         // List<ChartData> pieData = criteriaCountMap.entries
  //         //     .map((entry) => ChartData(entry.key, entry.value))
  //         //     .toList();
  //         List<ChartData> pieData = criteriaCountMap.entries
  //             .map((entry) => ChartData(entry.value['shape_name'],
  //                 entry.value['${stoneType}stone_count']))
  //             .toList();

  //         return pieData;

  //       // old api function
  //       // case 'pieChart' || 'Pie Chart':
  //       //   Map<String, int> shapeCountMap = {};
  //       //   for (String year in daypChartData.keys) {
  //       //     List<dynamic> yearData = daypChartData[year];
  //       //     // List<Map<String, dynamic>> yearData = List<Map<String, dynamic>>.from(daypChartData[year]!);
  //       //     // final String diamondCriteria;
  //       //     int count = 0;

  //       //     yearData.forEach((element) {
  //       //       // for (var element in dataList) {
  //       //       String diamondCriteria = element['shape_name'];
  //       //       int stoneTypeCount = element[stoneType];

  //       //       // Update the count in the map
  //       //       if (shapeCountMap.containsKey(diamondCriteria)) {
  //       //         shapeCountMap[diamondCriteria] =
  //       //             shapeCountMap[diamondCriteria]! + stoneTypeCount;
  //       //       } else {
  //       //         shapeCountMap[diamondCriteria] = stoneTypeCount;
  //       //       }
  //       //       // }
  //       //       // map[element[diamondCriteria]] = element[stoneType];
  //       //       // count += element[stoneType] as int;
  //       //       // print(
  //       //       //     "${element[stoneType]} $yearData $element======================================== $year");
  //       //       // if (diamondCriteria == element[diamondCriteria]) {

  //       //       // }
  //       //     });
  //       //     // pieData.add(
  //       //     //   ChartData('David', count),
  //       //     // );
  //       //   }
  //       //   pieData = shapeCountMap.entries
  //       //       .map((entry) => ChartData(entry.key, entry.value))
  //       //       .toList();
  //       //   //               pieData.forEach((e) {
  //       //   //   print('Shape: ${e.diamondCriteria}, Count: ${e.count}');
  //       //   // });
  //       //   print('==========================piiiiiieeee$pieData');
  //       //   return pieData;

  //       case 'doughnutChart' || 'Doughnut Chart':
  //         Map<String, int> criteriaCountMap = {};

  //         for (String year in daypChartData.keys) {
  //           List<dynamic> yearData = daypChartData[year];

  //           // print('${year}yearyearyearyearyearyear');
  //           for (var element in yearData) {
  //             String criteriaName = element[diamondCriteria];
  //             List<dynamic> eventData = element['event_data'];
  //             int shapeCount = 0;

  //             for (var event in eventData) {
  //               shapeCount += event[stoneType] as int;
  //             }

  //             if (criteriaCountMap.containsKey(criteriaName)) {
  //               criteriaCountMap[criteriaName] =
  //                   criteriaCountMap[criteriaName]! + shapeCount;
  //             } else {
  //               criteriaCountMap[criteriaName] = shapeCount;
  //             }
  //           }
  //         }

  //         List<ChartData> pieData = criteriaCountMap.entries
  //             .map((entry) => ChartData(entry.key, entry.value))
  //             .toList();

  //         return pieData;

  //       default:
  //     }
  //   } else if (selectedScenario == 'packetRate') {}
  // }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = SrkayHelperFunctions.isDarkMode(context);
    // ignore: non_constant_identifier_names
    final SRKTextTheme = isDarkTheme
        ? SrkayTextTheme.darkTextTheme
        : SrkayTextTheme.lightTextTheme;



    return Skeletonizer(
      effect: ShimmerEffect(
        baseColor: isDarkTheme
            ? const Color.fromARGB(255, 32, 32, 32)
            : SrkayColors.primaryBackground,

        highlightColor:
            isDarkTheme ? Color(0xFFBDBDBD) : SrkayColors.buttonDisabled,
        // Color(0xFFBDBDBD), Color(0xFFE0E0E0)
        //  isDarkTheme ? const Color(0xFF424242) : SrkayColors.dark,
        duration: Duration(seconds: 2),
      ),
      // justifyMultiLineText: true,
      // textBoneBorderRadius: TextBoneBorderRadius.fromHeightFactor(.5),
      enabled: _skeletonEnabled,
      enableSwitchAnimation: true,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: SRKAppbar(
          backgroundColor: SrkayColors.primary,
          leadingIcon: Icons.menu_rounded,
          leadingOnPressed: () => Scaffold.of(context).openDrawer(),
          // leadingOnPressed: () => _scaffoldKey.currentState?.openDrawer(),
          centerTitle: true,
          title: Row(
            // crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                // '${selectedData.toString()} Dashboard',
                'Gauri Dashboard',
                style: SRKTextTheme.headlineSmall?.copyWith(
                  color: SrkayColors.textWhite,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {
                  _showDateRangePickerDialog(context);
                },
                icon: const Icon(Icons.calendar_month_outlined)),
          ],
        ),
        drawer: const DrawerMenu(),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: BlocConsumer<DaypCountCubit, DaypCountState>(
                listener: (context, state) {
                  if (state is DaypCountErrorState) {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          ErrorDialog(isDarkTheme: isDarkTheme),
                    );
                    // showDialog(
                    //   context: context,
                    //   builder: (context) {
                    //     return
                    //     Dialog(
                    //         backgroundColor: isDarkTheme
                    //             ? const Color.fromARGB(255, 32, 32, 32)
                    //             : SrkayColors.primaryBackground,
                    //         child: Container(
                    //           width: 150,
                    //           height: 200,
                    //           padding: const EdgeInsets.symmetric(
                    //               horizontal: 12.0, vertical: 8.0),
                    //           decoration: BoxDecoration(
                    //             // color: Colors.white, // Background color of the container
                    //             borderRadius: BorderRadius.circular(
                    //                 6.0), // Rounded corners if desired
                    //           ),
                    //           child: Column(
                    //             // crossAxisAlignment: CrossAxisAlignment.center,
                    //             // mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               Align(
                    //                   alignment: Alignment.topRight,
                    //                   child: IconButton(
                    //                       onPressed: () {
                    //                         Navigator.pop(context);
                    //                       },
                    //                       icon:
                    //                           const Icon(Icons.close_rounded))),
                    //               Container(
                    //                 padding: const EdgeInsets.only(bottom: 8),
                    //                 // alignment: Alignment.topCenter,
                    //                 child: Image.asset(
                    //                   // "lib/utils/assets/images/code-error.png",
                    //                   // "lib/utils/assets/images/sad.png",
                    //                   "lib/utils/assets/images/chatbot2.png",
                    //                   // "lib/utils/assets/images/dizzy-robot.png",
                    //                   // "lib/utils/assets/images/browser.png",
                    //                   width: 55, // Width of the icon
                    //                   height: 55, // Height of the icon
                    //                 ),
                    //               ),
                    //               // SizedBox(
                    //               //   height: 30,
                    //               // ),
                    //               Center(
                    //                 child: SizedBox(
                    //                   // width: 350,
                    //                   // height: 300,
                    //                   child: Text(
                    //                     "Whoops! We messed up!\nYou can contact our team and we can help out!",
                    //                     style: SRKTextTheme.displayLarge,
                    //                     textAlign: TextAlign
                    //                         .center, // Center align the text
                    //                   ),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ));
                    //   },
                    // );
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(content: Text(state.errorMessage)),
                    // );
                  } else if (state is DaypCountLoadedState) {
                    // print('${state.daypCountData} state.daypCountDatastate.daypCountData');
                    setState(() {
                      _skeletonEnabled = !_skeletonEnabled;
                      daypChartData = state.daypCountData ?? {};
                      // List<String> dataType = diamondCriteria.split('_');
                      _countData(daypChartData[diamondCriteria]);
                    });
                  } else if (state is DaypComparisonCountLoadedState) {
                    setState(() {
                      _skeletonEnabled = !_skeletonEnabled;
                      daypChartComparisionData = state.daypComparisonData ?? {};
                      // List<String> dataType = diamondCriteria.split('_');
                      // _countData(daypChartData[diamondCriteria]);
                    });
                  }
                },
                builder: (context, state) {
                  if (state is DaypCountLoadingState) {
                    return DaypDashboardSkeleton();
                  } else if (state is DaypCountLoadedState) {
                    // print('state.daypCountDatastate.daypCountData ${state.daypCountData[diamondCriteria]} ');
                    // daypChartData = state.daypCountData;
                    // List<String> dataType = diamondCriteria.split('_');
                    // _countData(daypChartData[dataType[0]]);
                    // BlocProvider.of<DaypCountCubit>(context).daypCountData!;
                    // print(
                    //     "===============daypChartData ${state.daypCountData[diamondCriteria]} ");
                    if (isChartDropDownVisible &&
                        _comparisonStartDate != null) {
                      return buildDaypChart(
                          daypChartData: daypChartData[diamondCriteria] ?? {},
                          daypChartComparisionData:
                              daypChartComparisionData[diamondCriteria] ?? {});
                    } else {
                      return buildDaypChart(
                          daypChartData: daypChartData[diamondCriteria] ?? {});
                    }
                    // return Container(child: Text("sadf"));
                    // }
                  } else if (state is DaypComparisonCountLoadedState) {
                    // print(
                    //     "===============daypComparisonData ${state.daypComparisonData[diamondCriteria]} ");
                    return buildDaypChart(
                        daypChartData: daypChartData[diamondCriteria] ?? {},
                        daypChartComparisionData:
                            state.daypComparisonData[diamondCriteria]);
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            // BottomTabBar(
            //     onShowModal: () => showChartSelectionModal(context),
            //     icon: getChartIcon(selectedChart)),
          ],
        ),
        // ),
        extendBody: true,
        floatingActionButton: FloatingActionButton(
          backgroundColor: SrkayColors.primary,
          foregroundColor: SrkayColors.dark,
          // splashColor: SrkayColors.white,
          onPressed: () => {
            _showChartCompareModal(context),
            setState(() {
              isChartDropDownVisible = true;
            })
          },
          shape: const CircleBorder(),
          child: const Icon(Icons.add_rounded),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomTabBar(
            onShowModal: () => showChartSelectionModal(context),
            icon: getChartIcon(selectedChart)),
      ),
    );
  }

  Widget buildDaypChart(
      {required Map<String, dynamic> daypChartData,
      Map<String, dynamic>? daypChartComparisionData}) {
    final isDarkTheme = SrkayHelperFunctions.isDarkMode(context);
    // ignore: non_constant_identifier_names
    final SRKTextTheme = isDarkTheme
        ? SrkayTextTheme.darkTextTheme
        : SrkayTextTheme.lightTextTheme;

    return SingleChildScrollView(
      child: Column(
        children: [
          TickerTape(
              // tickerData: sampleData,
              tickerData: GoriSampleData,
              velocity: const Velocity(pixelsPerSecond: Offset(50, 0))),
          // SRKTickerTape(
          //   srktickerData: SRKsampleData,
          // ),
          const SizedBox(
            height: 10,
          ),
          if (selectedChart == 'Doughnut Chart' || selectedChart == 'Pie Chart')
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // const SizedBox(
                  //   height: 40,
                  // ),
                  Container(
                    child: SlidingSegmentedButton(
                      initialValue: criteriaInitialValue,
                      textList: const {
                        1: Text('Shape'),
                        2: Text('Cert'),
                        3: Text('Cut'),
                        4: Text('Cla'),
                        5: Text('Col'),
                      },
                      onValueChanged: (v) {
                        setState(() {
                          _skeletonEnabled = true;
                        });
                        // print(v);
                        switch (v) {
                          case 1:
                            DaypDashboardCountData(
                                type: "event_date",
                                timeFrame: selectedInterval,
                                diamondCriteria: "shape",
                                startDate: _startDate,
                                endDate: _endDate);
                            setState(() {
                              diamondCriteria = "shape";
                              criteriaInitialValue = 1;
                            });
                            break;
                          case 2:
                            DaypDashboardCountData(
                                type: "event_date",
                                timeFrame: selectedInterval,
                                diamondCriteria: "certificate",
                                startDate: _startDate,
                                endDate: _endDate);
                            setState(() {
                              diamondCriteria = "certificate";
                              criteriaInitialValue = 2;
                            });
                            break;
                          case 3:
                            DaypDashboardCountData(
                                type: "event_date",
                                timeFrame: selectedInterval,
                                diamondCriteria: "cut",
                                startDate: _startDate,
                                endDate: _endDate);
                            setState(() {
                              diamondCriteria = "cut";
                              criteriaInitialValue = 3;
                            });
                            break;
                          case 4:
                            DaypDashboardCountData(
                                type: "event_date",
                                timeFrame: selectedInterval,
                                diamondCriteria: "clarity",
                                startDate: _startDate,
                                endDate: _endDate);
                            setState(() {
                              diamondCriteria = "clarity";
                              criteriaInitialValue = 4;
                            });
                            break;
                          case 5:
                            DaypDashboardCountData(
                                type: "event_date",
                                timeFrame: selectedInterval,
                                diamondCriteria: "color",
                                startDate: _startDate,
                                endDate: _endDate);
                            setState(() {
                              diamondCriteria = "color";
                              criteriaInitialValue = 5;
                            });
                            break;
                          default:
                            DaypDashboardCountData(
                                type: "event_date",
                                timeFrame: selectedInterval,
                                diamondCriteria: diamondCriteria,
                                startDate: _startDate,
                                endDate: _endDate);
                        }
                      },
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomCupertinoPicker(
                    stoneTypeArray: stoneTypeArray,
                    onStoneTypeChanged: (selectedStoneType) {
                      setState(() {
                        stoneType = selectedStoneType;
                      });
                    },
                  ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: isDarkTheme
                  //         ? const Color.fromARGB(255, 32, 32, 32)
                  //         : SrkayColors.primary,
                  //     borderRadius: BorderRadius.circular(6),
                  //   ),
                  //   // width: 80,
                  //   width: 100,
                  //   child: CupertinoPicker(
                  //     // diameterRatio: 2.0,
                  //     // backgroundColor: isDarkTheme
                  //     //     ? Color.fromARGB(255, 32, 32, 32)
                  //     //     : SrkayColors.primaryBackground,
                  //     itemExtent: 32.0,
                  //     onSelectedItemChanged: (index) {
                  //       Iterable<String> values = stoneTypeArray[index].values;
                  //       print('${values} iiiiiiiiiiiiiiiiiiiii');
                  //       setState(() {
                  //         //   stoneType = stoneTypeArray[index];
                  //         stoneType = values.first;
                  //       });
                  //     },
                  //     selectionOverlay:
                  //         const CupertinoPickerDefaultSelectionOverlay(
                  //       background: Colors.transparent,
                  //     ),
                  //     children: List.generate(
                  //       stoneTypeArray.length,
                  //       (index) {
                  //         return Center(
                  //           child: Text(
                  //             '${stoneTypeArray[index].keys}'
                  //             // stoneTypeArray[index],
                  //             // stoneTypeArray[index],
                  //             ,
                  //             style: const TextStyle(
                  //               color: Colors.white70,
                  //               fontSize: 16.0,
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           ),
                  //         );
                  //       },
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            )
          else
            Container(),
          // ),
          const SizedBox(
            height: 10,
          ),
          // Text(
          //   'Selected Type: ${stoneType}',
          //   style: SRKTextTheme.bodyMedium,
          // ),

          Container(
            width: MediaQuery.of(context).size.width,
            height: selectedChart == 'Doughnut Chart'
                // ? MediaQuery.of(context).size.height / (5 / 2)
                ? 380
                : 380,
            // decoration: BoxDecoration(
            //   border: Border.all(width: 1, color: SrkayColors.darkerGrey),
            //   borderRadius: BorderRadius.circular(6),
            // ),
            child: selectedChart == 'Bar Chart'
                ? SRKColumnBarChart(
                    isDateFilterVisible: true,
                    isFilterVisible: true,
                    chartData: updateChartData(
                        'timebased', daypChartData, stoneType, dateFilterType),
                    xAxisType: 'timebased',
                    // chartTitle: "Criteria - Wise Stone Count",
                    chartTitle:
                            "Products History${_startDate != null ? " ($_startDate to $_endDate)" : ''}",

                    onDefinedDataFilterChanged: onDefinedDataFilterChanged,
                  )
                : selectedChart == 'Line Chart'
                    ? SfLineChart(
                        isDateFilterVisible: true,
                        chartData: updateChartData('timebased', daypChartData,
                            stoneType, dateFilterType),
                        xAxisType: 'timebased',
                        // chartTitle: "Criteria - Wise Stone Count",
                        chartTitle:
                            "Products History${_startDate != null ? " ($_startDate to $_endDate)" : ''}",
                        initialValue: _initialValue,
                        onDefinedDataFilterChanged: onDefinedDataFilterChanged,
                        customPicker: CustomCupertinoPicker(
                          stoneTypeArray: stoneTypeArray,
                          onStoneTypeChanged: (selectedStoneType) {
                            print(
                                '${selectedStoneType}GoriSampleDataGoriSampleData');
                            setState(() {
                              stoneType = selectedStoneType;
                            });
                          },
                        ),
                      )
                    : selectedChart == 'Pie Chart'
                        ? SRKSfPieChart(
                            isDateFilterVisible: true,
                            chartData: updateChartData(
                                'pieChart',
                                daypChartData,
                                stoneType,
                                dateFilterType,
                                "chart"),
                            xAxisType: 'timebased',
                             // chartTitle: "Criteria - Wise Stone Count",
                        chartTitle: "Products Categories${_startDate != null ? " ($_startDate to $_endDate)" : ''}",
                          )
                        : selectedChart == 'Doughnut Chart'
                            ? SRKSfDoughnutChart(
                                isDateFilterVisible: true,
                                chartData: updateChartData(
                                    'pieChart',
                                    daypChartData,
                                    stoneType,
                                    dateFilterType,
                                    "chart"),
                                xAxisType: 'timebased',
                                 // chartTitle: "Criteria - Wise Stone Count",
                        chartTitle:
                            "Products Categories${_startDate != null ? " ($_startDate to $_endDate)" : ''}",
                              )
                            : SfLineChart(
                                isDateFilterVisible: true,
                                chartData: updateChartData('timebased',
                                    daypChartData, stoneType, dateFilterType),
                                xAxisType: 'timebased',
                                 // chartTitle: "Criteria - Wise Stone Count",
                        chartTitle: "Products History${_startDate != null ? " ($_startDate to $_endDate)" : ''}",
                                initialValue: _initialValue,
                                onDefinedDataFilterChanged:
                                    onDefinedDataFilterChanged,
                              ),
          ),
          const SizedBox(
            height: 5,
          ),
          (daypChartComparisionData != null)
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: selectedComparisonChart == 'Doughnut Chart'
                      // ? MediaQuery.of(context).size.height / (5 / 2)
                      ? 380
                      : 380,
                  // decoration: BoxDecoration(
                  //   border: Border.all(width: 1, color: SrkayColors.darkerGrey),
                  //   borderRadius: BorderRadius.circular(6),
                  // ),
                  child: selectedComparisonChart == 'Bar Chart'
                      ? SRKColumnBarChart(
                          isDateFilterVisible: false,
                          isFilterVisible: true,
                          chartData: updateComparisonChartData(
                              'timebased',
                              daypChartComparisionData,
                              stoneType,
                              dateFilterType),
                          xAxisType: 'timebased',
                           // chartTitle: "Criteria - Wise Stone Count",
                                                         chartTitle:
                            "Products History (${_comparisonStartDate} to ${_comparisonEndDate})",
                          onDefinedDataFilterChanged:
                              onDefinedDataFilterChanged,
                        )
                      : selectedComparisonChart == 'Line Chart'
                          ? SfLineChart(
                              isDateFilterVisible: false,
                              chartData: updateComparisonChartData(
                                  'timebased',
                                  daypChartComparisionData,
                                  stoneType,
                                  dateFilterType),
                              xAxisType: 'timebased',
                               // chartTitle: "Criteria - Wise Stone Count",
                                                       chartTitle:
                            "Products History (${_comparisonStartDate} to ${_comparisonEndDate})",
                              initialValue: _initialValue,
                              onDefinedDataFilterChanged:
                                  onDefinedDataFilterChanged,
                            )
                          : selectedComparisonChart == 'Pie Chart'
                              ? SRKSfPieChart(
                                  isDateFilterVisible: false,
                                  chartData: updateComparisonChartData(
                                      'pieChart',
                                      daypChartComparisionData,
                                      stoneType,
                                      dateFilterType,
                                      "chart"),
                                  xAxisType: 'timebased',
                                  chartTitle:
                            "Products Categories (${_comparisonStartDate} to ${_comparisonEndDate})",
                                )
                              : selectedComparisonChart == 'Doughnut Chart'
                                  ? SRKSfDoughnutChart(
                                      isDateFilterVisible: false,
                                      chartData: updateComparisonChartData(
                                          'pieChart',
                                          daypChartComparisionData,
                                          stoneType,
                                          dateFilterType,
                                          "chart"),
                                      xAxisType: 'timebased',
                                      chartTitle:
                            "Products Categories (${_comparisonStartDate} to ${_comparisonEndDate})",
                                    )
                                  : SfLineChart(
                                      isDateFilterVisible: false,
                                      chartData: updateComparisonChartData(
                                          'timebased',
                                          daypChartComparisionData,
                                          stoneType,
                                          dateFilterType),
                                      xAxisType: 'timebased',
                                      chartTitle:
                            "Products History (${_comparisonStartDate} to ${_comparisonEndDate})",
                                      initialValue: _initialValue,
                                      onDefinedDataFilterChanged:
                                          onDefinedDataFilterChanged,
                                    ),
                )
              : Container(),
          Container(
            height: 100,
            margin: EdgeInsets.all(4),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              // itemCount: sampleData.length,
              itemCount: GoriSampleData.length,
              itemBuilder: (context, index) {
                // Access the key and value from the current map at the given index
                // String key = stoneTypeArray[index].keys.first;
                // String value = stoneTypeArray[index].values.first;
                // TickerData ticker = sampleData[index];
                TickerData ticker = GoriSampleData[index];
                int adjustedPrice = (ticker.price / 1000).toInt();
                return Container(
                  // padding: EdgeInsets.symmetric(vertical: 8),
                  width: MediaQuery.of(context).size.width * 0.245,
                  child: Center(
                    child: Card(
                      color: isDarkTheme
                          ? Color.fromARGB(255, 12, 12, 12)
                          : SrkayColors.dark,
                      // margin: EdgeInsets.all(4),
                      child: ListTile(
                        title: Text(
                          '${adjustedPrice}K',
                          style: SRKTextTheme.titleMedium?.copyWith(
                            fontSize: 14.0, fontWeight: FontWeight.w600,
                            // overflow: TextOverflow.ellipsis,
                          ),
                        ), // Display the symbol
                        subtitle: Text(
                          '${ticker.symbol}',
                          style: SRKTextTheme.bodySmall?.copyWith(
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // trailing: const Icon(
                        //   Icons.ac_unit,
                        //   size: 32,
                        // ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // if (selectedChart == "Line Chart" || selectedChart == "Bar Chart")
          //   SlidingSegmentedButton(
          //     // initialValue: 3,
          //     textList: const {
          //       1: Text('Selected'),
          //       2: Text('Uploaded'),
          //       3: Text('Confirmed'),
          //       4: Text('Bided'),
          //     },
          //     onValueChanged: (v) {
          //       // print(v);
          //       switch (v) {
          //         case 1:
          //           updateChartData(selectedChart, daypChartData, "selected",
          //               dateFilterType);
          //           setState(() {
          //             stoneType = "selected";
          //           });
          //           break;
          //         case 2:
          //           updateChartData(selectedChart, daypChartData, "uploaded",
          //               dateFilterType);
          //           setState(() {
          //             stoneType = "uploaded";
          //           });
          //           break;
          //         case 3:
          //           updateChartData(selectedChart, daypChartData, "confirmed",
          //               dateFilterType);
          //           setState(() {
          //             stoneType = "confirmed";
          //           });
          //           break;
          //         case 4:
          //           updateChartData(
          //               selectedChart, daypChartData, "bided", dateFilterType);
          //           setState(() {
          //             stoneType = "bided";
          //           });
          //           break;
          //         default:
          //           updateChartData(selectedChart, daypChartData, "confirmed",
          //               dateFilterType);
          //       }
          //     },
          //     borderRadius: BorderRadius.circular(6),
          //   ),
          // const SizedBox(
          //   height: 20,
          // ),

          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                alignment: Alignment.centerLeft,
                child: Text("Products Info",
                  style: SRKTextTheme.titleLarge,
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  child: DataGridView(
                    mainDate: "${_startDate} to\n${_endDate}",
                    compareDate:
                        "${_comparisonStartDate} to\n${_comparisonEndDate}",
                    isCompareGridVisible: isChartDropDownVisible,
                    chartData: updateChartData('pieChart', daypChartData,
                        stoneType, dateFilterType, "grid"),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 64,
          )
          // Container(
          //   height: 30,
          //   child: CustomSlidingSegmentedControl<int>(
          //     initialValue: 3,
          //     children: const {
          //       1: Text('Selected'),
          //       2: Text('Uploaded'),
          //       3: Text('Confirmed'),
          //       4: Text('Bided'),
          //     },
          //     decoration: BoxDecoration(
          //       color: isDarkTheme
          //           ? Color.fromARGB(255, 32, 32, 32)
          //           : SrkayColors.dark,
          //       borderRadius: BorderRadius.circular(8),
          //     ),
          //     thumbDecoration: BoxDecoration(
          //       color: SrkayColors.primary,
          //       borderRadius: BorderRadius.circular(6),
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.black.withOpacity(.3),
          //           blurRadius: 4.0,
          //           spreadRadius: 1.0,
          //           offset: const Offset(
          //             0.0,
          //             2.0,
          //           ),
          //         ),
          //       ],
          //     ),
          //     duration: const Duration(milliseconds: 300),
          //     curve: Curves.easeInToLinear,
          //     onValueChanged: (v) {
          //       print(v);
          //       switch (v) {
          //         case 1:
          //         updateChartData('timebased', daypChartData, "selected");
          //         setState(() {
          //           stoneType = "selected";
          //         });
          //           break;
          //         case 2:
          //         updateChartData('timebased', daypChartData, "uploaded");
          //         setState(() {
          //           stoneType = "uploaded";
          //         });
          //           break;
          //         case 3:
          //         updateChartData('timebased', daypChartData, "confirmed");
          //         setState(() {
          //           stoneType = "confirmed";
          //         });
          //           break;
          //         case 4:
          //         updateChartData('timebased', daypChartData, "bided");
          //         setState(() {
          //           stoneType = "bided";
          //         });
          //           break;
          //         default:
          //         updateChartData('timebased', daypChartData, "confirmed");
          //       }
          //     },
          //   ),
          // )
        ],
      ),
    );
  }

  onDefinedDataFilterChanged(int v) {
    setState(() {
      _skeletonEnabled = true;
    });
    // print('$v ------v');
    switch (v) {
      case 1:
        DaypDashboardCountData(
            type: "confirm_date",
            timeFrame: 'year',
            diamondCriteria: diamondCriteria,
            startDate: _startDate,
            endDate: _endDate);
        // updateChartData(
        //     selectedChart, daypChartData, stoneType, dateFilterType);
        setState(() {
          stoneType = stoneType;
          _initialValue = 1;
        });
        break;
      case 2:
        // DaypDashboardCountData(
        //     type: "confirm_date",
        //     timeFrame: 'month',
        //     diamondCriteria: diamondCriteria,
        //     startDate: _startDate,
        //     endDate: _endDate);
        // updateChartData(
        //     selectedChart, daypChartData, stoneType, '5Y');
        setState(() {
          stoneType = stoneType;
          _initialValue = 2;
        });
        break;
      case 3:
        // DaypDashboardCountData(
        //     type: "event_date",
        //     timeFrame: 'year',
        //     diamondCriteria: diamondCriteria,
        //     startDate: _startDate,
        //     endDate: _endDate);
        // updateChartData(
        //     selectedChart, daypChartData, stoneType, '3Y');
        setState(() {
          stoneType = stoneType;
          _initialValue = 3;
        });
        break;
      case 4:
        // DaypDashboardCountData(
        //     type: "event_date",
        //     timeFrame: 'month',
        //     diamondCriteria: diamondCriteria,
        //     startDate: _startDate,
        //     endDate: _endDate);
        // updateChartData(
        //     selectedChart, daypChartData, stoneType, '12M');
        setState(() {
          stoneType = stoneType;
          _initialValue = 4;
        });
        break;
      default:
        // updateChartData(
        //     selectedChart, daypChartData, stoneType, dateFilterType);
        updateDateDuration();
    }
  }

  void _showDateRangePickerDialog(BuildContext context) {
    final isDarkTheme = SrkayHelperFunctions.isDarkMode(context);

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: isDarkTheme
              ? const Color.fromARGB(255, 32, 32, 32)
              : SrkayColors.primaryBackground,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: 400,
              height: 350,
              child: SRKDateRangePicker(
                initialChartType: selectedChart,
                isChartDropDownVisible: false,
                onDateRangeSelected: (start, end) {
                  _skeletonEnabled = true;
                  print(
                      '${start} _showDateRangePickerDialog_showDateRangePickerDialog $end');

                  DaypDashboardCountData(
                      type: "event_date",
                      timeFrame: 'month',
                      diamondCriteria: diamondCriteria,
                      startDate: start,
                      endDate: end);
                  setState(() {
                    _startDate = start;
                    _endDate = end;
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _showChartCompareModal(BuildContext context) {
    final isDarkTheme = SrkayHelperFunctions.isDarkMode(context);

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: isDarkTheme
              ? const Color.fromARGB(255, 32, 32, 32)
              : SrkayColors.primaryBackground,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: 400,
              height: 450,
              child: SRKDateRangePicker(
                isChartDropDownVisible: isChartDropDownVisible,
                chartComparisonVisible: (visible) {
                  setState(() {
                    isChartDropDownVisible = visible!;
                  });
                },
                initialChartType: selectedChart,
                selectedComparisonChart: selectedComparisonChart,
                comparisonStartDate: _comparisonStartDate,
                comparisonEndDate: _comparisonEndDate,
                selectedChart: (type) {
                  setState(() {
                    selectedComparisonChart = type!;
                  });
                },
                onDateRangeSelected: (start, end) {
                  _skeletonEnabled = true;

                  DaypDashboardCountData(
                    type: "event_date",
                    timeFrame: 'month',
                    diamondCriteria: diamondCriteria,
                    startDate: start,
                    endDate: end,
                    isComparison: true,
                  );
                  setState(() {
                    _comparisonStartDate = start;
                    _comparisonEndDate = end;
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void showChartSelectionModal(BuildContext context) {
    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Select a Chart'),
                ListTile(
                  leading: const Icon(Icons.stacked_line_chart_rounded),
                  title: const Text('Line Chart'),
                  onTap: () => _selectChartAndCloseModal('Line Chart'),
                ),
                ListTile(
                  leading: const Icon(Icons.bar_chart_rounded),
                  title: const Text('Bar Chart'),
                  onTap: () => _selectChartAndCloseModal('Bar Chart'),
                ),
                ListTile(
                  leading: const Icon(Icons.pie_chart_rounded),
                  title: const Text('Pie Chart'),
                  onTap: () => _selectChartAndCloseModal('Pie Chart'),
                ),
                ListTile(
                  leading: const Icon(Icons.donut_large_rounded),
                  title: const Text('Doughnut Chart'),
                  onTap: () => _selectChartAndCloseModal('Doughnut Chart'),
                ),
                ListTile(
                  leading: const Icon(Icons.scatter_plot_outlined),
                  title: const Text('Scatter Chart'),
                  onTap: () => _selectChartAndCloseModal('Scatter Chart'),
                ),
                ListTile(
                  leading: const Icon(Icons.add_chart_outlined),
                  title: const Text('Charts'),
                  onTap: () => _selectChartAndCloseModal('Charts'),
                ),
                ListTile(
                  leading: const Icon(Icons.add_chart_outlined),
                  title: const Text('Charts'),
                  onTap: () => _selectChartAndCloseModal('Charts'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _selectChartAndCloseModal(
    String chartType,
  ) {
    setState(() {
      selectedChart = chartType;
    });
    Navigator.pop(context);
  }
}

class ChartData {
  ChartData({
    this.index,
    required this.x,
    required this.y,
    this.z,
    this.color,
  });

  final int? index;
  final dynamic x;
  final dynamic y;
  final int? z;
  final Color? color;
}
