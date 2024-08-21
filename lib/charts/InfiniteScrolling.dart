import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class InfiniteScrolling extends StatefulWidget {
  const InfiniteScrolling({Key? key}) : super(key: key);

  @override
  _InfiniteScrollingState createState() => _InfiniteScrollingState();
}

class _InfiniteScrollingState extends State<InfiniteScrolling> {
  ChartSeriesController? seriesController;
  late List<ChartSampleData> chartData;

  late bool isLoadMoreView, isNeedToUpdateView, isDataUpdated;

  num? oldAxisVisibleMin, oldAxisVisibleMax;

  late ZoomPanBehavior _zoomPanBehavior;

  late GlobalKey<State> globalKey;

  @override
  void initState() {
    _initializeVariables();
    super.initState();
  }

  void _initializeVariables() {
    chartData = <ChartSampleData>[
      ChartSampleData(xValue: 0, y: 326),
      ChartSampleData(xValue: 1, y: 416),
      ChartSampleData(xValue: 2, y: 290),
      ChartSampleData(xValue: 3, y: 70),
      ChartSampleData(xValue: 4, y: 500),
      ChartSampleData(xValue: 5, y: 416),
      ChartSampleData(xValue: 6, y: 290),
      ChartSampleData(xValue: 7, y: 120),
      ChartSampleData(xValue: 8, y: 500),
    ];
    isLoadMoreView = false;
    isNeedToUpdateView = false;
    isDataUpdated = true;
    globalKey = GlobalKey<State>();
    _zoomPanBehavior = ZoomPanBehavior(
      enablePanning: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Infinite Scrolling Chart'),
      ),
      body: _buildInfiniteScrollingChart(),
    );
  }

  SfCartesianChart _buildInfiniteScrollingChart() {
    return SfCartesianChart(
      key: GlobalKey<State>(),
      onActualRangeChanged: (ActualRangeChangedArgs args) {
        if (args.orientation == AxisOrientation.horizontal) {
          if (isLoadMoreView) {
            args.visibleMin = oldAxisVisibleMin;
            args.visibleMax = oldAxisVisibleMax;
          }
          oldAxisVisibleMin = args.visibleMin as num;
          oldAxisVisibleMax = args.visibleMax as num;

          isLoadMoreView = false;
        }
      },
      zoomPanBehavior: _zoomPanBehavior,
      plotAreaBorderWidth: 0,
      primaryXAxis: NumericAxis(
        name: 'XAxis',
        interval: 2,
        enableAutoIntervalOnZooming: false,
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        majorGridLines: const MajorGridLines(width: 0),
        axisLabelFormatter: (AxisLabelRenderDetails details) {
          return ChartAxisLabel(details.text.split('.')[0], null);
        },
      ),
      primaryYAxis: NumericAxis(
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(color: Colors.transparent),
        axisLabelFormatter: (AxisLabelRenderDetails details) {
          return ChartAxisLabel(details.text, null);
        },
      ),
      series: getSeries(),
      loadMoreIndicatorBuilder:
          (BuildContext context, ChartSwipeDirection direction) =>
              getloadMoreIndicatorBuilder(context, direction),
    );
  }

  List<CartesianSeries<ChartSampleData, num>> getSeries() {
    return <CartesianSeries<ChartSampleData, num>>[
      SplineAreaSeries<ChartSampleData, num>(
        dataSource: chartData,
        color: Colors.blue.withOpacity(0.6),
        borderColor: Colors.blue,
        xValueMapper: (ChartSampleData sales, _) => sales.xValue as num,
        yValueMapper: (ChartSampleData sales, _) => sales.y,
        onRendererCreated: (ChartSeriesController controller) {
          seriesController = controller;
        },
      ),
    ];
  }

  Widget getloadMoreIndicatorBuilder(
      BuildContext context, ChartSwipeDirection direction) {
    if (direction == ChartSwipeDirection.end) {
      isNeedToUpdateView = true;
      globalKey = GlobalKey<State>();
      return StatefulBuilder(
        key: globalKey,
        builder: (BuildContext context, StateSetter stateSetter) {
          Widget widget;
          if (isNeedToUpdateView) {
            widget = getProgressIndicator();
            _updateView();
            isDataUpdated = true;
          } else {
            widget = Container();
          }
          return widget;
        },
      );
    } else {
      return SizedBox.fromSize(size: Size.zero);
    }
  }

  Widget getProgressIndicator() {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(),
        child: Container(
          width: 50,
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDarkTheme
                  ? const <Color>[
                      Color.fromRGBO(33, 33, 33, 0.0),
                      Color.fromRGBO(33, 33, 33, 0.74)
                    ]
                  : <Color>[
                      Colors.white.withOpacity(0.0),
                      Colors.white.withOpacity(0.74)
                    ],
              stops: const <double>[0.0, 1],
            ),
          ),
          child: SizedBox(
            height: 35,
            width: 35,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              backgroundColor: Colors.transparent,
              strokeWidth: 3,
            ),
          ),
        ),
      ),
    );
  }

  void _updateData() {
    for (int i = 0; i < 4; i++) {
      chartData.add(ChartSampleData(
        xValue: chartData[chartData.length - 1].xValue + 1,
        y: getRandomInt(0, 600),
      ));
    }
    isLoadMoreView = true;
    seriesController?.updateDataSource(addedDataIndexes: getIndexes(4));
  }

  Future<void> _updateView() async {
    await Future<void>.delayed(const Duration(seconds: 1), () {
      isNeedToUpdateView = false;
      if (isDataUpdated) {
        _updateData();
        isDataUpdated = false;
      }
      if (globalKey.currentState != null) {
        (globalKey.currentState as dynamic).setState(() {});
      }
    });
  }

  List<int> getIndexes(int length) {
    final List<int> indexes = <int>[];
    for (int i = length - 1; i >= 0; i--) {
      indexes.add(chartData.length - 1 - i);
    }
    return indexes;
  }

  int getRandomInt(int min, int max) {
    final Random random = Random();
    final int result = min + random.nextInt(max - min);
    return result < 50 ? 95 : result;
  }

  @override
  void dispose() {
    seriesController = null;
    super.dispose();
  }
}

class ChartSampleData {
  ChartSampleData({
    this.x,
    this.y,
    this.xValue,
    this.yValue,
    this.secondSeriesYValue,
    this.thirdSeriesYValue,
    this.pointColor,
    this.size,
    this.text,
    this.open,
    this.close,
    this.low,
    this.high,
    this.volume,
  });

  final dynamic x;
  final num? y;
  final dynamic xValue;
  final num? yValue;
  final num? secondSeriesYValue;
  final num? thirdSeriesYValue;
  final Color? pointColor;
  final num? size;
  final String? text;
  final num? open;
  final num? close;
  final num? low;
  final num? high;
  final num? volume;
}
