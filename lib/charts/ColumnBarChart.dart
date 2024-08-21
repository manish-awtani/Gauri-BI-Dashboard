import 'package:flutter/material.dart';
// import 'package:flutter_application_1/screens/DaypDashboard.dart';
import 'package:flutter_application_1/screens/DaypDashboardCount.dart';
import 'package:flutter_application_1/utils/helper/helper_functions.dart';
import 'package:flutter_application_1/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter_application_1/widgets/sliding-segmented-button/sliding_segmented_button.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SRKColumnBarChart extends StatefulWidget {
  final List<ChartData> chartData;
  final String xAxisType;
  final int? initialValue;
  final String chartTitle;
  final SlidingSegmentedButton? slidingSegment;
  final bool isDateFilterVisible;
  final bool isFilterVisible;
  
  final onDefinedDataFilterChanged;
  
  const SRKColumnBarChart(
      {super.key, required this.chartData, required this.xAxisType, this.slidingSegment, required this.onDefinedDataFilterChanged, 
    this.initialValue, required this.isDateFilterVisible,required this.isFilterVisible, required this.chartTitle,});

  @override
  State<SRKColumnBarChart> createState() => _SRKColumnBarChartState();
}

class _SRKColumnBarChartState extends State<SRKColumnBarChart> {
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

  @override
  Widget build(BuildContext context) {
            final isDarkTheme = SrkayHelperFunctions.isDarkMode(context);
    final SRKTextTheme = isDarkTheme
        ? SrkayTextTheme.darkTextTheme
        : SrkayTextTheme.lightTextTheme;
    return
        // Scaffold(
        //     body: Center(
        //         child: Container(
        //                     width: double.infinity,
        //       height: double.infinity,
        //             child:
        Column(
          children: <Widget>[
                 widget.isFilterVisible ?   Padding(
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
                  ],
                ) ,
              ],
            ),
          ),
        ): Container(),
            Container(
              child: SfCartesianChart(
                    zoomPanBehavior: ZoomPanBehavior(
              enablePanning: true,
              enablePinching: true,
              enableSelectionZooming: true,
              selectionRectBorderColor: Colors.red,
              selectionRectBorderWidth: 1,
              selectionRectColor: Colors.grey,
              enableMouseWheelZooming: true,
              maximumZoomLevel: 0.01,
                    ),
                    primaryXAxis: CategoryAxis(),
                    series: <CartesianSeries>[
              // Renders column chart
              ColumnSeries<ChartData, dynamic>(
                  dataSource: widget.chartData,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y)
                    ],
                  ),
            ),
        Text(widget.chartTitle, style: SRKTextTheme.titleLarge,),
          ],
        );
    // )));
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
