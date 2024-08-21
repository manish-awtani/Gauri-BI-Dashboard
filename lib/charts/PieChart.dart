import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/DaypDashboardCount.dart';
import 'package:flutter_application_1/utils/helper/helper_functions.dart';
import 'package:flutter_application_1/utils/theme/custom_themes/text_theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SRKSfPieChart extends StatefulWidget {
  final List<ChartData> chartData;
  final String xAxisType;
  final String chartTitle;
  final bool isDateFilterVisible;

  const SRKSfPieChart({
    super.key,
    required this.chartData,
    required this.xAxisType,
    required this.isDateFilterVisible,
    required this.chartTitle,
  });

  @override
  State<SRKSfPieChart> createState() => _SRKSfPieChartState();
}

class _SRKSfPieChartState extends State<SRKSfPieChart> {
  late TooltipBehavior _tooltipBehavior;
  late SelectionBehavior _selectionBehavior;

  @override
  void initState() {
    _tooltipBehavior =
        TooltipBehavior(enable: true, activationMode: ActivationMode.longPress);
    _selectionBehavior = SelectionBehavior(
      enable: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = SrkayHelperFunctions.isDarkMode(context);
    final SRKTextTheme = isDarkTheme
        ? SrkayTextTheme.darkTextTheme
        : SrkayTextTheme.lightTextTheme;
    // final List<ChartData> chartData = [
    //     ChartData('David', 25),
    //     ChartData('Steve', 38),
    //     ChartData('Jack', 25),
    //     ChartData('Messi', 44),
    //     ChartData('Ronaldo', 32),
    //     ChartData('Modi', 55),
    //     ChartData('Rahul', 36),
    //     ChartData('Sonia', 27),
    //     ChartData('Others', 52)
    // ];
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
            child: SfCircularChart(
                legend: const Legend(
                  height: '40%',
                  width: '100%',
                  isVisible: true,
                  toggleSeriesVisibility: true,
                  position: LegendPosition.bottom,
                  overflowMode: LegendItemOverflowMode.scroll,
                  orientation: LegendItemOrientation.auto,
                  iconHeight: 14,
                ),
                tooltipBehavior: _tooltipBehavior,
                series: <CircularSeries>[
              // Render pie chart
              PieSeries<ChartData, String>(
                dataSource: widget.chartData,
                pointColorMapper: (ChartData data, _) => data.color,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
                selectionBehavior: _selectionBehavior,
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  // Positioning the data label
                  // labelPosition: ChartDataLabelPosition.outside,
                  labelIntersectAction: LabelIntersectAction.hide,
                  labelPosition: ChartDataLabelPosition.outside,
                  connectorLineSettings: ConnectorLineSettings(
                      type: ConnectorType.curve, length: '20%'),
                  // useSeriesColor: true
                ),
                // Segments will explode on tap
                // explode: true,
                // // First segment will be exploded on initial rendering
                // explodeIndex: 1,
                // groupMode: CircularChartGroupMode.point,
                // // As the grouping mode is point, 2 points will be grouped
                // groupTo: 2
              ),
            ])),
        Text(
          widget.chartTitle,
          style: SRKTextTheme.titleLarge,
        ),
      ],
    ));
  }
}
// class PieChartData {
//     PieChartData(this.x, this.y, [this.color]);
//     final String x;
//     final double y;
//     final Color? color;
// }
