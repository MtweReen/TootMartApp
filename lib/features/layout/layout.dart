import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../core/constants/colors.dart';
import '../../translations/locale_keys.g.dart';
import '../account/account.dart';
import '../cart/cart.dart';
import '../category/category.dart';
import '../favourite/favourite.dart';
import '../home/home.dart';

class LayoutScreen extends StatefulWidget {
  final int? index;
  const LayoutScreen({Key? key, this.index}) : super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int currentIndex = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const CategoryScreen(),
    const CartScreen(),
    const FavouriteScreen(),
    AccountScreen(),
  ];
  getIndex() {
    if (widget.index != null) {
      setState(() {
        currentIndex = widget.index!;
      });
    } else {
      currentIndex = 0;
    }
  }

  @override
  void initState() {
    getIndex();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appbarNoTitle(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: kMainColor.withOpacity(0.4),
        elevation: 10.0,
        iconSize: w * 0.08,
        selectedItemColor: kMainColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedLabelStyle: headingStyle.copyWith(
            color: kMainColor, fontWeight: FontWeight.w400, fontSize: w * 0.03),
        selectedLabelStyle: headingStyle.copyWith(
            color: kMainColor, fontWeight: FontWeight.w400, fontSize: w * 0.03),
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              label: LocaleKeys.home.tr()),
          BottomNavigationBarItem(
              icon: const Icon(Icons.receipt_long_outlined),
              label: translateString("Category", "الأقسام")),
          BottomNavigationBarItem(
              icon: const Icon(Icons.chat_outlined),
              label: translateString("cart", "عربة التسوق"),),
          
          BottomNavigationBarItem(
              icon: const Icon(Icons.notifications_none_outlined),
              label: translateString("favourite", "المفضلة"),),
          BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline),
              label: translateString("my account", "الحساب"),),
        ],
      ),
      body: Center(
        child:screens[currentIndex],
      ),
    );
  }
}
