// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';

// class DateRangePicker extends StatefulWidget {
//   const DateRangePicker({super.key});

//   @override
//   State<DateRangePicker> createState() => _DateRangePickerState();
// }

// class _DateRangePickerState extends State<DateRangePicker> {

//   DateRangePickerController _datePickerController = DateRangePickerController();
//   @override
//   Widget build(BuildContext context) {
//      return MaterialApp(
//         home: Scaffold(
//             body: Container(
//                   child:  SfDateRangePicker(
//                   view: DateRangePickerView.month,
//                   monthViewSettings: DateRangePickerMonthViewSettings(firstDayOfWeek: 6),
//                   selectionMode: DateRangePickerSelectionMode.multiRange,
//                   //onSelectionChanged: _onSelectionChanged,
//                   showActionButtons: true,
//                   controller: _datePickerController,
//                   // onSubmit: (Object val) {
//                   // },
//                   onCancel: () {
//                     _datePickerController.selectedRanges = null;
//                   },
//               ),
//             ),
//         ),
//     );
//   }
// }


// void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
// // TODO: implement your code here
// }