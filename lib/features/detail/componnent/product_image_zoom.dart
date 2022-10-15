import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:toot_mart/core/constants/colors.dart';
import 'package:toot_mart/core/constants/constants.dart';
import 'package:toot_mart/core/router/router.dart';

class ProductImageZoom extends StatefulWidget {
  final String? src;
  final List? images;
  const ProductImageZoom({Key? key, this.src, this.images}) : super(key: key);

  @override
  State<ProductImageZoom> createState() => _ProductImageZoomState();
}

class _ProductImageZoomState extends State<ProductImageZoom>
    with SingleTickerProviderStateMixin {
  TransformationController? transformationController;

  AnimationController? animationController;
  TapDownDetails? tapDownDetails;
  Animation<Matrix4>? animation;
  @override
  void initState() {
    transformationController = TransformationController();
    animationController = AnimationController(
        vsync: this, duration: const Duration(microseconds: 200))
      ..addListener(() => transformationController!.value = animation!.value);
    super.initState();
  }

  @override
  void dispose() {
    transformationController!.dispose();
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return PreferredSize(
      preferredSize: Size(w, h),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () => MagicRouter.pop(),
            child: Icon(
              Icons.arrow_back_ios,
              color: kMainColor,
              size: w * 0.08,
            ),
          ),
        ),
        body: (widget.images!.isEmpty)
            ? GestureDetector(
                onDoubleTap: () {
                  final position = tapDownDetails!.localPosition;
                  const double scale = 3.0;
                  final x = -position.dx * (scale - 1);
                  final y = -position.dy * (scale - 1);
                  final zoomed = Matrix4.identity()
                    ..translate(x, y)
                    ..scale(scale);
                  final end = transformationController!.value.isIdentity()
                      ? zoomed
                      : Matrix4.identity();
                  animation = Matrix4Tween(
                    begin: transformationController!.value,
                    end: end,
                  ).animate(
                    CurveTween(curve: Curves.easeOut)
                        .animate(animationController!),
                  );
                  animationController!.forward(from: 0);
                },
                onDoubleTapDown: (details) => tapDownDetails = details,
                child: InteractiveViewer(
                  clipBehavior: Clip.none,
                  // maxScale: 4,
                  // minScale: 1,
                  panEnabled: false,
                  transformationController: transformationController,
                  child: Container(
                    width: w,
                    height: h,
                    color: Colors.white,
                    child: customCachedNetworkImage(
                        context: context,
                        url: widget.src!,
                        fit: BoxFit.contain),
                  ),
                ),
              )
            : GestureDetector(
                onDoubleTap: () {
                  final position = tapDownDetails!.localPosition;
                  const double scale = 3.0;
                  final x = -position.dx * (scale - 1);
                  final y = -position.dy * (scale - 1);
                  final zoomed = Matrix4.identity()
                    ..translate(x, y)
                    ..scale(scale);
                  final end = transformationController!.value.isIdentity()
                      ? zoomed
                      : Matrix4.identity();
                  animation = Matrix4Tween(
                    begin: transformationController!.value,
                    end: end,
                  ).animate(
                    CurveTween(curve: Curves.easeOut)
                        .animate(animationController!),
                  );
                  animationController!.forward(from: 0);
                },
                onDoubleTapDown: (details) => tapDownDetails = details,
                child: InteractiveViewer(
                  clipBehavior: Clip.none,
                  panEnabled: false,
                  transformationController: transformationController,
                  child: Swiper(
                    autoplayDelay: 5000,
                    pagination: SwiperPagination(
                        builder: DotSwiperPaginationBuilder(
                          color: kMainColor.withOpacity(0.3),
                          activeColor: kMainColor,
                        ),
                        alignment: Alignment.bottomCenter),
                    itemCount: widget.images!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: w,
                        height: h,
                        color: Colors.white,
                        child: customCachedNetworkImage(
                          context: context,
                          fit: BoxFit.contain,
                          url: widget.images![index],
                        ),
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }
}
