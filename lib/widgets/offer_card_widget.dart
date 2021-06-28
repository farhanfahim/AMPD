import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/widgets/Skeleton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class OfferCardWidget extends StatefulWidget {
  String text;
  String image;
  Color color;

  OfferCardWidget({this.text, this.image, this.color});

  @override
  _OfferCardWidgetState createState() => _OfferCardWidgetState();
}

class _OfferCardWidgetState extends State<OfferCardWidget> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        print('double tapped');
        cardKey.currentState.toggleCard();
      },
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL, // default
        flipOnTouch: false,
        key: cardKey,
        front: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: widget.image,
              fit: BoxFit.cover,
              // fadeInCurve: Curves.easeIn,
              imageBuilder: (BuildContext context,
                  ImageProvider<dynamic> imageProvider) {
                return Image(
                  // width: constraints.maxWidth,
                  image: imageProvider,
                  color: Colors.black38,
                  colorBlendMode: BlendMode.srcATop,
                  fit: BoxFit.cover,
                );
              },
              placeholder: (context, url) => Skeleton(),
//              errorWidget: (context, url, error){
//                return Image.asset(AppImages.NO_IMAGE_PLACEHOLDER);
//              },
            ),

            Column(
              children: [
                SizedBox(height: 20.0,),

                Container(
                  child: Center(
                    child: Text(
                      widget.text,
                      style: AppStyles.inputTextStyleWithPoppinsMedim().copyWith(fontSize: 30.0),
                    ),
                  ),
                ),

                Spacer(),

                Image.asset(
                  'AppImages.STARBUCKS_OFFER',
                  width: 500.0,
                  height: 500.0,
                ),

                SizedBox(height: 20.0,),
              ],
            ),
          ],
        ),
        back: Container(
          alignment: Alignment.center,
          color: widget.color,
          child: Text(
            widget.text + "\nBack",
            style: TextStyle(fontSize: 100),
          ),
        ),
      ),
    );
  }
}
