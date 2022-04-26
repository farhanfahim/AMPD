import 'dart:async';
import 'dart:io';

import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/data/model/OffeReviewsModel.dart';
import 'package:ampd/data/model/UserLocation.dart';
import 'package:ampd/utils/timer_utils.dart';
import 'package:ampd/widgets/NotificationTileView.dart';
import 'package:ampd/widgets/Skeleton.dart';
import 'package:ampd/widgets/button_border.dart';
import 'package:ampd/widgets/dialog_view.dart';
import 'package:ampd/widgets/gradient_button.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ampd/data/model/OfferDataClassModel.dart';

class OfferCardWidget2 extends StatefulWidget {
  String text;
  String image;
  String offer;
  String offerName;
  String time;
  String locationTitle;
  Coords coord;
  UserLocation currentCoords;
  ValueChanged<bool> changeDetailTitle;
  bool isRedeemNow;

  Function onRedeemTap;

  Dataclass data;

  OfferCardWidget2(
      {this.text,
      this.image,
      this.offer,
      this.offerName,
      this.time,
      this.coord,
      this.currentCoords,
      this.locationTitle,
      this.changeDetailTitle,
      this.isRedeemNow,
      this.data,
      this.onRedeemTap});

  @override
  _OfferCardWidget2State createState() => _OfferCardWidget2State();
}

