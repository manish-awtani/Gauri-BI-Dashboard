import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/constants/colors.dart';
import 'package:flutter_application_1/utils/helper/helper_functions.dart';
import 'package:flutter_application_1/utils/theme/custom_themes/text_theme.dart';

class TickerTape extends StatefulWidget {
  final List<TickerData> tickerData;
  final Velocity velocity;

  TickerTape({
    required this.tickerData,
    this.velocity = const Velocity(pixelsPerSecond: Offset(50, 0)),
  });

  @override
  _TickerTapeState createState() => _TickerTapeState();
}

class _TickerTapeState extends State<TickerTape> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
  _animationController.repeat(); // Start animation immediately

  _animationController.addListener(()  {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(_scrollController.offset + widget.velocity.pixelsPerSecond.dx / 60);
          if (_scrollController.offset >= _scrollController.position.maxScrollExtent) {
            _scrollController.jumpTo(0);
          }
        }
      });

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _animationController.repeat();
    });
  }

  @override
  void didUpdateWidget(TickerTape oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.velocity != widget.velocity) {
      // Update the scroll speed based on the new velocity
      _animationController.duration = Duration(milliseconds: (1000 / widget.velocity.pixelsPerSecond.dx).round());
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = SrkayHelperFunctions.isDarkMode(context);
    final SRKTextTheme = isDarkTheme ? SrkayTextTheme.darkTextTheme : SrkayTextTheme.lightTextTheme;

    return Container(
      color: isDarkTheme ? Colors.grey[800] : SrkayColors.dark,
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 30,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.tickerData.length * 4,
        itemBuilder: (context, index) {
          final data = widget.tickerData[index % widget.tickerData.length];
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Text(
                  data.symbol,
                  style: TextStyle(color: isDarkTheme ? SrkayColors.textWhite : SrkayColors.textSecondary, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 4),
                Text(
                  '${data.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: data.change >= 0 ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class TickerData {
  final String symbol;
  final double price;
  final double change;

  TickerData({required this.symbol, required this.price, required this.change});
}
