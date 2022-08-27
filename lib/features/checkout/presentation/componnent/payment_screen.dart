// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:toot_mart/features/layout/layout.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/utiles/size_config.dart';

class PaymentScreen extends StatefulWidget {
  final String url;

  const PaymentScreen({Key? key, required this.url}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final flutterWebviewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      print('/////////////////////////////////////$url');
     
    });
  }

  @override
  void dispose() {
    super.dispose();
    flutterWebviewPlugin.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: WebviewScaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'CheckOut',
            style: TextStyle(
                fontSize: SizeConfig.defaultSize! * 1,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          leading: BackButton(
            color: kMainColor,
            onPressed: () {
              flutterWebviewPlugin.close();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LayoutScreen()),
              );
            },
          ),
          centerTitle: true,
          elevation: 0,
        ),
        url: widget.url,
        withJavascript: true,
        mediaPlaybackRequiresUserGesture: true,
        debuggingEnabled: false,
        resizeToAvoidBottomInset: true,
      ),
    );
  }
}
