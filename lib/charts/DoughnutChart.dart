import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/DaypDashboardCount.dart';
import 'package:flutter_application_1/utils/helper/helper_functions.dart';
import 'package:flutter_application_1/utils/theme/custom_themes/text_theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SRKSfDoughnutChart extends StatefulWidget {
  final List<ChartData> chartData;
  final String xAxisType;
  final String chartTitle;
  final bool isDateFilterVisible;

  const SRKSfDoughnutChart({
    super.key,
    required this.chartData,
    required this.xAxisType,
    required this.isDateFilterVisible,
    required this.chartTitle,
  });

  @override
  State<SRKSfDoughnutChart> createState() => _SRKSfDoughnutChartState();
}

class _SRKSfDoughnutChartState extends State<SRKSfDoughnutChart> {
  late TooltipBehavior _tooltipBehavior;
  late SelectionBehavior _selectionBehavior;
  double selectedPercentage = 100.0;
  int? lastSelectedIndex; // Track the last selected index

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
                // legendItemBuilder:
                //     (String name, dynamic series, dynamic point, int index) {
                //   // List<String> colorType = point.toString().split(RegExp(r'#|\('));
                //    Color? Function(ChartData, dynamic) pointColor;
                //    pointColor = (ChartData data, _) => data.color;
                //    iconType: LegendIconType.diamond;
                //         // String colorStr = colorType[1].trim();
                //         // color = Color(int.parse(colorStr.substring(1), radix: 16) + 0xFF000000);
                //         // if (colorType[1].length == 5) { colorType[1] = colorType[1].padRight(6, colorType[1][4]); }
                //   print('${series.color} ============point');
                //   return
                //   Container(

                //       height: 60,
                //       width: 90,
                //       decoration: BoxDecoration(
                //             shape: BoxShape.circle,
                //             // color: Color(int.parse('FF'+ colorType[1], radix: 16)),
                //           ),
                //       child: Container(
                //           child:
                //           Text('${point.x}: ${point.y.toString()}')
                //           )
                //           );
                // },
              ),
              onLegendItemRender: (LegendRenderArgs args) {
                // print('${args.color} -------args');
                args.text = args.text;
                args.legendIconType = LegendIconType.seriesType;
              },
              tooltipBehavior: _tooltipBehavior,
              annotations: <CircularChartAnnotation>[
                CircularChartAnnotation(
                  height: '80%',
                  width: '80%',
                  widget: Container(
                    child: PhysicalModel(
                        child: Container(),
                        shape: BoxShape.circle,
                        elevation: 10,
                        shadowColor:
                            isDarkTheme ? Colors.black : Colors.transparent,
                        color: Colors.transparent
                        // .fromRGBO(230, 230, 230, 1),
                        ),
                  ),
                ),
                CircularChartAnnotation(
                    widget: Container(
                        child: Text(
                  'Total Count: \n${selectedPercentage.toStringAsFixed(1)}%',
                  textAlign: TextAlign.center,
                  style: SRKTextTheme.bodyLarge,
                )))
              ],
              series: <CircularSeries>[
                // Renders doughnut chart
                DoughnutSeries<ChartData, String>(
                  onPointTap: _onPointTap,
                  dataSource: widget.chartData,
                  pointColorMapper: (ChartData data, _) => data.color,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  radius: '80%',
                  selectionBehavior: _selectionBehavior,
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    labelIntersectAction: LabelIntersectAction.shift,
                    labelPosition: ChartDataLabelPosition.outside,
                    connectorLineSettings: ConnectorLineSettings(
                        type: ConnectorType.curve, length: '20%'),
                  ),
                ),
              ],
            ),
          ),
          Text(
            widget.chartTitle,
            style: SRKTextTheme.titleLarge,
          ),
        ],
      ),
    );
  }

  void _onPointTap(ChartPointDetails pointInteractionDetails) {
    final selectedIndex = pointInteractionDetails.pointIndex;
    if (selectedIndex != null) {
      if (selectedIndex == lastSelectedIndex) {
        // Deselect if the same section is clicked again
        setState(() {
          selectedPercentage = 100.0;
          lastSelectedIndex = null;
        });
      } else {
        final selectedValue = widget.chartData[selectedIndex].y;
        final totalValue =
            widget.chartData.fold<double>(0, (sum, item) => sum + item.y);
        setState(() {
          selectedPercentage = (selectedValue / totalValue) * 100;
          lastSelectedIndex = selectedIndex; // Update the last selected index
        });
      }
    }
  }
}
