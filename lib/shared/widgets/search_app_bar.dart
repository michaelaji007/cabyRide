import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String? imageSrc;
  final Widget? leadingIcon;
  final String? titleText;
  final Widget? trailing;
  final double? height;
  final List<Widget>? children;
  final double? elevation;
  const SearchAppBar(
      {Key? key, this.imageSrc,
      this.leadingIcon,
      this.titleText,
      this.trailing,
      this.height,
      this.children,
      this.elevation}) : super(key: key);
  @override
  Size get preferredSize => Size.fromHeight(height ?? 100);
  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  String? searchText;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0,
        automaticallyImplyLeading: false,
        elevation: widget.elevation ?? 0,
        shadowColor: Colors.grey,
        flexibleSpace: Container(
          width: MediaQuery.of(context).size.width,
          height: 194.h,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.only(top: 32.h),
            child: Column(
              children: [...widget.children!],
            ),
          ),
        ));
  }
}
