import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/DaypDashboardCount.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class DataGridView extends StatefulWidget {
  final List<ChartData> chartData;
  final bool isCompareGridVisible;
  final String? mainDate;
  final String? compareDate;

  const DataGridView({super.key, required this.chartData, this.mainDate, this.compareDate, required this.isCompareGridVisible});

  @override
  State<DataGridView> createState() => _DataGridViewState();
}

class _DataGridViewState extends State<DataGridView> {
  List<ChartData> gridData = <ChartData>[];
  late EmployeeDataSource chartGridDataSource;

  @override
  void initState() {
    super.initState();
    // employees = getEmployeeData();
    chartGridDataSource = EmployeeDataSource(chartGridData: widget.chartData);
  }

  @override
  void didUpdateWidget(DataGridView oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Handle potential null chartData
    if (widget.chartData == null) return;

    final incomingData = widget.chartData!;
    if (incomingData.isNotEmpty) {
      chartGridDataSource = EmployeeDataSource(chartGridData: widget.chartData);
    }
  }

  final GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();

  @override
  Widget build(BuildContext context) {
    return
        // Column(
        //   children: <Widget>[
//         Container(
//           height: 50.0,
//           width: 150.0,
//           padding: const EdgeInsets.all(10.0),
//           child: MaterialButton(
//               color: Colors.blue,
//               child: const Center(
//                   child: Text(
//                 'Export to Excel',
//                 style: TextStyle(color: Colors.white),
//               )),
//               onPressed: () async {
//                 final Workbook workbook =
//                     key.currentState!.exportToExcelWorkbook();
//                 final List<int> bytes = workbook.saveAsStream();
// File('DataGrid.xlsx').writeAsBytes(bytes, flush: true);
//                 workbook.dispose();
//                 // await helper.saveAndLaunchFile(bytes, 'DataGrid.xlsx');
//               }),
//         );
        SfDataGrid(
            source: chartGridDataSource,
            allowSorting: true,
            // allowFiltering: true,
            showColumnHeaderIconOnHover: true,
            // allowMultiColumnSorting: true,
            // columnWidthMode: ColumnWidthMode.fill,

            columnWidthMode: ColumnWidthMode.fill,
            columnWidthCalculationRange: ColumnWidthCalculationRange.allRows,
            columns: <GridColumn>[
          GridColumn(
              columnName: 'index',
              // visible: false,
              width: 70.0,
              autoFitPadding: EdgeInsets.all(16.0),
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Sr. No.',
                    // softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'id',
              width: 70.0,
              autoFitPadding: EdgeInsets.all(16.0),
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'Shape Id',
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'name',
              autoFitPadding: EdgeInsets.all(16.0),
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'Name',
                    overflow: TextOverflow.ellipsis,
                  ))),
          GridColumn(
              columnName: 'count',
              columnWidthMode: ColumnWidthMode.lastColumnFill,
              autoFitPadding: EdgeInsets.all(16.0),
              label: Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.centerRight,
                  child: const Text(
                    'Total Count',
                    overflow: TextOverflow.ellipsis,
                  ))),
          // GridColumn(
          //     columnName: 'comparision_count',
          //     columnWidthMode: ColumnWidthMode.lastColumnFill,
          //     autoFitPadding: EdgeInsets.all(16.0),
          //     label: Container(
          //         padding: const EdgeInsets.all(8.0),
          //         alignment: Alignment.centerRight,
          //         child: const Text(
          //           'Total Count',
          //           overflow: TextOverflow.ellipsis,
          //         ))),
        ],
        
          //   stackedHeaderRows: widget.isCompareGridVisible ? <StackedHeaderRow>[
          // StackedHeaderRow(cells: [
          //   StackedHeaderCell(
          //       columnNames: ['count'],
          //       child: Container(
          //           color: const Color(0xFFF1F1F1),
          //           child: Center(child: Text(widget.mainDate!)))),
          //   StackedHeaderCell(
          //       columnNames: ['comparision_count'],
          //       child: Container(
          //           color: const Color(0xFFF1F1F1),
          //           child: Center(child: Text(widget.compareDate!))))
          // ])
        // ]
        // : const <StackedHeaderRow>[],
        );
    //   ],
    // );
  }
}

class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource({required List<ChartData> chartGridData}) {
    // chartGridData.sort((a, b) => a.z!.compareTo(b.z as num));
    print('---------2 ');
    print('---------DaypGridData ${chartGridData}');
    _chartGridData = chartGridData
        .asMap()
        .map<int, DataGridRow>((index, e) => MapEntry(
              index,
              DataGridRow(cells: [
                DataGridCell<int>(columnName: 'index', value: index + 1),
                DataGridCell<dynamic>(columnName: 'id', value: e.x),
                DataGridCell<dynamic>(columnName: 'name', value: e.y),
                DataGridCell<int>(columnName: 'count', value: e.z),
                // DataGridCell<int>(columnName: 'comparision_count', value: e.a),
              ]),
            ))
        .values
        .toList();
  }

  List<DataGridRow> _chartGridData = [];

  @override
  List<DataGridRow> get rows => _chartGridData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          e.value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      );
    }).toList());
  }

  @override
  bool shouldRecalculateColumnWidths() {
    return true;
  }
}
