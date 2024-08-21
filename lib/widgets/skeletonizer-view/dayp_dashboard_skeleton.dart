import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/charts/ColumnBarChart.dart';
import 'package:flutter_application_1/screens/DaypDashboardCount.dart';
import 'package:flutter_application_1/utils/constants/colors.dart';
import 'package:flutter_application_1/utils/helper/helper_functions.dart';
import 'package:flutter_application_1/utils/theme/custom_themes/text_theme.dart';
import 'package:flutter_application_1/widgets/sliding-segmented-button/sliding_segmented_button.dart';

class DaypDashboardSkeleton extends StatelessWidget {
  const DaypDashboardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = SrkayHelperFunctions.isDarkMode(context);
    // ignore: non_constant_identifier_names
    final SRKTextTheme = isDarkTheme
        ? SrkayTextTheme.darkTextTheme
        : SrkayTextTheme.lightTextTheme;

    return Column(
      children: [
        Container(
          height: 30,
          width: MediaQuery.of(context).size.width * 1,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  color: isDarkTheme ? Colors.grey[800] : SrkayColors.dark,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  height: 30,
                  child: const Center(
                    child:
                        Text('Selected: 1290129012', textAlign: TextAlign.center
                            // style:TextStyle()
                            ),
                  ),
                  // CircularProgressIndicator()
                );
              }),
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            height: 35,
            child: Row(
              verticalDirection: VerticalDirection.down,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: SlidingSegmentedButton(
                  initialValue: 3,
                  onValueChanged: (v) {
                    print(v);
                  },
                  textList: const {
                    1: Text('0Y'),
                    2: Text('0Y'),
                    3: Text('0Y'),
                    4: Text('0Y'),
                  },
                  isShowDivider: true,
                )),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.zoom_in_outlined)),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.change_circle_outlined),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.change_circle_outlined),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
            height: 400,
            // color: isDarkTheme ? Colors.grey[800] : SrkayColors.dark,
            child: SRKColumnBarChart(
                      isDateFilterVisible: false,
                      isFilterVisible: false,
              chartData: [
                ChartData(x: 1.00, y: 0.00),
                ChartData(x: 2.00, y: 0.00),
                ChartData(x: 3.00, y: 0.00),
                ChartData(x: 4.00, y: 0.00),
                ChartData(x: 5.00, y: 0.00),
                ChartData(x: 6.00, y: 0.00),
              ],
              xAxisType: 'timebased', chartTitle: 'XXxxXXxxXXxxXXxx XXxxxXXXXX xxxxXXXXXXXxxxx',
              onDefinedDataFilterChanged: () {},
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
              // scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Card(
                  color: isDarkTheme
                      ? Color.fromARGB(255, 12, 12, 12)
                      : SrkayColors.dark,
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text('Item number $index as title'),
                    subtitle: const Text('Subtitle here'),
                    trailing: const Icon(
                      Icons.ac_unit,
                      size: 32,
                    ),
                  ),
                );

                // Container(
                //   color: isDarkTheme ? Colors.grey[800] : SrkayColors.dark,
                //   padding: EdgeInsets.symmetric(horizontal: 8), margin: EdgeInsets.all(8),
                //   height: 55,
                //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
                //   child: Container(
                //     child:
                //         Text('Selected: 1290129012     0129012                     0129012                 ',
                //             // style:TextStyle()
                //             ),
                //   ),
                // CircularProgressIndicator()
                // );
              }),
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/utils/constants/colors.dart';
// import 'package:flutter_application_1/utils/helper/helper_functions.dart';
// import 'package:flutter_application_1/utils/theme/custom_themes/text_theme.dart';

// class DaypDashboardSkeleton extends StatefulWidget {
//   const DaypDashboardSkeleton({super.key});
// final Velocity velocity = const Velocity(pixelsPerSecond: Offset(50, 0));

//   @override
//   State<DaypDashboardSkeleton> createState() => _DaypDashboardSkeletonState();
// }

// class _DaypDashboardSkeletonState extends State<DaypDashboardSkeleton> with SingleTickerProviderStateMixin {
//   late ScrollController _scrollController;
//   late AnimationController _animationController;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 1),
//     );
//   _animationController.repeat(); // Start animation immediately

//   _animationController.addListener(()  {
//         if (_scrollController.hasClients) {
//           _scrollController.jumpTo(_scrollController.offset + widget.velocity.pixelsPerSecond.dx / 60);
//           if (_scrollController.offset >= _scrollController.position.maxScrollExtent) {
//             _scrollController.jumpTo(0);
//           }
//         }
//       });

//     WidgetsBinding.instance?.addPostFrameCallback((_) {
//       _animationController.repeat();
//     });
//   }

//   @override
//   void didUpdateWidget(oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.velocity != widget.velocity) {
//       // Update the scroll speed based on the new velocity
//       _animationController.duration = Duration(milliseconds: (1000 / widget.velocity.pixelsPerSecond.dx).round());
//     }
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isDarkTheme = SrkayHelperFunctions.isDarkMode(context);
//     // ignore: non_constant_identifier_names
//     final SRKTextTheme = isDarkTheme
//         ? SrkayTextTheme.darkTextTheme
//         : SrkayTextTheme.lightTextTheme;

//     return Column(
//       children: [

//         ListView.builder(
//         controller: _scrollController,
//         scrollDirection: Axis.horizontal,
//         itemCount: 30,
//         itemBuilder: (context, index) {
//           return Container(
//           color: isDarkTheme ? Colors.grey[800] : SrkayColors.dark,
//           padding: EdgeInsets.symmetric(horizontal: 8),
//           height: 30,
//           width: 1000,
//           child: const Text('Selected: 129012901290'),
//           // CircularProgressIndicator()
//         );
//         }
//         )
//       ],
//     );
//   }
// }
