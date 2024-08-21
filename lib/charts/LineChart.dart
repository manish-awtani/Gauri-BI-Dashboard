import 'package:flutter/material.dart';
// import 'package:flutter_application_1/screens/DaypDashboard.dart';
import 'package:flutter_application_1/screens/DaypDashboardCount.dart';
import 'package:flutter_application_1/utils/helper/helper_functions.dart';
import 'package:flutter_application_1/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter_application_1/widgets/buttons/custom_button.dart';
import 'package:flutter_application_1/widgets/sliding-segmented-button/sliding_segmented_button.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SfLineChart extends StatefulWidget {
  final List<ChartData> chartData;
  final String xAxisType;
  final int? initialValue;
  final String chartTitle;
  final void Function(int) onDefinedDataFilterChanged;
  final bool isDateFilterVisible;
  final Widget? customPicker;

  SfLineChart({
    super.key,
    required this.chartData,
    required this.xAxisType,
    required this.chartTitle,
    required this.onDefinedDataFilterChanged,
    this.initialValue,
    required this.isDateFilterVisible,
    this.customPicker,
  });

  @override
  State<SfLineChart> createState() => _SfLineChartState();
}

class _SfLineChartState extends State<SfLineChart> {
  late SfCartesianChart chart;
  late TooltipBehavior _tooltipBehavior;
  late CrosshairBehavior _crosshairBehavior;
  late SelectionBehavior _selectionBehavior;
  late ZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    _selectionBehavior = SelectionBehavior(
      enable: true,
      toggleSelection: true,
      // selectedColor: Colors.red,
      // unselectedColor: Colors.grey,
    );
    _crosshairBehavior = CrosshairBehavior(
      // Enables the crosshair
      enable: true,
      activationMode: ActivationMode.singleTap,
    );
    _zoomPanBehavior = ZoomPanBehavior(
      enableDoubleTapZooming: true,
      enablePanning: true,
      enablePinching: true,
      enableSelectionZooming: true,
      // enablePanning: true,
      // enablePinching: true,
      // enableSelectionZooming: true,
      selectionRectBorderColor: Colors.red,
      selectionRectBorderWidth: 1,
      selectionRectColor: Colors.grey,
      enableMouseWheelZooming: true,
      maximumZoomLevel: 0.01,
    );
    super.initState();
  }

  _axisType(String xAxisType) {
    switch (xAxisType) {
      case 'datetime':
        return DateTimeAxis();

      case 'category':
        return CategoryAxis();

      case 'numerical':
        return NumericAxis();

      case 'datetime':
        return DateTimeAxis();

      default:
        return CategoryAxis();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = SrkayHelperFunctions.isDarkMode(context);
    final SRKTextTheme = isDarkTheme
        ? SrkayTextTheme.darkTextTheme
        : SrkayTextTheme.lightTextTheme;
    // final List<ChartData> chartData = [
    //     ChartData(2010, 35),
    //     ChartData(2011, 28),
    //     ChartData(2012, 34),
    //     ChartData(2013, 32),
    //     ChartData(2014, 40)
    // ];
    chart = SfCartesianChart(
      //       onCrosshairPositionChanging: (CrosshairRenderArgs args){
      //   args.text = 'crosshair';
      // },
      //       onActualRangeChanged: (ActualRangeChangedArgs args){
      //   if (args.axisName == 'primaryYAxis'){
      //     args.visibleMin = 10000;
      //   }
      // },
      onZoomReset: (ZoomPanArgs args) {
        print('${args.currentZoomFactor}  --------------onZoomReset1');
        print('${args.currentZoomPosition}  --------------onZoomReset2');
      },
      zoomPanBehavior: _zoomPanBehavior,
      // ZoomPanBehavior(

      // ),
      // legend: Legend(isVisible: true),
      primaryXAxis: CategoryAxis(),
      // _axisType(widget.xAxisType),
      tooltipBehavior: _tooltipBehavior,
      series: <CartesianSeries>[
        // Renders line chart
        LineSeries<ChartData, dynamic>(
            dataSource: widget.chartData,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y)
      ],

      crosshairBehavior: _crosshairBehavior,
    );
    return Scaffold(
        body: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            height: 35,
            child: Row(
              verticalDirection: VerticalDirection.down,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Row(
                //   verticalDirection: VerticalDirection.down,
                //   children: [
                // Container(
                //     decoration: BoxDecoration(
                //       shape: BoxShape.rectangle,
                //       border: Border(
                //         right: BorderSide(
                //           color: Colors.white,
                //           width: 0.7,
                //           style: BorderStyle.solid,
                //           strokeAlign: BorderSide.strokeAlignInside,
                //         ),
                //       ),
                //     ),
                //     // color: Colors.white24,
                //     child: CustomButton(
                //       text: "Transparent",
                //       onPressed: () {
                //         // Handle button press
                //       },
                //       icon: Icons.add,
                //       backgroundColor: Colors.blue,
                //       textColor: Colors.white,
                //     )),

                (widget.isDateFilterVisible)
                    ? Container(
                        // color: Colors.white24,
                        child: SlidingSegmentedButton(
                        initialValue: widget.initialValue ?? null,
                        onValueChanged: (v) {
                          widget.onDefinedDataFilterChanged(
                              v); // Invoke callback here
                        },
                        // (v) {
                        //   print(v);
                        // },
                        textList: const {
                          // 1: Text('15Y'),
                          // 2: Text('5Y'),
                          // 3: Text('1Y'),
                          // 4: Text('1M'),
                          // 1: Text('15Y'),
                          2: Text('5Y'),
                          3: Text('1Y'),
                          4: Text('1M'),
                          // 1: Text('F'),
                          // 2: Text('D'),
                          // 3: Text('Y'),
                          // 4: Text('M'),
                        },
                        isShowDivider: true,
                      ))
                    : Container(),
                // Container(
                //   // color: Colors.white24,
                //   child: TextButton(
                //     isSemanticButton: true,
                //     // <-- TextButton
                //     onPressed: () {},
                //     // icon: Icon(
                //     //   Icons.download,
                //     //   size: 24.0,
                //     // ),
                //     child: Text('5Y'),
                //   ),
                // ),
                //   ],
                // ),
                Row(
                  children: [
                
                    Container(
                      // color: Colors.white24,
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: selection,
                          // () {
                          //   setState(() {
                          //     // _crosshairBehavior = CrosshairBehavior(
                          //     //     activationMode: ActivationMode.doubleTap, enable: true);
                          //     // onZoomReset();
                          //     _zoomPanBehavior.reset;
                          //   });
                          // },
                          icon: const Icon(Icons.zoom_in_outlined)),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: zoom,
                        icon: const Icon(Icons.change_circle_outlined),
                      ),
                    ),
                    (widget.isDateFilterVisible && widget.customPicker != null)
                    ? widget.customPicker!
                    : Container(),
                  ],
                ),
              ],
            ),
          ),
        ),
        Center(child: chart),
        Text(
          widget.chartTitle,
          style: SRKTextTheme.titleLarge,
        ),
      ],
    ));
  }

  void zoom() {
    _zoomPanBehavior.reset();
  }

  void selection() {
    // _zoomPanBehavior = ZoomPanBehavior(
    //   enableDoubleTapZooming: true,
    //   enablePanning: true,
    //   enablePinching: true,
    //   // enableSelectionZooming: true,
    //   // enablePanning: true,
    //   // enablePinching: true,
    //   // enableSelectionZooming: true,
    //   selectionRectBorderColor: Colors.red,
    //   selectionRectBorderWidth: 1,
    //   selectionRectColor: Colors.grey,
    //   enableMouseWheelZooming: true,
    //   maximumZoomLevel: 0.01,
    // );
    _zoomPanBehavior.reset();
  }
}

    // class ChartData {
    //     ChartData(this.x, this.y);
    //     final dynamic x;
    //     final double y;
    // }
    
