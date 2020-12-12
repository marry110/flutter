import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './home_page.dart';
import './category_page.dart';
import './cart_page.dart';
import './member_page.dart';
import './info_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../provide/current_provide.dart';
import 'package:provide/provide.dart';

// ignore: must_be_immutable
class IndexPage extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(
        CupertinoIcons.home,
      ),
      // ignore: deprecated_member_use
      title: Text('首页'),
    ),
    BottomNavigationBarItem(
      icon: Icon(
        CupertinoIcons.home,
      ),
      // ignore: deprecated_member_use
      title: Text('分类'),
    ),
    BottomNavigationBarItem(
      icon: Icon(
        CupertinoIcons.search,
      ),
      // ignore: deprecated_member_use
      title: Text('购物车'),
    ),
    BottomNavigationBarItem(
      icon: Icon(
        CupertinoIcons.profile_circled,
      ),
      // ignore: deprecated_member_use
      title: Text('个人中心'),
    ),
    BottomNavigationBarItem(
      icon: Icon(
        CupertinoIcons.info,
      ),
      // ignore: deprecated_member_use
      title: Text('信息'),
    ),
  ];
  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage(),
    InfoPage(),
  ];
  int currentIndex = 0;
  var currentPage;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);
    return Provide<CurrentIndexProvide>(
      builder: (context, child, val) {
        int currentIndex =
            Provide.value<CurrentIndexProvide>(context).currentIndex;
        return Scaffold(
          backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
          bottomNavigationBar: BottomNavigationBar(
            items: bottomTabs,
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              Provide.value<CurrentIndexProvide>(context).changeIndex(index);
            },
          ),
          body: IndexedStack(
            index: currentIndex,
            children: tabBodies,
          ),
        );
      },
    );
  }
}

// class IndexPage extends StatefulWidget {
//   @override
//   _IndexPageState createState() => _IndexPageState();
// }

// class _IndexPageState extends State<IndexPage> {
//   final List<BottomNavigationBarItem> bottomTabs = [
//     BottomNavigationBarItem(
//       icon: Icon(
//         CupertinoIcons.home,
//       ),
//       // ignore: deprecated_member_use
//       title: Text('首页'),
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(
//         CupertinoIcons.home,
//       ),
//       // ignore: deprecated_member_use
//       title: Text('分类'),
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(
//         CupertinoIcons.search,
//       ),
//       // ignore: deprecated_member_use
//       title: Text('购物车'),
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(
//         CupertinoIcons.profile_circled,
//       ),
//       // ignore: deprecated_member_use
//       title: Text('个人中心'),
//     ),
//     BottomNavigationBarItem(
//       icon: Icon(
//         CupertinoIcons.info,
//       ),
//       // ignore: deprecated_member_use
//       title: Text('信息'),
//     ),
//   ];
//   final List<Widget> tabBodies = [
//     HomePage(),
//     CategoryPage(),
//     CartPage(),
//     MemberPage(),
//     InfoPage(),
//   ];
//   int currentIndex = 0;
//   var currentPage;
//   @override
//   void initState() {
//     currentPage = tabBodies[currentIndex];
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     ScreenUtil.init(context,
//         designSize: Size(750, 1334), allowFontScaling: true);
//     return Scaffold(
//       backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
//       bottomNavigationBar: BottomNavigationBar(
//         items: bottomTabs,
//         currentIndex: currentIndex,
//         type: BottomNavigationBarType.fixed,
//         onTap: (index) {
//           setState(() {
//             currentIndex = index;
//             currentPage = tabBodies[currentIndex];
//           });
//         },
//       ),
//       body: IndexedStack(
//         index: currentIndex,
//         children: tabBodies,
//       ),
//     );
//   }
// }
