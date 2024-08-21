import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/constants/colors.dart';
import 'package:flutter_application_1/utils/helper/helper_functions.dart';
import 'package:flutter_application_1/utils/theme/custom_themes/text_theme.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SRKDateRangePicker extends StatefulWidget {
  final void Function(DateTime? start, DateTime? end)? onDateRangeSelected;

  final void Function(bool? visible)? chartComparisonVisible;
  final bool isChartDropDownVisible;
  final String? initialChartType; 
  final String? selectedComparisonChart; 
  final DateTime? comparisonStartDate; 
  final DateTime? comparisonEndDate; 
  final void Function(String? type)? selectedChart;

  const SRKDateRangePicker({super.key, this.onDateRangeSelected, required this.isChartDropDownVisible, this.selectedChart, this.initialChartType, this.selectedComparisonChart, this.comparisonStartDate, this.comparisonEndDate, this.chartComparisonVisible});

  @override
  State<SRKDateRangePicker> createState() => _SRKDateRangePickerState();
}

class _SRKDateRangePickerState extends State<SRKDateRangePicker> {
  
  String selectedChartType = 'Line Chart';
  DateRangePickerController _dateRangePickerController = DateRangePickerController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();

  PickerDateRange? _selectedRange;
  
  @override
  void initState() {
    super.initState();
    selectedChartType = widget.selectedComparisonChart ?? widget.initialChartType ?? "Bar Chart";
    _dateRangePickerController.addPropertyChangedListener((String property) {
      if (property == 'selectedRange' && _dateRangePickerController.selectedRange != null) {
        _selectedRange = (widget.comparisonStartDate != null) ? PickerDateRange(
                          widget.comparisonStartDate,
                          widget.comparisonEndDate) : _dateRangePickerController.selectedRange;
                          print("${widget.selectedComparisonChart} widgetinitialChartTypewidgetinitialChartType! ${widget.initialChartType}");
        // _startDateController.text = _dateRangePickerController.selectedRange!.startDate!.toString().split(' ')[0];
        // _endDateController.text = _dateRangePickerController.selectedRange!.endDate!.toString().split(' ')[0];
        _startDateController.text = (widget.comparisonStartDate != null) ? widget.comparisonStartDate!.toString().split(' ')[0] : _dateRangePickerController.selectedRange!.startDate!.toString().split(' ')[0];
        _endDateController.text = (widget.comparisonEndDate != null) ? widget.comparisonEndDate!.toString().split(' ')[0] : _dateRangePickerController.selectedRange!.endDate!.toString().split(' ')[0];
      }

      //  if (widget.onDateRangeSelected != null) {
      //     widget.onDateRangeSelected!(
      //       _selectedRange!.startDate,
      //       _selectedRange!.endDate,
      //     );
      //   }
    });
  }
  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  // void _showEditDialog() {

