import 'dart:async';
import 'dart:io';

import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/data/model/ReviewModel.dart';
import 'package:ampd/utils/timer_utils.dart';
import 'package:ampd/widgets/Skeleton.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class OfferCardWidget extends StatefulWidget {
  String text;
  String image;
  String offer;
  String offerName;
  String time;
  String locationTitle;
  Coords coord;
  ValueChanged<bool> changeDetailTitle;

  OfferCardWidget({this.text, this.image, this.offer, this.offerName, this.time, this.coord, this.locationTitle, this.changeDetailTitle});

  @override
  _OfferCardWidgetState createState() => _OfferCardWidgetState();
}

class _OfferCardWidgetState extends State<OfferCardWidget> with SingleTickerProviderStateMixin{
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  int _selectedTab = 0;
  bool _isDetail = false;
  String _time = "2021-06-30 09:00:00";
  String _days = "00";
  String _hours = "00";
  String _min = "00";
  String _sec = "00";
  Timer _timer;
  List<Reviews> _listOfReviews = [];

  @override
  void initState() {
    _listOfReviews.add(Reviews(name:"Mark Smith",rating:4.8,description:AppStrings.REDEEM_MESSAGE_TEXT,image:"https://iconape.com/wp-content/png_logo_vector/avatar-4.png"));
    _listOfReviews.add(Reviews(name:"John Doe",rating:4.8,description:AppStrings.REDEEM_MESSAGE_TEXT,image:"https://iconape.com/wp-content/png_logo_vector/avatar-4.png"));
    _listOfReviews.add(Reviews(name:"John Doe",rating:4.8,description:AppStrings.REDEEM_MESSAGE_TEXT,image:"https://iconape.com/wp-content/png_logo_vector/avatar-4.png"));
    _listOfReviews.add(Reviews(name:"John Doe",rating:4.8,description:AppStrings.REDEEM_MESSAGE_TEXT,image:"https://iconape.com/wp-content/png_logo_vector/avatar-4.png"));
    _listOfReviews.add(Reviews(name:"John Doe",rating:4.8,description:AppStrings.REDEEM_MESSAGE_TEXT,image:"https://iconape.com/wp-content/png_logo_vector/avatar-4.png"));

    _time = widget.time;
    if(!TimerUtils.isAheadOrBefore(_time)) {
      _timer = Timer.periodic(Duration(seconds: 1),(timer) {
        if (!TimerUtils.isAheadOrBefore(_time)) {
          if (mounted) {
            setState(() {
              _days = TimerUtils.getDays(_time, 'days');
              _hours = TimerUtils.getDays(_time, 'hours');
              _min = TimerUtils.getDays(_time, 'min');
              _sec = TimerUtils.getDays(_time, 'sec');
          //          if(int.parse(_sec) == 0) {
          //            _timer.cancel();
          //          }
            });
          }
        } else {
          _timer.cancel();
          if (mounted) {
            setState(() {
              _days = "00";
              _hours = "00";
              _min = "00";
              _sec = "00";
            });
          }
        }
      });
    }
    // widget.changeDetailTitle(_isDetail);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.changeDetailTitle(_isDetail));
    super.initState();
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: [
        Container(
//            height: !_isDetail? MediaQuery.of(context).size.width * 3.15 : MediaQuery.of(context).size.width * 1.9,
//              height: !_isDetail? 320.0.w : MediaQuery.of(context).size.width * 2.5,
//        height: 140.0.h,
          height: _selectedTab == 1? !_isDetail? 1470.0 : 1200.0 : !_isDetail? 1000.0 : 750.0,
          color: Colors.white,
          child: Stack(
            fit: StackFit.loose,
            children: [
              GestureDetector(
                onDoubleTap: () {
                  print('double tapped');
                  setState(() {
                    _isDetail = !_isDetail;
                  });
                  widget.changeDetailTitle(_isDetail);
                  cardKey.currentState.toggleCard();
                },
                child: Container(
                  height: !_isDetail? 550.0 : 520.0,
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
                        margin: EdgeInsets.only(top: 25.0, bottom: 80.0),
                        child: Column(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Center(
                              child: Text(
                                widget.text,
                                style: AppStyles.poppinsTextStyle(fontSize: 30.0.sp, weight: FontWeight.w400),
                              ),
                            ),

                            SizedBox(height: 20.0,),

                            Image.asset(
                              widget.offer,
//                              width: 45.0.w,
                              height: 300.0,
//                              width: 45.0.w,
//                              height: 80.0.w,
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
                            color: Colors.black45,
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
                        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.offerName,
                              // 'hello heloo jdfsd jdf jbdfkj  fsdfdsfsf fsdf fbsdfb djbdksf jkdfskjds bfdsbfk',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyles.poppinsTextStyle(fontSize: 18.0.sp, weight: FontWeight.w500),
                            ),

                            SizedBox(height: 10.0,),

                            RatingBar(
                              onRatingUpdate: null,
                              ratingWidget: RatingWidget(
                                  full: Icon(
                                    FontAwesomeIcons.solidStar,
                                    color: AppColors.PALE_YELLOW_COLOR,
                                  ),
                                  half: Icon(
                                    FontAwesomeIcons.starHalfAlt,
                                    color: AppColors.PALE_YELLOW_COLOR,
                                  ),
                                  empty: Icon(
                                    FontAwesomeIcons.star,
//                                    color: AppColors.PALE_YELLOW_COLOR,
                                    color: Colors.white,
                                  )
                              ),
                              itemSize: 15.0,
                              initialRating: 4.0,
                              allowHalfRating: true,
                              glow: false,
                              itemPadding: EdgeInsets.only(left: 5.0),
                            ),

                            SizedBox(height: 20.0,),

                              Row(
                                children: [
                                  Text(
                                    "Average Review :",
                                    style: AppStyles.poppinsTextStyle(fontSize: 12.0.sp, weight: FontWeight.w300),
                                  ),

                                  Spacer(),

//                                Text(
//                                  "  - - - - - - - - - -  ",
//                                  style: AppStyles.poppinsTextStyle(fontSize: 13.0.sp, weight: FontWeight.w400),
//                                ),
//
//                                Spacer(),

                                Text(
                                  "4.3",
                                  style: AppStyles.poppinsTextStyle(fontSize: 12.0.sp, weight: FontWeight.w300),
                                )
                              ],
                            ),

                            SizedBox(height: 15.0,),

                            Row(
                              children: [
                                Text(
                                  "Number of Uses :",
                                  style: AppStyles.poppinsTextStyle(fontSize: 12.0.sp, weight: FontWeight.w300),
                                ),

                                Spacer(),

//                                Text(
//                                  "  - - - - - - - - - -  ",
//                                  style: AppStyles.poppinsTextStyle(fontSize: 13.0.sp, weight: FontWeight.w400),
//                                ),

//                                Spacer(),

                                Text(
                                  "08",
                                  style: AppStyles.poppinsTextStyle(fontSize: 12.0.sp, weight: FontWeight.w300),
                                )
                              ],
                            )                ,

                            SizedBox(height: 15.0,),

                            Row(
                              children: [
                                Text(
                                  "Distance :",
                                  style: AppStyles.poppinsTextStyle(fontSize: 12.0.sp, weight: FontWeight.w300),
                                ),

                                Spacer(),

//                                Text(
//                                  "  - - - - - - - - - -  ",
//                                  style: AppStyles.poppinsTextStyle(fontSize: 13.0.sp, weight: FontWeight.w400),
//                                ),
//
//                                Spacer(),

                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 8,
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
                                  child: Text(
                                    "4.5 miles",
                                    style: AppStyles.poppinsTextStyle(fontSize: 11.0.sp, weight: FontWeight.w400).copyWith(color: Colors.black),
                                  ),
                                )
                              ],
                            ),

                            SizedBox(height: 15.0,),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Location :",
                                  style: AppStyles.poppinsTextStyle(fontSize: 12.0.sp, weight: FontWeight.w300),
                                ),

                                Spacer(),
//                                SizedBox(width: 15.0,),

//                                Text(
//                                  "  - - - - - - - - - -  ",
//                                  style: AppStyles.poppinsTextStyle(fontSize: 13.0.sp, weight: FontWeight.w400),
//                                ),
//
//                                SizedBox(width: 15.0,),

                                Expanded(
                                  child: Text(
                                    "99 Balentine 123 Drive, Newark",
                                    style: AppStyles.poppinsTextStyle(fontSize: 12.0.sp, weight: FontWeight.w300),
                                    textAlign: TextAlign.end,
                                  ),
                                )
                              ],
                            ),

                            SizedBox(height: 15.0,),

                            Divider(color: Colors.grey[400], height: 1.0, thickness: 0.5,),

                            SizedBox(height: 15.0,),

                            Center(
                              child: Text(
                                "Time to Avail the Offer:",
                                style: AppStyles.poppinsTextStyle(fontSize: 15.0.sp, weight: FontWeight.w400),
                              ),
                            ),

                            SizedBox(height: 8.0,),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      _days,
                                      style: AppStyles.poppinsTextStyle(fontSize: 24.0.sp, weight: FontWeight.w500).copyWith(letterSpacing: 2.0),
                                    ),

//                                    SizedBox(height: 6.0,),

                                    Text(
                                      int.parse(_days) > 1? 'Days' : 'Day',
                                      style: AppStyles.poppinsTextStyle(fontSize: 12.0.sp, weight: FontWeight.w300),
                                    ),
                                  ],
                                ),

                                SizedBox(width: 20.0,),

                                Column(
                                  children: [
                                    Text(
                                      _hours,
                                      style: AppStyles.poppinsTextStyle(fontSize: 24.0.sp, weight: FontWeight.w500).copyWith(letterSpacing: 2.0),
                                    ),

//                                    SizedBox(height: 6.0,),

                                    Text(
                                      int.parse(_hours) > 1? 'Hours' : 'Hour',
                                      style: AppStyles.poppinsTextStyle(fontSize: 12.0.sp, weight: FontWeight.w300),
                                    ),
                                  ],
                                ),

                                SizedBox(width: 20.0,),

                                Column(
                                  children: [
                                    Text(
                                      _min,
                                      style: AppStyles.poppinsTextStyle(fontSize: 24.0.sp, weight: FontWeight.w500).copyWith(letterSpacing: 2.0),
                                    ),

//                                    SizedBox(height: 6.0,),

                                    Text(
                                      'Min',
                                      style: AppStyles.poppinsTextStyle(fontSize: 12.0.sp, weight: FontWeight.w300),
                                    ),
                                  ],
                                ),

                                SizedBox(width: 20.0,),

                                Column(
                                  children: [
                                    Text(
                                      _sec,
                                      style: AppStyles.poppinsTextStyle(fontSize: 24.0.sp, weight: FontWeight.w500).copyWith(letterSpacing: 2.0),
                                    ),

//                                    SizedBox(height: 0.0,),

                                    Text(
                                      'Sec',
                                      style: AppStyles.poppinsTextStyle(fontSize: 12.0.sp, weight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                              ],
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
//              top: !_isDetail? 115.0.w : 130.0.w,
              top: !_isDetail? 450.0: 500.0,
              left: 0.0,
              right: 0.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  !_isDetail? Container(
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
//                                "https://i1.wp.com/www.logoworks.com/blog/wp-content/uploads/2017/06/Untitled-2.png?fit=1280%2C800&ssl=1",
                                widget.image,
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
                                          widget.offerName,
                                          // 'asdsd sdsad sdasd sfdf dsfds dfdsf sfsdf fsf sfdsf fsdf  dfsd fsdf fsdf sdfsdf dfs',
                                          style: AppStyles.poppinsTextStyle(fontSize: 17.0, weight: FontWeight.w500).copyWith(color: Colors.black),
                                        ),

                                        SizedBox(height: 5.0,),

                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                "Triple Mocha Frappuccino",
                                                style: AppStyles.poppinsTextStyle(fontSize: 14.0, weight: FontWeight.w300).copyWith(color: Colors.black),
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

                            SizedBox(width: 12.0,),

                            GestureDetector(
                              onTap: () {
                                launch(('tel:+11234567825'));
                              },
                              child: Text(
                                "+1 1234567825",
                                style: AppStyles.poppinsTextStyle(fontSize: 13.0, weight: FontWeight.w400).copyWith(color: AppColors.GREEN_COLOR),
                              ),
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
                              child: GestureDetector(
                                onTap: () async {
                                  if (await MapLauncher.isMapAvailable(Platform.isAndroid? MapType.google : MapType.apple)) {
                                  await MapLauncher.showMarker(
                                  mapType: Platform.isAndroid? MapType.google : MapType.apple,
                                  coords: widget.coord,
                                  title: widget.locationTitle,
//                                  description: "Map",
                                  );
                                  }
                                },
                                child: Text(
                                  "4058 Little York Rd, Houston, TX 77093, USA",
                                  style: AppStyles.poppinsTextStyle(fontSize: 13.0, weight: FontWeight.w400).copyWith(color: AppColors.BLUE_COLOR_DARK),
                                ),
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
                              initialRating: 5.0,
                              allowHalfRating: true,
                              glow: false,
                              itemPadding: EdgeInsets.only(left: 5.0),
                            ),
                          ],
                        )
                      ],
                    ),
                  ) : Container(),

