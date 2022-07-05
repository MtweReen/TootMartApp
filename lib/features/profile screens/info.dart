import 'package:flutter/material.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/core/widgets/space_widget.dart';

import '../../core/utiles/size_config.dart';

class InformationScreen extends StatefulWidget {
  final String title;
  const InformationScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: customAppbar(
        title: widget.title,
        context: context,
        press: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth! * 0.03,
            vertical: SizeConfig.screenHeight! * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                kLogo,
                color: kMainColor,
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
            const VerticalSpace(value: 3),
            Text(
              "الملابس من أهم متطلبات البشر يرتدي معظم الناس نوعاً أو آخر من الثياب ومشتقاتها، إضافة إلى ملابس الزينة. فالناس في شتى أنحاء العالم يرتدون الكثير من أنواع الملابس. ويحدث هذا التنويع تبعا لاختلاف الغرض الذي يدعو الفرد لارتداء نوع ما من الملابس. ويستعمل الناس شتى المواد والأساليب في صنعها ويتبعون عادات مختلفة في أزيائهم. تشمل كل أنواع الثياب والزينة التي يرتديها الإنسان في كل أنحاء العالم. فعلى سبيل المثال، يرتدي الإسكيمو في المناطق الباردة الحذاء الطويل والسراويل والمعطف السميك، بينما يرتدي الرجل الإفريقي الذي يعيش في إحدى قرى القارة قطعة من الثياب يلفها حول وسطه. وترتدي الممرضة في المستشفى زيًا معينًا، وتضع على رأسها غطاءً معينًا. وكذلك يرتدي الصيرفي الذي يعمل بأحد المصارف بلندن زيًا كاملاً، يتكون من سروال وسترة وقبعة توضع على الرأس. يرتدي كل هؤلاء الأشخاص ملابس مختلفة. وبالرغم من اختلاف الثياب فهم جميعًا في حاجة إليها. وتعتبر الثياب إحدى ضروريات الحياة للإنسان كالطعام والمأوى. معينًا. وكذلك يرتدي الصيرفي الذي يعمل بأحد المصارف بلندن زيًا كاملاً، يتكون من سروال وسترة وقبعة توضع على الرأس. يرتدي كل هؤلاء الأشخاص ملابس مختلفة. وبالرغم من اختلاف الثياب فهم جميعًا في حاجة إليها. وتعتبر الثياب إحدى ضروريات الحياة للإنسان كالطعام والمأوى.",
              style: headingStyle.copyWith(
                  color: colorGrey,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  fontSize: SizeConfig.screenWidth! * 0.04),
            )
          ],
        ),
      ),
    );
  }
}