  //   Navigator.of(context).pop();
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: const Text('Edit Date Range'),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             TextFormField(
  //               controller: _startDateController,
  //               decoration: const InputDecoration(labelText: 'Start Date'),
  //               keyboardType: TextInputType.datetime,
  //               onChanged: (value) {
  //                 setState(() {
  //                   _dateRangePickerController.selectedRange = PickerDateRange(
  //                     DateTime.parse(value),
  //                     _dateRangePickerController.selectedRange!.endDate,
  //                   );
  //                 });
  //               },
  //             ),
  //             TextFormField(
  //               controller: _endDateController,
  //               decoration: const InputDecoration(labelText: 'End Date'),
  //               keyboardType: TextInputType.datetime,
  //               onChanged: (value) {
  //                 setState(() {
  //                   _dateRangePickerController.selectedRange = PickerDateRange(
  //                     _dateRangePickerController.selectedRange!.startDate,
  //                     DateTime.parse(value),
  //                   );
  //                 });
  //               },
  //             ),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('Cancel'),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               setState(() {
  //                 _dateRangePickerController.selectedRange = PickerDateRange(
  //                   DateTime.parse(_startDateController.text),
  //                   DateTime.parse(_endDateController.text),
  //                 );
  //               Navigator.of(context).pop();
  //               });
  //             },
  //             child: const Text('OK'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
void _showEditDialog() {

    // Navigator.of(context).pop();
  TextEditingController startDateController = TextEditingController(text: _startDateController.text);
  TextEditingController endDateController = TextEditingController(text: _endDateController.text);

  showDialog(
    context: context,
    builder: (context) {
      final isDarkTheme = SrkayHelperFunctions.isDarkMode(context);
      final SRKTextTheme = isDarkTheme ? SrkayTextTheme.darkTextTheme : SrkayTextTheme.lightTextTheme;
      return AlertDialog(
        backgroundColor: isDarkTheme ? Color.fromARGB(255, 32, 32, 32) : SrkayColors.primaryBackground,
        title: const Text('Edit Date Range'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: startDateController,
              decoration: const InputDecoration(labelText: 'Start Date'),
              keyboardType: TextInputType.datetime,
              // onChanged: (value) {
              //   startDateController.text = value;
              // },
            ),
            TextFormField(
              controller: endDateController,
              decoration: const InputDecoration(labelText: 'End Date'),
              keyboardType: TextInputType.datetime,
              // onChanged: (value) {
              //   endDateController.text = value;
              // },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                // _selectedRange = PickerDateRange(
                //     DateTime.parse(startDateController.text),
                //     DateTime.parse(endDateController.text),
                // );
                // _dateRangePickerController.selectedRange = _selectedRange;
                _dateRangePickerController.selectedRange = PickerDateRange(
                    DateTime.parse(startDateController.text),
                    DateTime.parse(endDateController.text),
                );
              if (widget.onDateRangeSelected != null) {
                  widget.onDateRangeSelected!(
                    DateTime.parse(startDateController.text),
                    DateTime.parse(endDateController.text),
                  );
                }
              });
              if(widget.isChartDropDownVisible) {

              widget.selectedChart!(selectedChartType);
              }
              // (Object? val) {
              print('===============val ${selectedChartType}');
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              // Navigator.popUntil(context, ModalRoute.withName('/DaypScreen'));
                //  Navigator.of(context).popUntil(ModalRoute.withName('/DaypScreen'));
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}
  @override
  Widget build(BuildContext context) {
  print("${widget.comparisonStartDate} widgetinitialChartTypewidgetinitialChartType2222222 ${_selectedRange}");
        final isDarkTheme = SrkayHelperFunctions.isDarkMode(context);
    final SRKTextTheme = isDarkTheme ? SrkayTextTheme.darkTextTheme : SrkayTextTheme.lightTextTheme;
    
    return SafeArea(
      child: Scaffold(
        backgroundColor:  isDarkTheme ? Color.fromARGB(255, 32, 32, 32) : SrkayColors.primaryBackground,
        body: Column(
          children: [
            (widget.isChartDropDownVisible == true) ? Container(

              color: isDarkTheme ? Color.fromARGB(255, 32, 32, 32) : SrkayColors.primaryBackground,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Select Chart Type', textAlign: TextAlign.left,
                      style: SRKTextTheme.headlineSmall?.copyWith(
                          // color: SrkayColors.textWhite,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ),
                    // SizedBox(height: 5,),
                  DropdownButton<String>(
                    isExpanded: true,
                              value: selectedChartType,
                              onChanged: (newValue) {
                                 print(selectedChartType);
                                setState(() {
                                  selectedChartType = newValue!;
                                });
                                // widget.selectedChart!(selectedChartType);
                              },
                              items: const [
                                DropdownMenuItem(
                                  value: 'Line Chart',
                                  child: Row(
                                    children: [
                                      Icon(Icons.show_chart),
                                      SizedBox(width: 8),
                                      Text('Line Chart'),
                                    ],
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'Bar Chart',
                                  child: Row(
                                    children: [
                                      Icon(Icons.bar_chart),
                                      SizedBox(width: 8),
                                      Text('Bar Chart'),
                                    ],
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'Doughnut Chart',
                                  child: Row(
                                    children: [
                                      Icon(Icons.donut_large),
                                      SizedBox(width: 8),
                                      Text('Doughnut Chart'),
                                    ],
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'Pie Chart',
                                  child: Row(
                                    children: [
                                      Icon(Icons.pie_chart),
                                      SizedBox(width: 8),
                                      Text('Pie Chart'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
            const SizedBox(height: 5,),
                ],
              ),
            ) : Container(),
            Container(
              color: isDarkTheme ? Color.fromARGB(255, 32, 32, 32) : SrkayColors.primaryBackground,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Select Date Range',
                    style: SRKTextTheme.headlineSmall?.copyWith(
                        // color: SrkayColors.textWhite,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    
                      //  decoration: BoxDecoration(
                      //   color: isDarkTheme ? Color.fromARGB(255, 32, 32, 32) : SrkayColors.primaryBackground,
                      //  ),
                      child: IconButton(
                        icon: const Icon(Icons.edit),
                        color: isDarkTheme ? Colors.grey[200] : Color.fromARGB(255, 32, 32, 32),
                        onPressed: _showEditDialog,
                      ),
                  
                  ),
                ],
              ),
            ),
            Expanded(
              child: SfDateRangePicker(
                backgroundColor: isDarkTheme ? Color.fromARGB(255, 32, 32, 32) : SrkayColors.primaryBackground,
                showNavigationArrow: true,
                view: DateRangePickerView.month,
                // onViewChanged: (DateRangePickerViewChangedArgs args) {
                //   var visibleDates = args.visibleDateRange;
                // },
                onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                  if (args.value is PickerDateRange) {
                    final DateTime rangeStartDate = args.value.startDate;
                    final DateTime rangeEndDate = args.value.endDate;
                  } else if (args.value is DateTime) {
                    final DateTime selectedDate = args.value;
                  } else if (args.value is List<DateTime>) {
                    final List<DateTime> selectedDates = args.value;
                  } else {
                    final List<PickerDateRange> selectedRanges = args.value;
                  }
                },
                monthViewSettings: DateRangePickerMonthViewSettings(firstDayOfWeek: 7),
                selectionMode: DateRangePickerSelectionMode.extendableRange,
                initialSelectedRange: (widget.comparisonStartDate != null) ? PickerDateRange(
                          widget.comparisonStartDate,
                          widget.comparisonEndDate) : PickerDateRange(
                          DateTime.now().subtract(const Duration(days: 4)),
                          DateTime.now().add(const Duration(days: 3))),
                // initialSelectedRange: _selectedRange ?? PickerDateRange(
                //           DateTime.now().subtract(const Duration(days: 4)),
                //           DateTime.now().add(const Duration(days: 3))),
                
                // onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                //   if (args.value is PickerDateRange) {
                //     final DateTime rangeStartDate = args.value.startDate;
                //     final DateTime rangeEndDate = args.value.endDate;
                //   } else if (args.value is DateTime) {
                //     final DateTime selectedDate = args.value;
                //   } else if (args.value is List<DateTime>) {
                //     final List<DateTime> selectedDates = args.value;
                //   } else {
                //     final List<PickerDateRange> selectedRanges = args.value;
                //   }
                // },
                showActionButtons: true,
                controller: _dateRangePickerController,
                onSubmit: (Object? val) {
                  if (widget.onDateRangeSelected != null) {
                  widget.onDateRangeSelected!(
                    _dateRangePickerController.selectedRange!.startDate,
                    _dateRangePickerController.selectedRange!.endDate,
                  );
                }
                widget.selectedChart!(selectedChartType);
                  print('===============val123 $val \n ===${_dateRangePickerController.selectedRange!.startDate}');
                  Navigator.of(context).pop();
                  
                },
                onCancel: () {
                  _dateRangePickerController.selectedRanges = null;
              
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
