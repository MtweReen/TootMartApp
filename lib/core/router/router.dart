import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Route<dynamic>? onGenerateRoute(RouteSettings settings) => null;

class MagicRouter {
  static BuildContext currentContext = navigatorKey.currentContext!;

  static Future<dynamic> navigateTo(Widget page) =>
      navigatorKey.currentState!.push(materialPageRoute(page));

  static Future<dynamic> navigateAndPopAll(Widget? page) =>
      navigatorKey.currentState!.pushAndRemoveUntil(
        materialPageRoute(page!),
        (s) => false,
      );

  static Future<dynamic> navigateAndPopUntilFirstPage(Widget page) =>
      navigatorKey.currentState!.pushAndRemoveUntil(
          materialPageRoute(page), (route) => route.isFirst);

  static void pop() => navigatorKey.currentState!.pop();

  static Route<dynamic> materialPageRoute(Widget page) =>
      MaterialPageRoute(builder: (s) => page);
}