//     import 'package:flutter/material.dart';
// // import 'package:flutter_application_1/screens/DaypDashboard.dart';
// import 'package:flutter_application_1/screens/DaypDashboardCount.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class SfLineChart extends StatefulWidget {
//   final List<ChartData> chartData;
//   final String xAxisType;

//   const SfLineChart({
//     super.key,
//     required this.chartData,
//     required this.xAxisType,
//   });

//   @override
//   State<SfLineChart> createState() => _SfLineChartState();
// }

// class _SfLineChartState extends State<SfLineChart> {
//   late TooltipBehavior _tooltipBehavior;
//   late CrosshairBehavior _crosshairBehavior;
//   late SelectionBehavior _selectionBehavior;

//   @override
//   void initState() {
//     _tooltipBehavior = TooltipBehavior(enable: true);
//     _selectionBehavior = SelectionBehavior(
//       enable: true,
//       toggleSelection: true,
//       // selectedColor: Colors.red,
//       // unselectedColor: Colors.grey,
//     );
//     _crosshairBehavior = CrosshairBehavior(
//       // Enables the crosshair
//       enable: true,
//       activationMode: ActivationMode.singleTap,
//     );
//     super.initState();
//   }

//   _axisType(String xAxisType) {
//     switch (xAxisType) {
//       case 'datetime':
//         return DateTimeAxis();

