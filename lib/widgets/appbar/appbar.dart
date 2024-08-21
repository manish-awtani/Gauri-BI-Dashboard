import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/constants/colors.dart';
import 'package:flutter_application_1/utils/constants/sizes.dart';

class SRKAppbar extends StatelessWidget implements PreferredSizeWidget {

const SRKAppbar({ Key? key, 
  this.title, 
  this.centerTitle, 
  this.actions, 
  this.leadingIcon,
  this.leadingOnPressed,
  this.showBackArrow = false,
  this.backgroundColor,
}) : super(key: key);

  final Widget? title;
  final bool? centerTitle;
  final List<Widget>? actions;
  final IconData? leadingIcon;
  final VoidCallback? leadingOnPressed;
  final bool showBackArrow;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context){

    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 0),
      child: AppBar(
        elevation: theme.appBarTheme.elevation,
        centerTitle: theme.appBarTheme.centerTitle,
        scrolledUnderElevation: theme.appBarTheme.scrolledUnderElevation,
        backgroundColor: backgroundColor != null ? backgroundColor : theme.appBarTheme.backgroundColor,
        surfaceTintColor: theme.appBarTheme.surfaceTintColor,
        iconTheme: theme.appBarTheme.iconTheme,
        actionsIconTheme: theme.appBarTheme.actionsIconTheme,
        titleTextStyle: theme.appBarTheme.titleTextStyle,
        // backgroundColor: backgroundColor,
        automaticallyImplyLeading: false,
        leading: showBackArrow 
          ? IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_rounded))
          : leadingIcon != null ? IconButton(onPressed: leadingOnPressed, icon: Icon(leadingIcon), color: SrkayColors.textWhite
          // theme.iconTheme.color,
          ) : null,
        title: title,
        actions: actions,
      )
    );
  }
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => (Size.fromHeight(44.0));
}