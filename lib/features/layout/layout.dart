import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../core/constants/colors.dart';
import '../../translations/locale_keys.g.dart';
import '../account/account.dart';
import '../all_products/component/filter_row.dart';
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
    const AccountScreen(),
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
    return WillPopScope(

      onWillPop: () async => false,
      child: Scaffold(
        appBar: appbarNoTitle(),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.black,
          elevation: 10.0,
          iconSize: w * 0.08,
          selectedItemColor: kMainColor,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedLabelStyle: headingStyle.copyWith(
              color: Colors.black, fontWeight: FontWeight.w400, fontSize: w * 0.03),
          selectedLabelStyle: headingStyle.copyWith(
              color: kMainColor, fontWeight: FontWeight.w400, fontSize: w * 0.03),
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              filteringData = false;
            });
          },
          items: [
            BottomNavigationBarItem(
              activeIcon: Image.asset("asset/images/homecolor.png", width: 100, height: 30,),
                icon: Image.asset("asset/images/home.png", width: 100, height: 30,),
                label: LocaleKeys.home.tr()),
            BottomNavigationBarItem(
              activeIcon: Image.asset("asset/images/deps-1.png", width: 100, height: 30,),
                icon:  Image.asset("asset/images/deps.png",  width: 100, height: 30,),
                label: translateString("Category", "الأقسام")),
            BottomNavigationBarItem(
                activeIcon: Image.asset("asset/images/cartcolor.png", width: 100, height: 30,),
                icon:  Image.asset("asset/images/cart.png",  width: 100, height: 30,),

                label: translateString("cart", "عربة التسوق"),),

            BottomNavigationBarItem(
                activeIcon: Image.asset("asset/images/heartcolor.png", width: 100, height: 30,),
                icon:  Image.asset("asset/images/heart.png",  width: 100, height: 30,),
                label: translateString("favourite", "المفضلة"),),
            BottomNavigationBarItem(
               activeIcon: Image.asset("asset/images/profilecolor.png", width: 100, height: 30,),
                icon:  Image.asset("asset/images/profile.png",  width: 100, height: 30,),
                label: translateString("my account", "الحساب"),),
          ],
        ),
        body: Center(
          child:screens[currentIndex],
        ),
      ),
    );
  }
}