                  true? SizedBox(height: 15.0,) : Container(),

                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Column(
                      children: [
                        !_isDetail? SizedBox(height: 10.0,) : Container(),

                        !_isDetail? Divider(color: Colors.grey[400], height: 1.0, thickness: 0.5,) : Container(),

                        SizedBox(height: 10.0,),

                        Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              // left: 0.0,
                              // right: 0.0,
                              child: Container(width: 1.0, height: 25.0, color: Colors.grey[400],)
                            ),

                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                margin: EdgeInsets.only(right: 120.0, top: 2.0),
                                child: InkWell(
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
                              ),
                            ),

                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                margin: EdgeInsets.only(left: 100.0, top: 2.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _selectedTab = 1;
                                    });
                                  },
                                  child: Text(
                                    AppStrings.REVIEWS,
                                    style: _selectedTab == 1? AppStyles.selectedTabTextStyle() : AppStyles.unselectedTabTextStyle(),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                        SizedBox(height: 10.0,),

                        _selectedTab == 0? Container(
//                          height: 500.0,
                          child: Text(
                            "Starbucks' new Triple Mocha Frappuccino was released on May Day 2018, and it's basically and enhanced version of the original MochaCookies are important to the proper functioning of a site. To improve your experience, we use cookies to remember log-in details and provide secure log-in, collect statistics.",
                            style: AppStyles.poppinsTextStyle(fontSize: 13.0, weight: FontWeight.w400).copyWith(color: AppColors.GREY_COLOR, height: 1.5),
                          ),
                        ) : Container(),

                        _selectedTab == 1? Container(
//                          height: 500.0,
                          child: Column(
                            children: [
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: _listOfReviews.length,
                                  itemBuilder: (context, index) {

                                    return NotificationTileView(context: context, data: _listOfReviews[index], hasTopDivider: index == 0? false : true);
                                  }
                               ),

                              SizedBox(height: 5.0,),

                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, AppRoutes.REVIEWS_VIEW);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppStrings.VIEW_ALL,
                                      style: AppStyles.poppinsTextStyle(fontSize: 15.0, weight: FontWeight.w500).copyWith(color: AppColors.UNSELECTED_COLOR),
                                    ),

                                    SizedBox(width: 5.0,),

                                    Icon(
                                      Icons.arrow_forward_ios_sharp,
                                      color: AppColors.UNSELECTED_COLOR,
                                      size: 15.0,
                                    )
                                  ],
                                ),
                              ),
                            ],
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
      ]
    );
  }
}
