// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/core/router/router.dart';
import '../../core/utiles/size_config.dart';

class InformationScreen extends StatefulWidget {
  final String title;
  final String link;
  const InformationScreen({Key? key, required this.title, required this.link})
      : super(key: key);

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  final flutterWebviewPlugin = FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    flutterWebviewPlugin.onUrlChanged.listen((String url) {});
  }

  @override
  void dispose() {
    super.dispose();
    flutterWebviewPlugin.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: WebviewScaffold(
        appBar: customAppbar(
          title: widget.title,
          context: context,
          press: () {
            flutterWebviewPlugin.close();
            MagicRouter.pop();
          },
        ),
        url: widget.link,
        withJavascript: true,
        mediaPlaybackRequiresUserGesture: true,
        debuggingEnabled: false,
        resizeToAvoidBottomInset: true,
      ),
    );
    // Scaffold(
    //   appBar: customAppbar(
    //     title: widget.title,
    //     context: context,
    //     press: () => Navigator.pop(context),
    //   ),
    //   body:
    //  SingleChildScrollView(
    //   padding: EdgeInsets.symmetric(
    //       horizontal: SizeConfig.screenWidth! * 0.03,
    //       vertical: SizeConfig.screenHeight! * 0.03),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Center(
    //         child: Image.asset(
    //           kLogo,
    //           color: kMainColor,
    //           width: 150,
    //           height: 150,
    //           fit: BoxFit.contain,
    //         ),
    //       ),
    //       const VerticalSpace(value: 3),
    //       HtmlWidget(widget.body),

    //     ],
    //   ),
    // ),
    // );
  }
}
