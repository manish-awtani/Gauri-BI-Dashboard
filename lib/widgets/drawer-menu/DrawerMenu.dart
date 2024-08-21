import 'package:flutter/material.dart';
import 'package:flutter_application_1/charts/InfiniteScrolling.dart';
import 'package:flutter_application_1/screens/DaypDashboardCount.dart';
import 'package:flutter_application_1/screens/DaypSummary.dart';
import 'package:flutter_application_1/screens/examples/exampleSfDataGrid.dart';
import 'package:flutter_application_1/utils/constants/colors.dart';
import 'package:flutter_application_1/utils/helper/helper_functions.dart';
import 'package:flutter_application_1/utils/theme/custom_themes/text_theme.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  final drawerItems = [
    // DrawerItem("Dayp Dashboard", Icons.dashboard),
    DrawerItem("Gauri Dashboard", Icons.dashboard),
    DrawerItem("Stock Search Analysis", Icons.dashboard),
    // DrawerItem("Grid Page", Icons.grid_3x3),
    // DrawerItem("Infinite Scrolling", Icons.area_chart_rounded),
    // DrawerItem("Create Survey", Icons.info),
    // DrawerItem("Survey List", Icons.info),
    // DrawerItem("Employee List", Icons.info),
    // DrawerItem("My Surveys", Icons.info)
  ];

  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return const DaypDashboardCount();
      case 1:
        return ExampleSfDataGrid();
      case 2:
        return const InfiniteScrolling();
      case 3:
        return const DaypSummary();

      default:
        return const Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = SrkayHelperFunctions.isDarkMode(context);
    // ignore: non_constant_identifier_names
    final SRKTextTheme = isDarkTheme
        ? SrkayTextTheme.darkTextTheme
        : SrkayTextTheme.lightTextTheme;
    var drawerOptions = <Widget>[];
    for (var i = 0; i < drawerItems.length; i++) {
      var d = drawerItems[i];
      drawerOptions.add(Container(
        decoration: BoxDecoration(
            color: (i == _selectedDrawerIndex)
                ? SrkayColors.primary
                : isDarkTheme
                    ?const Color.fromARGB(255, 12, 12, 12)
                    : Colors.white,
            border: Border(
                bottom: BorderSide(
                    color: isDarkTheme
                    ? const Color.fromARGB(255, 12, 12, 12)
                    : Colors.white,))),
        child: ListTile(
          leading: Icon(d.icon,
              color: isDarkTheme
                    ? Colors.white 
                    : const Color.fromARGB(255, 12, 12, 12),),
          title: Text(
            d.title,
            style: TextStyle(
                color: isDarkTheme
                    ? Colors.white 
                    : const Color.fromARGB(255, 12, 12, 12),
                fontWeight: (i == _selectedDrawerIndex)
                    ? FontWeight.bold
                    : FontWeight.normal),
          ),
          selected: (i == _selectedDrawerIndex),
          onTap: () => _onSelectItem(i),
        ),
      ));
    }

    return Scaffold(
      // appBar:  AppBar(
      //   title:  Text(drawerItems[_selectedDrawerIndex].title),
      // ),
      drawer: Drawer(
        backgroundColor: isDarkTheme ? const Color.fromARGB(255, 12, 12, 12) : SrkayColors.primaryBackground,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Material(
              color: isDarkTheme
                  ? const Color.fromARGB(255, 32, 32, 32)
                  : SrkayColors.dark,
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top, bottom: 24),
                child:  Column(
                  children: [
                    CircleAvatar(
                      radius: 52,
                      backgroundColor: isDarkTheme
                    ? const Color.fromARGB(255, 12, 12, 12)
                    : Colors.white,
                      // child: Icon(
                      //   Icons.person,
                      //   size: 80,
                      // ),
                      backgroundImage: const NetworkImage(
                          // 'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHNtaWx5JTIwZmFjZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60'
                          // 'https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg'
                          'https://vnkrypto.com/wp-content/uploads/2022/08/Bo-suu-tap-NFT-Cau-Lac-Bo-Du-Thuyen-Bored-Ape.png'
                          // 'https://i.seadn.io/gae/SuPXcvDKA_rp9mcYJzxtrT-Wy_6aGFrs8G0J3ZJXdZ6zmSkkKqjVIHWcm0s6ZzPOXu-i7CnuiN36ZP4_JEe1FLVw2aa_IwR2Gpop2w?auto=format&dpr=1&w=1000'
                          // 'https://static1.makeuseofimages.com/wordpress/wp-content/uploads/2022/03/bored-ape-nft.jpg'
                      )
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Manish Awtani',
                      style: SRKTextTheme.bodyMedium,
                      //     color: Color.fromARGB(255, 1, 53, 96)),
                    ),
                    const Text(
                      'SRK00930',
                      style: TextStyle(
                          fontSize: 14, color: Color.fromARGB(255, 144, 115, 223)),
                    ),
                  ],
                ),
              ),
            ),
            Column(children: drawerOptions)
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}