//       case 'category':
//         return CategoryAxis();

//       case 'numerical':
//         return NumericAxis();

//       case 'datetime':
//         return DateTimeAxis();

//       default:
//         return CategoryAxis();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final List<ChartData> chartData = [
//     //     ChartData(2010, 35),
//     //     ChartData(2011, 28),
//     //     ChartData(2012, 34),
//     //     ChartData(2013, 32),
//     //     ChartData(2014, 40)
//     // ];

//     return Scaffold(
//         body: Center(
//             child: Container(
//                 child: SfCartesianChart(
//       loadMoreIndicatorBuilder:
//           (BuildContext context, ChartSwipeDirection direction) =>
//               getLoadMoreViewBuilder(context, direction),
//       series: <CartesianSeries<ChartData, dynamic>>[
//         LineSeries<ChartData, dynamic>(
//             dataSource: widget.chartData,
//             xValueMapper: (ChartData data, _) => data.x,
//             yValueMapper: (ChartData data, _) => data.y),
//       ],
//       zoomPanBehavior: ZoomPanBehavior(
//         enablePanning: true,
//         enablePinching: true,
//         enableSelectionZooming: true,
//         selectionRectBorderColor: Colors.red,
//         selectionRectBorderWidth: 1,
//         selectionRectColor: Colors.grey,
//         enableMouseWheelZooming: true,
//         maximumZoomLevel: 0.01,
//       ),
//       primaryXAxis: CategoryAxis(),
//       // _axisType(widget.xAxisType),
//       tooltipBehavior: _tooltipBehavior,
//       // series: <CartesianSeries>[
//       // Renders line chart
//       // LineSeries<ChartData, dynamic>(
//       //     dataSource: widget.chartData,
//       //     xValueMapper: (ChartData data, _) => data.x,
//       //     yValueMapper: (ChartData data, _) => data.y)
//       // ]
//     ))));
//   }

//   Widget getLoadMoreViewBuilder(
//       BuildContext context, ChartSwipeDirection direction) {
//     if (direction == ChartSwipeDirection.end) {
//       return FutureBuilder<String>(
//         future: _updateData(),

//         /// Adding data by updateDataSource method
//         builder: (BuildContext futureContext, AsyncSnapshot<String> snapShot) {
//           return snapShot.connectionState != ConnectionState.done
//               ? const CircularProgressIndicator()
//               : SizedBox.fromSize(size: Size.zero);
//         },
//       );
//     } else {
//       return SizedBox.fromSize(size: Size.zero);
//     }
//   }
// }

// _updateData() {
// }

//     // class ChartData {
//     //     ChartData(this.x, this.y);
//     //     final dynamic x;
//     //     final double y;
//     // }