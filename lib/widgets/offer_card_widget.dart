import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/widgets/Skeleton.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readmore/readmore.dart';

class OfferCardWidget extends StatefulWidget {
  String text;
  String image;
  Color color;

  OfferCardWidget({this.text, this.image, this.color});

  @override
  _OfferCardWidgetState createState() => _OfferCardWidgetState();
}

class _OfferCardWidgetState extends State<OfferCardWidget> with SingleTickerProviderStateMixin{
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height * 1.5,
        color: Colors.white,
        child: Stack(
          fit: StackFit.loose,
          children: [
            GestureDetector(
              onDoubleTap: () {
                print('double tapped');
                cardKey.currentState.toggleCard();
              },
              child: Container(
                height: 550.0,
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

                      Container(
                        margin: EdgeInsets.only(top: 25.0, bottom: 100.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Center(
                              child: Text(
                                widget.text,
                                style: AppStyles.poppinsTextStyle(fontSize: 35.0, weight: FontWeight.w500),
                              ),
                            ),

                            Image.asset(
                              AppImages.STARBUCKS_OFFER,
//                    width: 450.0,
//                    height: 450.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  back: Stack(
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

                      Container(
                        margin: EdgeInsets.only(top: 25.0, bottom: 100.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Center(
                              child: Text(
                                widget.text + "Back",
                                style: AppStyles.poppinsTextStyle(fontSize: 35.0, weight: FontWeight.w500),
                              ),
                            ),

                            Image.asset(
                              AppImages.STARBUCKS_OFFER,
//                    width: 450.0,
//                    height: 450.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Positioned(
              top: 470.0,
              left: 0.0,
              right: 0.0,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            circularAvatar(
                                60.0,
                                60.0,
                                "https://i1.wp.com/www.logoworks.com/blog/wp-content/uploads/2017/06/Untitled-2.png?fit=1280%2C800&ssl=1",
                                28.0
                            ),

                            SizedBox(width: 10.0,),

                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Starbucks Triple Mocha",
                                          style: AppStyles.poppinsTextStyle(fontSize: 18.0, weight: FontWeight.w500).copyWith(color: Colors.black),
                                        ),

                                        SizedBox(height: 5.0,),

                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                "Triple Mocha Frappuccino",
                                                style: AppStyles.poppinsTextStyle(fontSize: 15.0, weight: FontWeight.w300).copyWith(color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: 8.0,),

                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.0),
                                            border: Border.all(color: AppColors.GREY_COLOR, width: 1.0)
                                          ),
                                          padding: EdgeInsets.symmetric(vertical: 3.0, horizontal: 6.0),
                                          child: Text(
                                            "4.5 Km",
                                            style: AppStyles.poppinsTextStyle(fontSize: 13.0, weight: FontWeight.w400).copyWith(color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 15.0,),

                        Divider(color: Colors.grey[400], height: 1.0, thickness: 0.5,),

                        SizedBox(height: 15.0,),

                        Row(
                          children: [
                            SizedBox(width: 2.0,),

                            Icon(
                              Icons.phone,
                              color: AppColors.GREEN_COLOR,
                              size: 20.0,
                            ),

                            SizedBox(width: 15.0,),

                            Text(
                              "+1 1234567825",
                              style: AppStyles.poppinsTextStyle(fontSize: 13.0, weight: FontWeight.w400).copyWith(color: AppColors.GREEN_COLOR),
                            )
                          ],
                        ),

                        SizedBox(height: 6.0,),

                        Row(
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              color: AppColors.RED_COLOR,
                              size: 24.0,
                            ),

                            SizedBox(width: 12.0,),

                            Expanded(
                              child: Text(
                                "4058 Little York Rd, Houston, TX 77093, USA",
                                style: AppStyles.poppinsTextStyle(fontSize: 13.0, weight: FontWeight.w400).copyWith(color: AppColors.BLUE_COLOR_DARK),
                              ),
                            )
                          ],
                        ),

                        SizedBox(height: 6.0,),

                        Row(
                          children: [
                            SizedBox(width: 3.0,),

                            Icon(
                              FontAwesomeIcons.solidClock,
                              color: AppColors.DARK_GREY_COLOR2,
                              size: 17.0,
                            ),

                            SizedBox(width: 15.0,),

                            Expanded(
                              child: Text(
                                "Hours: Opens 11AM - Closed 11PM",
                                style: AppStyles.poppinsTextStyle(fontSize: 13.0, weight: FontWeight.w400).copyWith(color: AppColors.DARK_GREY_COLOR2),
                              ),
                            )
                          ],
                        ),

                        SizedBox(height: 10.0,),

                        Row(
                          children: [
                            SizedBox(width: 35.0,),

                            Text(
                              "5.0 (8.5K)",
                              style: AppStyles.poppinsTextStyle(fontSize: 14.0, weight: FontWeight.w400).copyWith(color: AppColors.GREEN_BRIGHT_COLOR),
                            ),

                            RatingBar(
                              onRatingUpdate: null,
                              ratingWidget: RatingWidget(
                                full: Icon(
                                  FontAwesomeIcons.solidStar,
                                  color: AppColors.GREEN_BRIGHT_COLOR,
                                ),
                                half: Icon(
                                  FontAwesomeIcons.starHalfAlt,
                                  color: AppColors.GREEN_BRIGHT_COLOR,
                                ),
                                empty: Icon(
                                  FontAwesomeIcons.star,
                                  color: AppColors.GREEN_BRIGHT_COLOR,
                                )
                              ),
                              itemSize: 13.0,
                              initialRating: 4.5,
                              allowHalfRating: true,
                              glow: false,
                              itemPadding: EdgeInsets.only(left: 5.0),
                            ),

//                    RatingBarIndicator(
//                      itemCount: 5,
//                      rating: 5.0,
//                      itemSize: 13.0,
//                      itemPadding: EdgeInsets.only(left: 5.0),
//                      unratedColor: Colors.white,
//                      itemBuilder: (context, index) {
//                        return Icon(
//                          FontAwesomeIcons.star,
//                          color: AppColors.GREEN_BRIGHT_COLOR,
//                        );
//                      },
//                    )
                          ],
                        )
                      ],
                    ),
                  ),

                  SizedBox(height: 15.0,),

                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      children: [
                        SizedBox(height: 20.0,),

                        Divider(color: Colors.grey[400], height: 1.0, thickness: 0.5,),

                        SizedBox(height: 20.0,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedTab = 0;
                                });
                              },
                              child: Text(
                                AppStrings.DESCRIPTION,
                                style: _selectedTab == 0? AppStyles.selectedTabTextStyle() : AppStyles.unselectedTabTextStyle(),
                              ),
                            ),

                            Container(width: 1.0, height: 25.0, color: Colors.grey[400],),

                            InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedTab = 1;
                                });
                              },
                              child: Text(
                                AppStrings.REVIEWS,
                                style: _selectedTab == 1? AppStyles.selectedTabTextStyle() : AppStyles.unselectedTabTextStyle(),
                              ),
                            )
                          ],
                        ),

                        SizedBox(height: 10.0,),

                        _selectedTab == 0? Container(
//                          height: 500.0,
                          child: Text(
                            "Starbucks' new Triple Mocha Frappuccino was released on May Day 2018, and it's basically and enhanced version of the original MochaCookies are important to the proper functioning of a site. To improve your experience, we use cookies to remember log-in details and provide secure log-in, collect statistics..",
                            style: AppStyles.poppinsTextStyle(fontSize: 14.0, weight: FontWeight.w400).copyWith(color: AppColors.GREY_COLOR, height: 1.5),
                          ),
                        ) : Container(),

                        _selectedTab == 1? Container(
//                          height: 500.0,
                          child: Text(
                            "Reviews",
                            style: AppStyles.poppinsTextStyle(fontSize: 14.0, weight: FontWeight.w400).copyWith(color: AppColors.GREY_COLOR, height: 1.5),
                          ),
                        ) : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