class _OfferCardWidget2State extends State<OfferCardWidget2>
    with SingleTickerProviderStateMixin {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  int _selectedTab = 0;
  bool _isDetail = false;
  String _time = "2021-12-30 09:00:00";
  String _days = "00";
  String _hours = "00";
  String _min = "00";
  String _sec = "00";
  bool _isRedeemNow = false;
  Timer _timer;

  int clr;

  @override
  void initState() {
    String color = widget.data.backgroundColor != "undefined"
        ? widget.data.backgroundColor.replaceAll('#', '0xff')
        : "#2491EB".replaceAll('#', '0xff');
    clr = int.parse(color);
    //_time = widget.time;

    var today = new DateTime.now();
    var updatedDate = today.add(new Duration(hours: int.parse(widget.data.availTime.toString())));
    _time = DateFormat('yyyy-MM-dd HH:mm:ss').format(updatedDate);

    print("{widget.data.store.openingTime}");
    if (!TimerUtils.isAheadOrBefore(_time)) {
      setState(() {
        _days = TimerUtils.getDays(_time, 'days');
        _hours = TimerUtils.getDays(_time, 'hours');
        _min = TimerUtils.getDays(_time, 'min');
        _sec = TimerUtils.getDays(_time, 'sec');
        //          if(int.parse(_sec) == 0) {
        //            _timer.cancel();
        //          }
      });
      /*_timer = Timer.periodic(Duration(seconds: 1), (timer) {
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
              _days = "10";
              _hours = "00";
              _min = "00";
              _sec = "00";
            });
          }
        }
      });*/
    }
    // widget.changeDetailTitle(_isDetail);
    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.changeDetailTitle(_isDetail));
    _isRedeemNow = widget.isRedeemNow;
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
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onDoubleTap: () {
                print('double tapped');
                setState(() {
                  _isDetail = !_isDetail;
                });
                widget.changeDetailTitle(_isDetail);
                cardKey.currentState.toggleCard();
              },
              child: new Container(
                height: !_isDetail ? 550.0 : 550.0,
                color: Color(clr),
                child: FlipCard(
                  direction: FlipDirection.HORIZONTAL,
                  // default
                  flipOnTouch: false,
                  key: cardKey,
                  front: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 25.0, bottom: 0.0),
                        child: Stack(
                          children: [
                            widget.data.waterMarkImage!=null?Positioned(
                              left: MediaQuery.of(context).size.width/2.5,
                              child:CachedNetworkImage(
                                imageUrl: widget.data.waterMarkImage,
                                fit: BoxFit.cover,
                                height: 500.0,
                                // fadeInCurve: Curves.easeIn,
                                imageBuilder: (BuildContext context,
                                    ImageProvider<dynamic> imageProvider) {
                                  return Image(
                                    // width: constraints.maxWidth,
                                    image: imageProvider,
                                    colorBlendMode: BlendMode.srcATop,
                                    fit: BoxFit.cover,

                                  );
                                },
                                placeholder: (context, url) => Skeleton(),
//              errorWidget: (context, url, error){
//                return Image.asset(AppImages.NO_IMAGE_PLACEHOLDER);
//              },
                              ),
                            ):Container(),
                            Column(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Center(
                                  child: Text(
                                    widget.data.type == 10
                                        ? "\$" + widget.text
                                        : widget.text + "%",
                                    style: AppStyles.poppinsTextStyle(
                                        fontSize: 30.0.sp, weight: FontWeight.w400),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                CachedNetworkImage(
                                  imageUrl: widget.data.imageUrl,
                                  fit: BoxFit.cover,
                                  height: 300.0,
                                  // fadeInCurve: Curves.easeIn,
                                  imageBuilder: (BuildContext context,
                                      ImageProvider<dynamic> imageProvider) {
                                    return Image(
                                      // width: constraints.maxWidth,
                                      image: imageProvider,
                                      colorBlendMode: BlendMode.srcATop,
                                      fit: BoxFit.cover,

                                    );
                                  },
                                  placeholder: (context, url) => Skeleton(),
//              errorWidget: (context, url, error){
//                return Image.asset(AppImages.NO_IMAGE_PLACEHOLDER);
//              },
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                  back: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.data.productName,
                              // 'hello heloo jdfsd jdf jbdfkj  fsdfdsfsf fsdf fbsdfb djbdksf jkdfskjds bfdsbfk',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyles.poppinsTextStyle(
                                  fontSize: 18.0.sp, weight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
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
                                  )),
                              itemSize: 15.0,
                              initialRating: widget.data.averageRating != null
                                  ? double.parse(widget.data.averageRating)
                                  : 0.0,
                              allowHalfRating: true,
                              glow: false,
                              itemPadding: EdgeInsets.only(left: 5.0),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),

                            /*   Row(
                            children: [
                              Text(
                                "Average Review :",
                                style: AppStyles.poppinsTextStyle(
                                    fontSize: 12.0.sp,
                                    weight: FontWeight.w300),
                              ),

                              Spacer(),

//                                Text(
//                                  "  - - - - - - - - - -  ",
//                                  style: AppStyles.poppinsTextStyle(fontSize: 13.0.sp, weight: FontWeight.w400),
//                                ),
//
//                                Spacer(),

                              Text(
                                widget.data.averageRating != null ? widget
                                    .data.averageRating : "0.0",
                                style: AppStyles.poppinsTextStyle(
                                    fontSize: 12.0.sp,
                                    weight: FontWeight.w300),
                              )
                            ],
                          ),

                          SizedBox(height: 15.0,),*/

                            Row(
                              children: [
                                Text(
                                  "Number of Uses :",
                                  style: AppStyles.poppinsTextStyle(
                                      fontSize: 12.0.sp,
                                      weight: FontWeight.w300),
                                ),

                                Spacer(),

//                                Text(
//                                  "  - - - - - - - - - -  ",
//                                  style: AppStyles.poppinsTextStyle(fontSize: 13.0.sp, weight: FontWeight.w400),
//                                ),

//                                Spacer(),

                                Text(
                                  widget.data.numberOfUses != null
                                      ? widget.data.numberOfUses.toString()
                                      : "0.0",
                                  style: AppStyles.poppinsTextStyle(
                                      fontSize: 12.0.sp,
                                      weight: FontWeight.w300),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15.0,
                            ),

                            /* Row(
                            children: [
                              Text(
                                "Distance :",
                                style: AppStyles.poppinsTextStyle(
                                    fontSize: 12.0.sp,
                                    weight: FontWeight.w300),
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
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 10.0),
                                child: Text(
                                  "${calculateDistance()} miles",
                                  style: AppStyles.poppinsTextStyle(
                                      fontSize: 11.0.sp,
                                      weight: FontWeight.w400).copyWith(
                                      color: Colors.black),
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
                                style: AppStyles.poppinsTextStyle(
                                    fontSize: 12.0.sp,
                                    weight: FontWeight.w300),
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
                                  widget.data.user.address != null ? widget
                                      .data.user.address : "-",
                                  style: AppStyles.poppinsTextStyle(
                                      fontSize: 12.0.sp,
                                      weight: FontWeight.w300),
                                  textAlign: TextAlign.end,
                                ),
                              )
                            ],
                          ),*/

                            SizedBox(
                              height: 15.0,
                            ),
                            Divider(
                              color: Colors.grey[400],
                              height: 1.0,
                              thickness: 0.5,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Center(
                              child: Text(
                                "Valid upto",
                                style: AppStyles.poppinsTextStyle(
                                    fontSize: 15.0.sp, weight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      _days,
                                      //widget.data.availTime != null? widget.data.availTime.toString() :"00",
                                      style: AppStyles.poppinsTextStyle(
                                              fontSize: 24.0.sp,
                                              weight: FontWeight.w500)
                                          .copyWith(letterSpacing: 2.0),
                                    ),

//                                    SizedBox(height: 6.0,),

                                    Text(
                                      //widget.data.availTime > 1? 'Days' : 'Day',
                                      int.parse(_days) > 1 ? 'Days' : 'Day',
                                      style: AppStyles.poppinsTextStyle(
                                          fontSize: 12.0.sp,
                                          weight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      //widget.data.recurrenceTime != null? widget.data.recurrenceTime.toString() :"00",
                                      _hours,
                                      style: AppStyles.poppinsTextStyle(
                                              fontSize: 24.0.sp,
                                              weight: FontWeight.w500)
                                          .copyWith(letterSpacing: 2.0),
                                    ),

//                                    SizedBox(height: 6.0,),

                                    Text(
                                      //widget.data.recurrenceTime > 1? 'Hours' : 'Hour',
                                      int.parse(_hours) > 1 ? 'Hours' : 'Hour',
                                      style: AppStyles.poppinsTextStyle(
                                          fontSize: 12.0.sp,
                                          weight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      _min,
                                      style: AppStyles.poppinsTextStyle(
                                              fontSize: 24.0.sp,
                                              weight: FontWeight.w500)
                                          .copyWith(letterSpacing: 2.0),
                                    ),

//                                    SizedBox(height: 6.0,),

                                    Text(
                                      'Min',
                                      style: AppStyles.poppinsTextStyle(
                                          fontSize: 12.0.sp,
                                          weight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      _sec,
                                      style: AppStyles.poppinsTextStyle(
                                              fontSize: 24.0.sp,
                                              weight: FontWeight.w500)
                                          .copyWith(letterSpacing: 2.0),
                                    ),

//                                    SizedBox(height: 0.0,),

                                    Text(
                                      'Sec',
                                      style: AppStyles.poppinsTextStyle(
                                          fontSize: 12.0.sp,
                                          weight: FontWeight.w300),
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
            Container(
              margin: EdgeInsets.only(
                  top: !_isDetail ? 450.0 : 450.0, left: 0.0, right: 0.0),
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedSize(
                        curve: Curves.fastOutSlowIn,
                        child: new Container(
                          height: 400.0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 20.0),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 20.0),
                            child: Column(
                              children: [
                                widget.isRedeemNow
                                    ? GestureDetector(
                                        onTap: widget.onRedeemTap,
                                        child: Container(
                                          height: 50.0,
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0xff174EA0),
                                                  Color(0xff1E70C6),
                                                  Color(0xff2490E9)
                                                ],
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: Container(
                                            constraints: BoxConstraints(
                                                maxWidth: 300.0,
                                                minHeight: 50.0),
                                            alignment: Alignment.center,
                                            child: Text(
                                              AppStrings.REDEEM_NOW,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                                SizedBox(
                                  height: 30.0,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    CircleAvatar(
                                      radius: 30.0,
                                      backgroundColor: AppColors.WHITE_COLOR,
                                      child: widget.data.user.imageUrl.isNotEmpty?cacheImageVIewWithCustomSize(
                                          url: widget.data.user.imageUrl,
                                          context: context,
                                          width: 60,
                                          height: 60,
                                          radius: 80.0):ClipRRect(
                                        borderRadius: BorderRadius.circular(60),
                                        child: Image.asset(
                                          "assets/images/user.png",
                                          fit: BoxFit.fill,
                                        ),
                                      )

                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  widget.offerName,
                                                  // 'asdsd sdsad sdasd sfdf dsfds dfdsf sfsdf fsf sfdsf fsdf  dfsd fsdf fsdf sdfsdf dfs',
                                                  style: AppStyles
                                                          .poppinsTextStyle(
                                                              fontSize: 17.0,
                                                              weight: FontWeight
                                                                  .w500)
                                                      .copyWith(
                                                          color: Colors.black),
                                                ),
                                                SizedBox(
                                                  height: 5.0,
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        widget.data.store !=
                                                                null
                                                            ? widget
                                                                .data.store.name
                                                            : "-",
                                                        maxLines: 2,
                                                        softWrap: true,
                                                        overflow: TextOverflow.ellipsis,
                                                        style: AppStyles
                                                                .poppinsTextStyle(
                                                                    fontSize:
                                                                        14.0,
                                                                    weight:
                                                                        FontWeight
                                                                            .w300)
                                                            .copyWith(
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 8.0,
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      border: Border.all(
                                                          color: AppColors
                                                              .GREY_COLOR,
                                                          width: 1.0)),
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 3.0,
                                                      horizontal: 6.0),
                                                  child: Text(
                                                    "${calculateDistance()} miles",
                                                    style: AppStyles
                                                            .poppinsTextStyle(
                                                                fontSize: 13.0,
                                                                weight:
                                                                    FontWeight
                                                                        .w400)
                                                        .copyWith(
                                                            color:
                                                                Colors.black),
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
                                SizedBox(
                                  height: 15.0,
                                ),
                                Divider(
                                  color: Colors.grey[400],
                                  height: 1.0,
                                  thickness: 0.5,
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 2.0,
                                    ),
                                    Icon(
                                      Icons.phone,
                                      color: AppColors.GREEN_COLOR,
                                      size: 20.0,
                                    ),
                                    SizedBox(
                                      width: 12.0,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        launch(
                                            ('tel:${widget.data.user.phone}'));
                                      },

                                      child: Text(
                                        widget.data.user.phone != null
                                            ? widget.data.user.phone.replaceAllMapped(RegExp(r'(\d{3})(\d{3})(\d+)'), (Match m) => "(${m[1]}) ${m[2]}-${m[3]}")
                                            : "-",
                                        style: AppStyles.poppinsTextStyle(
                                                fontSize: 13.0,
                                                weight: FontWeight.w400)
                                            .copyWith(
                                                color: AppColors.GREEN_COLOR),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 6.0,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_rounded,
                                      color: AppColors.RED_COLOR,
                                      size: 24.0,
                                    ),
                                    SizedBox(
                                      width: 12.0,
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () async {
                                          if (await MapLauncher.isMapAvailable(
                                              Platform.isAndroid
                                                  ? MapType.google
                                                  : MapType.apple)) {
                                            await MapLauncher.showMarker(
                                              mapType: Platform.isAndroid
                                                  ? MapType.google
                                                  : MapType.apple,
                                              coords: widget.coord,
                                              title: widget.locationTitle,
//                                  description: "Map",
                                            );
                                          }
                                        },
                                        child: Text(
                                          widget.data.user.address != null
                                              ? widget.data.user.address
                                              : "-",
                                          maxLines: 3,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppStyles.poppinsTextStyle(
                                                  fontSize: 13.0,
                                                  weight: FontWeight.w400)
                                              .copyWith(
                                                  color: AppColors
                                                      .BLUE_COLOR_DARK),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 6.0,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 3.0,
                                    ),
                                    Icon(
                                      FontAwesomeIcons.solidClock,
                                      color: AppColors.DARK_GREY_COLOR2,
                                      size: 17.0,
                                    ),
                                    SizedBox(
                                      width: 15.0,
                                    ),
                                    Expanded(
                                      child: Text(
                                        widget.data.store != null &&
                                                widget.data.store != null
                                            ? "Hours: Opens ${widget.data.store.openingTime} - Closed ${widget.data.store.closingTime}"
                                            : "-",
                                        style: AppStyles.poppinsTextStyle(
                                                fontSize: 13.0,
                                                weight: FontWeight.w400)
                                            .copyWith(
                                                color:
                                                    AppColors.DARK_GREY_COLOR2),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 35.0,
                                    ),
                                    Text(
                                      widget.data.averageRating != null
                                          ? "5.0 (${widget.data.averageRating})"
                                          : "5.0 (0.0)",
                                      style: AppStyles.poppinsTextStyle(
                                              fontSize: 14.0,
                                              weight: FontWeight.w400)
                                          .copyWith(
                                              color:
                                                  AppColors.GREEN_BRIGHT_COLOR),
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
                                          )),
                                      itemSize: 13.0,
                                      initialRating:
                                          widget.data.averageRating != null
                                              ? double.parse(
                                                  widget.data.averageRating)
                                              : 0.0,
                                      allowHalfRating: true,
                                      glow: false,
                                      itemPadding: EdgeInsets.only(left: 5.0),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        vsync: this,
                        duration: new Duration(seconds: 1),
                      ),
                      true
                          ? SizedBox(
                              height: 15.0,
                            )
                          : Container(),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 40.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10.0,
                            ),
                            Divider(
                              color: Colors.grey[400],
                              height: 1.0,
                              thickness: 0.5,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Stack(
                              children: [
                                Align(
                                    alignment: Alignment.center,
                                    // left: 0.0,
                                    // right: 0.0,
                                    child: Container(
                                      width: 1.0,
                                      height: 25.0,
                                      color: Colors.grey[400],
                                    )),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(right: 120.0, top: 2.0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _selectedTab = 0;
                                        });
                                      },
                                      child: Text(
                                        AppStrings.DESCRIPTION,
                                        style: _selectedTab == 0
                                            ? AppStyles.selectedTabTextStyle()
                                            : AppStyles
                                                .unselectedTabTextStyle(),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(left: 100.0, top: 2.0),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _selectedTab = 1;
                                        });
                                      },
                                      child: Text(
                                        AppStrings.REVIEWS,
                                        style: _selectedTab == 1
                                            ? AppStyles.selectedTabTextStyle()
                                            : AppStyles
                                                .unselectedTabTextStyle(),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            _selectedTab == 0
                                ? Container(
//                          height: 500.0,
                                    child: Text(
                                      widget.data.store != null
                                          ? widget.data.store.about
                                          : "-",
                                      style: AppStyles.poppinsTextStyle(
                                              fontSize: 13.0,
                                              weight: FontWeight.w400)
                                          .copyWith(
                                              color: AppColors.GREY_COLOR,
                                              height: 1.5),
                                    ),
                                  )
                                : Container(),
                            _selectedTab == 1
                                ? Container(
//                          height: 500.0,
                                    child: Column(
                                      children: [
                                        widget.data.reviews.length > 0
                                            ? ListView.builder(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount:
                                                    widget.data.reviews.length,
                                                itemBuilder: (context, index) {
                                                  return NotificationTileView(
                                                      data: widget
                                                          .data.reviews[index],
                                                      hasTopDivider: index == 0
                                                          ? false
                                                          : true);
                                                })
                                            : Container(
                                                child: Text(
                                                  "No reviews",
                                                  style: AppStyles
                                                          .poppinsTextStyle(
                                                              fontSize: 15.0,
                                                              weight: FontWeight
                                                                  .w500)
                                                      .copyWith(
                                                          color: AppColors
                                                              .UNSELECTED_COLOR),
                                                ),
                                              ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        widget.data.reviews.length > 4
                                            ? InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(context,
                                                      AppRoutes.REVIEWS_VIEW,
                                                      arguments: {
                                                        'offerId':
                                                            widget.data.id
                                                      });
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      AppStrings.VIEW_ALL,
                                                      style: AppStyles
                                                              .poppinsTextStyle(
                                                                  fontSize:
                                                                      15.0,
                                                                  weight:
                                                                      FontWeight
                                                                          .w500)
                                                          .copyWith(
                                                              color: AppColors
                                                                  .UNSELECTED_COLOR),
                                                    ),
                                                    SizedBox(
                                                      width: 5.0,
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .arrow_forward_ios_sharp,
                                                      color: AppColors
                                                          .UNSELECTED_COLOR,
                                                      size: 15.0,
                                                    )
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                        SizedBox(
                                          height: 15.0,
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double calculateDistance() {
    double _distanceInMeters = Geolocator.distanceBetween(
            widget.coord.latitude,
            widget.coord.longitude,
            widget.currentCoords.latitude,
            widget.currentCoords.longitude) /
        1000;

    double convertKmToMile = _distanceInMeters * 0.6213;
    return convertKmToMile.roundToDouble();
  }
}
