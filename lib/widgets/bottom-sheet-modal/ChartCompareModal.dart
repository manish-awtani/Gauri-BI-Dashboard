import 'package:flutter/material.dart';

class ChartCompareModal extends StatefulWidget {
  @override
  _ChartCompareModalState createState() => _ChartCompareModalState();
}

class _ChartCompareModalState extends State<ChartCompareModal> {
  DateTime? fromDate;
  DateTime? toDate;
  String selectedChartType = 'Bar Chart';

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
print('${fromDate} frroommmmmm');
    if (picked != null) {
      setState(() {
        if (isFromDate) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => _selectDate(context, true),
                child: Text(
                  fromDate == null
                      ? 'Select From Date'
                      : 'From: ${fromDate!.toLocal()}'.split(' ')[0],
                ),
              ),
              TextButton(
                onPressed: () => _selectDate(context, false),
                child: Text(
                  toDate == null
                      ? 'Select To Date'
                      : 'To: ${toDate!.toLocal()}'.split(' ')[0],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          DropdownButton<String>(
            value: selectedChartType,
            onChanged: (newValue) {
              setState(() {
                selectedChartType = newValue!;
              });
            },
            items: const [
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
        ],
      ),
    );
  }
}
