  import 'package:flutter/material.dart';

IconData getChartIcon(String chartType) {
    switch (chartType) {
      case 'Line Chart': // Add when implemented
        return Icons.stacked_line_chart_rounded;
      case 'Bar Chart':
        return Icons.bar_chart_rounded;
      case 'Pie Chart':
        return Icons.pie_chart_rounded;
      case 'Donut Chart':
        return Icons.donut_large_rounded;
      case 'Scatter Chart':
        return Icons.scatter_plot_outlined;
      case 'Charts':
        return Icons.add_chart_outlined;
      default:
        return Icons.pie_chart_rounded;
    }
  }

  int monthStringToInt(String month) {
    String monthLower = month.toLowerCase();
  switch (month.toLowerCase()) {
    case 'january' || 'January':
      return 1;
    case 'february' || 'February':
      return 2;
    case 'march' || 'March':
      return 3;
    case 'april'|| 'April':
      return 4;
    case 'may':
      return 5;
    case 'june':
      return 6;
    case 'july':
      return 7;
    case 'august':
      return 8;
    case 'september':
      return 9;
    case 'october':
      return 10;
    case 'november':
      return 11;
    case 'december':
      return 12;
    default:
      throw ArgumentError('Invalid month name: $month');
  }
}