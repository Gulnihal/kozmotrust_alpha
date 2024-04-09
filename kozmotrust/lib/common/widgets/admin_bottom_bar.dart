import 'package:kozmotrust/constants/global_variables.dart';
import 'package:kozmotrust/features/admin/screens/admin_add_screen.dart';
import 'package:kozmotrust/features/admin/screens/admin_edit_delete_screen.dart';
import 'package:kozmotrust/features/insights/screens/blogs_screen.dart';
import 'package:flutter/material.dart';

class AdminBottomBar extends StatefulWidget {
  static const String routeName = '/admin-home';
  const AdminBottomBar({super.key});

  @override
  State<AdminBottomBar> createState() => _AdminBottomBarState();
}

class _AdminBottomBarState extends State<AdminBottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const AdminAddScreen(),
    const AdminEditDeleteScreen(searchQuery: ''),
    const Blogs(url: ''),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.primaryColor,
        unselectedItemColor: GlobalVariables.primaryColor,
        backgroundColor: GlobalVariables.secondaryColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          // ADMIN PRODUCT ADD
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0
                        ? GlobalVariables.primaryColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.add_circle_outline,
              ),
            ),
            label: '',
          ),
          // ADMIN PRODUCT EDIT-DELETE
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1
                        ? GlobalVariables.primaryColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.edit_attributes_outlined,
              ),
            ),
            label: '',
          ),
          // ADMIN INSIGHTS
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 2
                        ? GlobalVariables.primaryColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(
                Icons.bookmark_added_outlined,
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
