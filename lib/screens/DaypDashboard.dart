import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc_cubit/dayp_event/cubit/dayp_cubit.dart';
import 'package:flutter_application_1/charts/ColumnBarChart.dart';
import 'package:flutter_application_1/charts/LineChart.dart';
import 'package:flutter_application_1/charts/PieChart.dart';
// import 'package:flutter_application_1/charts/BarChart.dart';
import 'package:flutter_application_1/screens/examples/homeScreen.dart';
import 'package:flutter_application_1/widgets/tickertape/ticker_tape.dart';
import 'package:flutter_application_1/utils/constants/colors.dart';
import 'package:flutter_application_1/utils/helper/helper_functions.dart';
import 'package:flutter_application_1/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter_application_1/widgets/bottom-tab-bar/BottomTabBar.dart';
import 'package:flutter_application_1/widgets/appbar/appbar.dart';
// import 'package:flutter_application_1/widgets/date-range-picker/date_range_picker.dart';
// import 'package:flutter_application_1/widgets/tickertape/ticker_tape.dart';
// import 'package:flutter_application_1/widgets/BottomTabBar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'ticker_tape.dart';

class DaypDashboard extends StatefulWidget {
  const DaypDashboard({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DaypDashboardState createState() => _DaypDashboardState();
}

class _DaypDashboardState extends State<DaypDashboard> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  double selected = 0.0;
  double uploaded = 0.0;
  double confirmed = 0.0;
  String selectedChart = 'Charts';
  String selectedData = 'Dayp';
  List pieChartData = [];
  List<TickerData> sampleData = [
    TickerData(symbol: 'SELECTED', price: 150.0, change: 1.5),
    TickerData(symbol: 'UPLOADED', price: 2800.0, change: -20.0),
    TickerData(symbol: 'CONFIRMED', price: 3400.0, change: 15.0),
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
  String selectedInterval = 'yearly'; 
  List<ChartData> filteredData = [
    ChartData(DateTime(2020, 1, 1), 35),
    ChartData(DateTime(2020, 2, 1), 28),
  ];
  String xAxisType = 'datetime';
  @override
  void initState() {
    super.initState();
    DaypDashboardData();
    // updateChartData();
  }

  // ignore: non_constant_identifier_names
  void DaypDashboardData() async {
    final SharedPreferences prefs = await _prefs;
    var payload = {"type": "event_date", "timeframe": "year"};

    // ignore: use_build_context_synchronously
    context
        .read<DaypCubit>()
        // ignore: use_build_context_synchronously
        .DaypApi(context: context, payload: payload);
  }

  Future<void> _countData(pieChartData) async {
    double newSelected = 0.0;
    double newUploaded = 0.0;
    double newConfirmed = 0.0;

    pieChartData?.forEach((val) {
      if (val["selected"] != null) {
        newSelected += val["selected"];
      }
      if (val["uploaded"] != null) {
        newUploaded += val["uploaded"];
      }
      if (val["confirm"] != null) {
        newConfirmed += val["confirm"];
      }
    });

    setState(() {
      selected = newSelected;
      uploaded = newUploaded;
      confirmed = newConfirmed;
      sampleData = [
        TickerData(symbol: 'SELECTED', price: selected, change: 1.5),
        TickerData(symbol: 'UPLOADED', price: uploaded, change: -20.0),
        TickerData(symbol: 'CONFIRMED', price: confirmed, change: 15.0),
      ];
    });
  }

  updateChartData(String time, pieChartData) {
    List<ChartData> data = [];
    int count = 0;
    if (selectedScenario == 'timebased') {
      switch (selectedScenario) {
        case 'timebased':
          pieChartData.forEach((element) => {
                count = (element["confirm"] == 1) ? count + 1 : count + 0,
                // print('${element["event_id"]} ------------event_date $count'),
                data.add(ChartData(element["timeframe"], count))
                // data.add(ChartData(DateTime(element["event_date"]).year, count))
                // chartData.add(ChartData(DateTime(element["timeframe"]), count_event))
              });
          // setState(() {
          //   filteredData = data;
          // },);
          return data;
        // xAxisType = 'datetime';
        // break;

        case 'packetRate':
          filteredData = [
            ChartData('Category A', 35),
            ChartData('Category B', 28),
            ChartData('Category C', 34),
            ChartData('Category D', 32),
            ChartData('Category E', 40),
          ];
          xAxisType = 'category';
          break;

        default:
      }
      // Prepare time-based data
    } else if (selectedScenario == 'packetRate') {
      // Prepare packet rate data
    }
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = SrkayHelperFunctions.isDarkMode(context);
    // ignore: non_constant_identifier_names
    final SRKTextTheme = isDarkTheme
        ? SrkayTextTheme.darkTextTheme
        : SrkayTextTheme.lightTextTheme;

    // final List<TickerData> sampleData = [
    //   TickerData(symbol: 'SELECTED', price: selected, change: 1.5),
    //   TickerData(symbol: 'UPLOADED', price: uploaded, change: -20.0),
    //   TickerData(symbol: 'CONFIRMED', price: confirmed, change: 15.0),
    //   // Add more sample data as needed
    // ];
    return Scaffold(
      appBar: SRKAppbar(
        backgroundColor: SrkayColors.primary,
        leadingIcon: Icons.menu_rounded,
        leadingOnPressed: () {},
        centerTitle: true,
        title: Row(
          // crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${selectedData.toString()} Dashboard',
              style: SRKTextTheme.headlineSmall?.copyWith(
                color: SrkayColors.textWhite,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Text("adsfdsdfs")
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
      // while(s < e) {
      //   int m = s + (e - s) / 2;
      //   if(nums[m] >= nums[s]) {
          

      //   }
      // }
      // PreferredSize(
      //   preferredSize: const Size.fromHeight(44.0),
      //   child: AppBar(
      //       backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //       leading: TextButton(
      //         onPressed: () => (),
      //         style: ButtonStyle(
      //           minimumSize: WidgetStateProperty.all(const Size(150, 40)),
      //         ),
      //         child: Text(
      //           selectedData.toString(),
      //           style: SRKTextTheme.titleLarge?.copyWith(
      //             color: SrkayColors.primary,
      //             overflow: TextOverflow.ellipsis,
      //           ),
      //           //  .titleLarge!.copyWith(
      //           //   // color: SrkayColors.primary, // Using color from SrkayColors
      //           //   overflow: TextOverflow.ellipsis, // Adding text overflow property
      //           // ),
      //           // style: TextStyle(
      //           // color: Color.fromRGBO(20, 22, 20, 1),
      //           //   overflow: TextOverflow.ellipsis,
      //           //   // fontSize: 14,
      //           //   // Theme.of(context).textTheme.bodyMedium,
      //           // ),
      //         ),
      //       ),
      //       title: Text("Srkay Charts",
      //       style: SRKTextTheme.headlineMedium
      //       //  style: const TextStyle(
      //       //       fontSize: 16,
      //       //     ),
      //           ),
      //       actions: <Widget>[
      //         IconButton(
      //           icon: Icon(getChartIcon(selectedChart)),
      //           color: const Color.fromRGBO(20, 22, 20, 1),
      //           onPressed: () => (),
      //         ),
      //       ]
      //     ),
      // ),
      body: Column(
        children: [
          //  FutureBuilder<void>(
          //   future: _tickerDataFuture,
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return CircularProgressIndicator();
          //     } else {
          //       return Column(
          //         children: [
          //           Container(
          //             child: TickerTape(tickerData: sampleData, velocity: Velocity(pixelsPerSecond: Offset(50, 0))),
          //           ),
          //           Container(child: SRKTickerTape(srktickerData: SRKsampleData)),
          //         ],
          //       );
          //     }
          //   },
          // ),
          Flexible(
            flex: 5,
            child: BlocConsumer<DaypCubit, DaypState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is DaypLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is DaypLoadedState) {
                  // print("${state} ======BlocConsumer");
                  // pieChartData =  BlocProvider.of<DaypCubit>(context).DaypData!;
                  pieChartData = BlocProvider.of<DaypCubit>(context).DaypData!;
                  // print(" ///////////////// ${pieChartData}");

                  // _tickerDataFuture =
                  _countData(pieChartData);
                  // updateChartData('timebased', pieChartData);
                  return Column(
                    children: [
                      TickerTape(
                          tickerData: sampleData,
                          velocity:
                              const Velocity(pixelsPerSecond: Offset(50, 0))),

                      const SizedBox(
                        height: 10,
                      ),
                      // Container(
                      //   width: 400,
                      //   height: 300,
                      //   child: SfLineChart(
                      //     chartData: updateChartData('timebased', pieChartData),
                      //     xAxisType: 'timebased',
                      //   ),
                      // ),
                      // Container(
                      //   width: 400,
                      //   height: 300,
                      //   child: 
                      //   selectedChart == 'Bar Chart'
                      //       ? SRKColumnBarChart(
                      //           chartData:
                      //               updateChartData('timebased', pieChartData),
                      //           xAxisType: 'timebased', onDefinedDataFilterChanged: () => onDefinedDataFilterChanged,
                      //         )
                      //       : selectedChart == 'Line Chart'
                      //           ? SfLineChart(
                      //               chartData: updateChartData(
                      //                   'timebased', pieChartData),
                      //               xAxisType: 'timebased', onDefinedDataFilterChanged: () => onDefinedDataFilterChanged,
                      //             )
                      //       // : selectedChart == 'Pie Chart'
                      //       //     ? SRKSfPieChart(
                      //       //         chartData: updateChartData(
                      //       //             'timebased', pieChartData),
                      //       //         xAxisType: 'timebased',
                      //       //       )
                      //           : SfLineChart(
                      //               chartData: updateChartData(
                      //                   'timebased', pieChartData),
                      //               xAxisType: 'timebased', onDefinedDataFilterChanged: () => onDefinedDataFilterChanged,
                      //             ),
                      // ),
                    ],
                  );
                } else if (state is DaypErrorState) {
                  return const Center(child: Text('Error: {state.message}'));
                } else {
                  return Container();
                }
              },
            ),
          ),
          BottomTabBar(
              onShowModal: () => showChartSelectionModal(context),
              icon: getChartIcon(selectedChart)
              // onFilterButtonPressed: () {
              //   // Handle filter button press
              //   // _showFilterModal();
              // },
              ),
        ],
      ),
    );
  }

  // void _showFilterModal() {
  //   // Implement your filter modal logic here
  // }
  // void _countData(pieChartData) {

  //   pieChartData?.forEach((val) => {
  //    if (val["selected"] != null) {
  //     selected += val["selected"],
  //   },
  //    if (val["uploaded"] != null) {
  //     uploaded += val["uploaded"],
  //     // print('$uploaded ---------uploadeduploadeduploaded'),
  //   },
  //   if (val["confirmed"] != null) {
  //     confirmed += val["confirmed"],
  //     // print('$confirmed ---------confirmedconfirmedconfirmed'),
  //   }
  //   });
  //     final List<TickerData> sampleData = [
  //     TickerData(symbol: 'SELECTED', price: selected, change: 1.5),
  //     TickerData(symbol: 'UPLOADED', price: uploaded, change: -20.0),
  //     TickerData(symbol: 'CONFIRMED', price: confirmed, change: 15.0),
  //   ];
  // }

  IconData getChartIcon(String chartType) {
    switch (chartType) {
      case 'Line Chart': // Add when implemented
        return Icons.stacked_line_chart_rounded;
      case 'Bar Chart':
        return Icons.bar_chart_rounded;
      case 'Pie Chart':
        return Icons.pie_chart_rounded;
      case 'Donut Chart':
        return Icons.donut_large_rounded;
      case 'Scatter Chart':
        return Icons.scatter_plot_outlined;
      case 'Charts':
        return Icons.add_chart_outlined;
      default:
        return Icons.pie_chart_rounded;
    }
  }
void onDefinedDataFilterChanged(v) {

}

  void _showDateRangePickerDialog(BuildContext context) {
    final isDarkTheme = SrkayHelperFunctions.isDarkMode(context);
    // final SRKTextTheme = isDarkTheme ? SrkayTextTheme.darkTextTheme : SrkayTextTheme.lightTextTheme;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: isDarkTheme
              ? const Color.fromARGB(255, 32, 32, 32)
              : SrkayColors.primaryBackground,
          child: Container(
            //  decoration: BoxDecoration(color: isDarkTheme ? Color.fromARGB(255, 32, 32, 32) : SrkayColors.primaryBackground,),
            padding: const EdgeInsets.all(16.0),
            child: const SizedBox(
              width: 400, // Adjust width as needed
              height: 350, // Adjust height as needed
              child: SRKDateRangePicker(
                isChartDropDownVisible: false,
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
                  onTap: () => _selectChartAndCloseModal(
                      'Line Chart'), // Add when implemented
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
                  title: const Text('Donut Chart'),
                  onTap: () => _selectChartAndCloseModal('Donut Chart'),
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
    // ignore: avoid_print
    // print('${selectedChart} contextcontextcontext');
    Navigator.pop(context);
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final dynamic x; // Can be DateTime or String
  final int y;
}
