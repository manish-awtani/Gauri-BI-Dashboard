import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SfBarChart extends StatefulWidget {
  final List<dynamic> chartData;

  const SfBarChart({required this.chartData});
    // 

  @override
  State<SfBarChart> createState() => _SfBarChartState();
}

class _SfBarChartState extends State<SfBarChart> {
  late TooltipBehavior _tooltipBehavior;
  late CrosshairBehavior _crosshairBehavior;
  late SelectionBehavior _selectionBehavior;

  // final List<ChartData> finalData = [];
  String xAxisTitle = 'Fetching Data...';

  // @override
  // void didUpdateWidget(SfBarChart oldWidget) {
  //   super.didUpdateWidget(oldWidget);

  //   // Handle potential null chartData
  //   if (widget.chartData == null) return;

  //   final incomingData = widget.chartData!;
  //   if (incomingData.isNotEmpty) {
  //     setState(() {
  //       finalData.clear();
  //       xAxisTitle =
  //           incomingData[0]?.keys?.first; // Get X-axis title from grouping key
  //     });

  //     incomingData.forEach((value) {
  //       final xValue = value[value.keys.first]!.toString();
  //       final double yValue = value['summed_event_packet_rate'] as double;
  //       finalData.add(ChartData(xValue, yValue));
  //     });
  //   }
  // }

  @override
    Widget build(BuildContext context) {
        final List<ChartData> chartData = [
            ChartData(1, 35),
            ChartData(2, 43),
            ChartData(3, 34),
            ChartData(4, 25),
            ChartData(5, 30),
            ChartData(6, 60),
            ChartData(7, 75),
            ChartData(8, 47),
            ChartData(9, 32),
            ChartData(10, 20),
        ];
        return Center(
                  child: Container(
                      child: SfCartesianChart(
                          series: <CartesianSeries>[
                              BarSeries<ChartData, double>(
                                color: Color.fromARGB(255, 70, 102, 206),
                                  dataSource: chartData,
                                  // Renders the track
                                  isTrackVisible: true,
                                  xValueMapper: (ChartData data, _) => data.x,
                                  yValueMapper: (ChartData data, _) => data.y
                              )
                          ]
                      )
                  )   
              );
    }

  // Widget build(BuildContext context) {
  //   // print('${xAxisTitle} xAxisTitle ${DateTimeIntervalType}');
  //   return SfCartesianChart(
  //     zoomPanBehavior: ZoomPanBehavior(
  //       enablePanning: true,
  //       enablePinching: true,
  //       enableSelectionZooming: true,
  //       selectionRectBorderColor: Colors.red,
  //       selectionRectBorderWidth: 1,
  //       selectionRectColor: Colors.grey,
  //       enableMouseWheelZooming: true,
  //       maximumZoomLevel: 0.01,
  //     ),
  //     primaryXAxis:
  //         // DateTimeAxis(intervalType: DateTimeIntervalType.hours),
  //         CategoryAxis(
  //       title: AxisTitle(text: xAxisTitle),
  //       autoScrollingMode: AutoScrollingMode.start,
  //     ),
  //     primaryYAxis: const NumericAxis(
  //       title: AxisTitle(text: 'Summed Event Packet Rate'),
  //       decimalPlaces: 2,
  //       rangePadding: ChartRangePadding.auto,
  //     ),
  //     series: <CartesianSeries>[
  //       // Renders bar chart
  //       ColumnSeries<ChartData, String>(
  //         dataSource: finalData,
  //         xValueMapper: (ChartData data, _) => data.x,
  //         yValueMapper: (ChartData data, _) => data.y,
  //         dataLabelSettings: const DataLabelSettings(
  //           isVisible: true,
  //           // textStyle: ,
  //         ),
  //       )
  //     ],
  //   );
  // }
}

class ChartData {
  ChartData(this.x, this.y);
  final double x;
  final double y;

  @override
  String toString() {
    return '($x, $y)'; // Customize the format as needed
  }
}
