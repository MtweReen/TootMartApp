import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toot_mart/business_logic/app_cubit/app_cubit.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/utiles/size_config.dart';
import 'package:toot_mart/core/widgets/custom_buttons_widget.dart';
import 'package:toot_mart/features/layout/layout.dart';
import '../../core/constants/constants.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentPage = 0;
  PageController? pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double h = MediaQuery.of(context).size.height;
    SizeConfig().init(context);
    return BlocConsumer<AppCubit, AppState>(
      listener: (c, s) {},
      builder: (c, s) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: ConditionalBuilder(
            condition: s is! IntroLoadingState ||
                AppCubit.get(context).introModel != null,
            builder: (c) => SizedBox(
              width: double.infinity,
              height: h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //  SizedBox(height: h * 0.2),
                  Expanded(
                    // flex: 7,
                    child: PageView.builder(
                      controller: pageController,
                      physics: const BouncingScrollPhysics(),
                      onPageChanged: (value) {
                        setState(() {
                          currentPage = value;
                        });
                      },
                      itemCount: AppCubit.get(context)
                          .introModel!
                          .body!
                          .intros!
                          .length,
                      itemBuilder: (context, index) => SplashContent(
                        image: AppCubit.get(context)
                            .introModel!
                            .body!
                            .intros![index]
                            .image!,
                        title: AppCubit.get(context)
                            .introModel!
                            .body!
                            .intros![index]
                            .title!,
                        text: parseHtmlString(AppCubit.get(context)
                            .introModel!
                            .body!
                            .intros![index]
                            .description!),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.035),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      AppCubit.get(context).introModel!.body!.intros!.length,
                      (index) => buildOnBoardingDot(
                          index: index,
                          currentPage: currentPage,
                          context: context),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.05,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: CustomGeneralButton(
                      textColor: Colors.white,
                      color: kMainColor,
                      onTap: () async {
                        if (currentPage !=
                            AppCubit.get(context)
                                    .introModel!
                                    .body!
                                    .intros!
                                    .length -
                                1) {
                          setState(() {
                            currentPage = currentPage;
                          });
                          pageController!.animateToPage(currentPage + 1,
                              duration: const Duration(milliseconds: 1000),
                              curve: Curves.fastLinearToSlowEaseIn);
                        } else {
                          prefs.setBool('is_onboearding', true);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LayoutScreen()));
                        }
                      },
                      text: translateString("Next", "التالي"),
                    ),
                  ),

                  SizedBox(
                    height: h * 0.02,
                  ),

                  CustomTextButton(
                    text: translateString("Skip", "تخطي"),
                    onPressed: () {
                      prefs.setBool('is_onboearding', true);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LayoutScreen()));
                    },
                  ),
                  SizedBox(height: h * 0.02),
                ],
              ),
            ),
            fallback: (c) => Center(
              child: CircularProgressIndicator(
                color: kMainColor,
              ),
            ),
          ),
        );
      },
    );
  }
}

class SplashContent extends StatelessWidget {
  final String text, image, title;

  const SplashContent(
      {Key? key, required this.text, required this.image, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(16),
            height: h * 0.3,
            width: w * 1,
            child: customCachedNetworkImage(
                url: image, context: context, fit: BoxFit.contain)),
        SizedBox(
          height: h * 0.02,
        ),
        SizedBox(
          width: w * 0.85,
          child: Text(
            title,
            maxLines: 3,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: w * 0.05,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
        ),
        SizedBox(
          height: h * 0.02,
        ),
        SizedBox(
          width: w * 0.85,
          child: Text(
            text,
            maxLines: 3,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: w * 0.035,
                fontWeight: FontWeight.w400,
                color: colorGrey),
          ),
        ),
      ],
    );
  }
}

AnimatedContainer buildOnBoardingDot(
    {required int index, required int currentPage, required context}) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 250),
    margin: const EdgeInsets.all(5),
    height: 10,
    width: currentPage == index ? 10 : 10,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: currentPage == index ? kMainColor : Colors.white,
      border: Border.all(color: kMainColor),
    ),
  );
}
