import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_fonts.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/data/model/FriendRequestsModel.dart';
import 'package:ampd/data/model/StoriesModel.dart';
import 'package:ampd/data/model/TeeTimesResponse.dart';
import 'package:ampd/utils/Util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';


import 'Skeleton.dart';

Widget searchTextField({BuildContext context}){
  return TextFormField(
    style: AppStyles.blackWithDifferentFontTextStyle(context, 12.0),
    obscureText: false,
    textInputAction: TextInputAction.done,
    keyboardType: TextInputType.visiblePassword,
    decoration: AppStyles.decorationWithLeadingEdgeIcon(context, "Search", Icons.search),
  );
}
//
// Widget searchTextFieldTeeTimes({BuildContext context}){
//   return TextFormField(
//     style: AppStyles.blackWithDifferentFontTextStyle(context, 12.0),
//     obscureText: false,
//     textInputAction: TextInputAction.done,
//     keyboardType: TextInputType.visiblePassword,
//     decoration: AppStyles.decorationWithLeadingEdgeIconTeeTimes(context, "Search", Icons.search),
//   );
// }

showiOSBirthdayDatePicker(BuildContext context, bool isAllowFutureDates, bool isAllowPastDates, Function onConfirm){
  DatePicker.showDatePicker(context,
      showTitleActions: true,
      theme: DatePickerTheme(
        backgroundColor: Theme.of(context).backgroundColor,
        cancelStyle: TextStyle(color: Colors.grey),
        itemStyle: TextStyle(color: Theme.of(context).appBarTheme.textTheme.headline1.color),
        //  containerHeight: 20.0.h,
      ),
      minTime: DateTime(1920, 1, 1) ,
      maxTime:  DateTime.now().subtract(Duration(days: 4380)), onChanged: (date) {
        print('change $date');
      }, onConfirm: onConfirm,
      currentTime: DateTime.now(), locale: LocaleType.en);
}

showiOSDatePicker(BuildContext context, bool isAllowFutureDates, bool isAllowPastDates, Function onConfirm){
  DatePicker.showDatePicker(context,
      showTitleActions: true,
      theme: DatePickerTheme(
        backgroundColor: Theme.of(context).backgroundColor,
        cancelStyle: TextStyle(color: Colors.grey),
        itemStyle: TextStyle(color: Theme.of(context).appBarTheme.textTheme.headline1.color),
      //  containerHeight: 20.0.h,
      ),
      // minTime: isAllowPastDates ? DateTime(1920, 1, 1) : DateTime.now(),
      minTime: DateTime.now(),
      // maxTime: isAllowFutureDates ? DateTime(DateTime.now().year, 12, 31) : DateTime.now(), onChanged: (date) {
      maxTime:  DateTime(DateTime.now().year, 12, 31).add(Duration(days: 1825)), onChanged: (date) {
        print('change $date');
      }, onConfirm: onConfirm,
      currentTime: DateTime.now(), locale: LocaleType.en);
}

cupertinoTimePicker(BuildContext context, Function onConfirm){
  DatePicker.showTime12hPicker(context,

      theme: DatePickerTheme(

        backgroundColor: Theme.of(context).backgroundColor,
        cancelStyle: TextStyle(color: Colors.grey),
        itemStyle: TextStyle(color: Theme.of(context).appBarTheme.textTheme.headline1.color),
        //  containerHeight: 20.0.h,
      ),
      showTitleActions: true,
      onChanged: (date) {
        print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
      },
      onConfirm: onConfirm,
      currentTime: DateTime.now());
}

Widget searchTextFieldTeeTimes({String hintText, FocusNode focusNode, BuildContext context, bool enabled, TextEditingController controller, Function onSearch, Function onChange}){
  return TextFormField(
      controller: controller,
    enabled: enabled,
      autofocus: true,
      focusNode: focusNode,
    inputFormatters: [
     // LengthLimitingTextInputFormatter(nameValidation),
      WhitelistingTextInputFormatter(RegExp("[a-zA-Z ]"))
    ],
    style: AppStyles.blackWithDifferentFontTextStyle(context, 12.0),
    obscureText: false,
    onChanged: onChange,
    onFieldSubmitted: onSearch,
    textInputAction: TextInputAction.search,
    keyboardType: TextInputType.text,
    decoration: AppStyles.decorationWithLeadingEdgeIconTeeTimes(context, hintText, Icons.search),
  );
}


Widget mostSellingTile({BuildContext context, String imageUrl, String productName, String productPrice, String productBrand, Function onProductTap}){
  return GestureDetector(
    onTap: onProductTap,
    child: Container(
      width: 120.0,
      height: 240.0,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120.0,
            height: 150.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Color(0xFFF2F1F1),
            ),

            child: ClipRRect( //networkCacheImageWithShimmerWithHeightWidth
              borderRadius: BorderRadius.circular(10.0),
              child: networkCacheImageWithShimmerWithHeightWidth(
                  width: 120.0,
                  height: 150.0,
                  // imagePath: "https://www.pngkit.com/png/full/89-896353_ladies-jacket-png-image-with-transparent-background-women.png",
                  imagePath: imageUrl,
                  boxFit: BoxFit.cover
              ),
            ),
          ),

          SizedBox(height: 5.0,),

          Flexible(
              child: Text(
                productName,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.subHeadingsTextStyle(context, 11.0.sp),)),

          SizedBox(height: 3.0,),

          Text(
            productBrand,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.detailTextStyle(fontSize: 10.0.sp).copyWith(fontWeight: FontWeight.w600),),

          SizedBox(height: 3.0,),

          Text(
            productPrice,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.detailTextStyle(fontSize: 10.0.sp).copyWith(fontWeight: FontWeight.w600),),
        ],
      ),
    ),
  );
}


Widget networkCacheImageWithShimmer({String imagePath}){
  return CachedNetworkImage(
    imageUrl: imagePath,
    fit: BoxFit.cover,
    // fadeInCurve: Curves.easeIn,
    imageBuilder: (BuildContext context,
        ImageProvider<dynamic> imageProvider) {
      return Image(
        // width: constraints.maxWidth,
        image: imageProvider,
        fit: BoxFit.cover,
      );
    },
    placeholder: (context, url) => Skeleton(),
    errorWidget: (context, url, error){
      return Image.asset(AppImages.NO_IMAGE_PLACEHOLDER);
    },
  );
}

Widget networkCacheImageWithShimmerWithFixedSkeleton({String imagePath,  BoxFit boxFit}){
  return CachedNetworkImage(
    // height: height,
    // width: width,
    imageUrl: imagePath,
    fit: boxFit,
    // fadeInCurve: Curves.easeIn,
    imageBuilder: (BuildContext context,
        ImageProvider<dynamic> imageProvider) {
      return Image(
        // width: constraints.maxWidth,
        image: imageProvider,
        fit: boxFit,
      );
    },
    placeholder: (context, url) => Container(
        height: 200.0,
        width: double.maxFinite,
        child: Skeleton()),
    errorWidget: (context, url, error){
      return Container(
        height: 200.0,
        width: double.maxFinite,
        child: errorImageWidget(
          boxFit: boxFit,
        ),
      );
    },
  );
}

Widget networkCacheImageWithShimmerWithHeightWidth({String imagePath, double height, double width, BoxFit boxFit}){
  return CachedNetworkImage(
    height: height,
    width: width,
    imageUrl: imagePath,
    fit: boxFit,
    // fadeInCurve: Curves.easeIn,
    imageBuilder: (BuildContext context,
        ImageProvider<dynamic> imageProvider) {
      return Image(
        // width: constraints.maxWidth,
        image: imageProvider,
        fit: boxFit,
      );
    },
    placeholder: (context, url) => Skeleton(),
    errorWidget: (context, url, error){
      return errorImageWidget(
        height: height,
        width: width,
        boxFit: boxFit,
      );
    },
  );
}

Widget errorImageWidget({double height, double width, BoxFit boxFit}){
  return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),child: Image.asset(AppImages.NO_IMAGE_PLACEHOLDER,
    width: width,
    height: height,
    fit: boxFit,));
}

Widget circularNetworkCacheImageWithShimmerWithHeightWidth({String imagePath, double radius, BoxFit boxFit}){
  return CircleAvatar(
    radius: radius + 1,
    backgroundColor: Colors.grey.withOpacity(0.4),
    child: CircleAvatar(
    radius: radius,
    child: ClipOval(
      child: CachedNetworkImage(
        // height: radius,
        // width: radius,
        imageUrl: imagePath,
        fit: boxFit,
        // fadeInCurve: Curves.easeIn,
        imageBuilder: (BuildContext context,
            ImageProvider<dynamic> imageProvider) {
          return Image(
            height: radius,
            width: radius,
            // width: constraints.maxWidth,
            image: imageProvider,
            fit: boxFit,
          );
        },
        placeholder: (context, url) => Skeleton(),
        errorWidget: (context, url, error){
          return Image.asset(AppImages.NO_IMAGE_PLACEHOLDER);
        },
        // placeholder: (context, url) {return Image.asset(AppImages.NO_IMAGE_PLACEHOLDER); },
      ),
    ),
  ),);
}

Widget button({String title, BuildContext context, Function onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(

        padding:  const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey,
          //     offset: Offset(0.0, 1.0), //(x,y)
          //     blurRadius: 2.0,
          //   ),
          // ],
          borderRadius: BorderRadius.circular(10.0),
          color: AppColors.ACCENT_COLOR,
        ),
        child: Center(
          child: Text(
            title,
            style: AppStyles.inputTextStyleWithPoppinsBold().copyWith(
                letterSpacing: 0.3
            ),
          ),
        )
    ),
  );
}

Widget buttonWithColor({String title, Color color, BuildContext context, Function onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(

        padding:  const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.grey,
          //     offset: Offset(0.0, 1.0), //(x,y)
          //     blurRadius: 2.0,
          //   ),
          // ],
          borderRadius: BorderRadius.circular(10.0),
          color: color,
          // color: AppColors.ACCENT_COLOR,
        ),
        child: Center(
          child: Text(
            title,
            style: AppStyles.inputTextStyleWithPoppinsBold().copyWith(
                letterSpacing: 0.3
            ),
          ),
        )
    ),
  );
}



Widget reviewItem(BuildContext context,) {
  return Container(
    child: Column(
      children: [

        SizedBox(
          height: 10.0,
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          height: 65.0,
                          imageUrl: "https://expertphotography.com/wp-content/uploads/2020/08/social-media-profile-photos-3.jpg",
                          fit: BoxFit.cover,
                          // fadeInCurve: Curves.easeIn,
                          imageBuilder: (BuildContext context,
                              ImageProvider<dynamic> imageProvider) {
                            return Image(
                              // width: constraints.maxWidth,
                              image: imageProvider,
                              fit: BoxFit.cover,
                            );
                          },
                          placeholder: (context, url) => Skeleton(),
                          // placeholder: (context, url) {return Image.asset(AppImages.NO_IMAGE_PLACEHOLDER); },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 10.0),
                      child: Container(
                        child: Text(
                          "Marks Anthony",
                          style: AppStyles.subHeadingsTextStyleSfUiFont(
                              context, 12.0.sp)
                              .copyWith(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .color),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: AlignmentDirectional.topEnd,
                child: Text(
                  "1 mo",
                  style: AppStyles.blackWithDifferentFontTextStyle(
                      context, 9.0.sp)
                      .copyWith(
                    color: AppColors.APP_GREY_TEXT_COLOR,
                    fontFamily: AppFonts.SF_UI_DISPLAY,
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ReadMoreText(
          "This is dummy copy. It is not meant to be read. It has been placed here solely to demonstrate the look and feel of finished, typeset text.",
          trimCollapsedText: AppStrings.READ_MORE,
          trimExpandedText: AppStrings.READ_LESS,
          trimLines: 2,
          trimMode: TrimMode.Line,
          style: AppStyles.blackWithDifferentFontTextStyle(context, 9.0.sp),
        ),
        SizedBox(
          height: 10.0,
        ),
       divider(),
      ],
    ),
  );
}

cupertinoModalPopupDialog(BuildContext context, String title, String body, Function onPressed){
  var alert = new CupertinoAlertDialog(
    // barrierDismissible: false,
    title: new Text(title),
    content: Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: new Text(body),
    ),
    actions: <Widget>[
      new CupertinoDialogAction(
          child: const Text('OK'),
          isDefaultAction: true,
          onPressed: onPressed
      ),
    ],
  );
  showDialog(context: context, child: alert, barrierDismissible: false);
}


Widget circularAvatar(double width, double height, String img_url, double radius){
  return  CircleAvatar(
    radius: radius,
    backgroundColor: Colors.transparent,
    child: ClipOval(
      child: CachedNetworkImage(
        width: width,
        height: height,
        imageUrl: img_url,
        fit: BoxFit.cover,
        // fadeInCurve: Curves.easeIn,
        imageBuilder: (BuildContext context,
            ImageProvider<dynamic> imageProvider) {
          return Image(
            // width: constraints.maxWidth,
            image: imageProvider,
            fit: BoxFit.cover,
          );
        },
        placeholder: (context, url) => Skeleton(),
        errorWidget: (context, url, error){
          return Image.asset(AppImages.NO_IMAGE_PLACEHOLDER);
        },
      ),
    ),
  );
}

Widget circularAvatarWithBoxFit(double width, double height, String img_url, double radius, BoxFit boxFit){
  return  CircleAvatar(
    radius: radius,
    backgroundColor: Colors.transparent,
    child: ClipOval(
      child: CachedNetworkImage(
        width: width,
        height: height,
        imageUrl: img_url,
        fit: boxFit,
        // fadeInCurve: Curves.easeIn,
        imageBuilder: (BuildContext context,
            ImageProvider<dynamic> imageProvider) {
          return Image(
            // width: constraints.maxWidth,
            image: imageProvider,
            fit: boxFit,
          );
        },
        placeholder: (context, url) => Skeleton(),
        errorWidget: (context, url, error){
          return Image.asset(AppImages.NO_IMAGE_PLACEHOLDER);
        },
      ),
    ),
  );
}

Widget teeTimesItem(BuildContext context){
  return Container(
    child: Padding(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15.0,
          ),
          Row(
            children: [
              circularAvatar(45.0, 45.0,
                  "https://cdn.fastly.picmonkey.com/contentful/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=800&q=70", 20.0),
              SizedBox(width: 8.0,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "John Doe",
                    style: AppStyles.blackWithSemiBoldFontTextStyle(
                        context, 12.0.sp)
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  Text(
                    "Organiser",
                    style: AppStyles.blackWithDifferentFontTextStyle(
                        context, 11.0.sp)
                        .copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.APP_GREY_TEXT_COLOR),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Divider(
            color: AppColors.DIVIDER_COLOR_LIGHT,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time_outlined,
                      color: AppColors.ACCENT_COLOR,
                      size: 19.0,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 0.0),
                      child: Text(
                        "10:00 AM - 11:30 PM",
                        style: AppStyles.blackWithDifferentFontTextStyle(
                            context, 9.5.sp)
                            .copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.APP_GREY_TEXT_COLOR),
                      ),
                    )
                  ],
                ),
              ),
              // SizedBox(
              //   width: 30.0,
              // ),
              Container(
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.calendarAlt,
                      color: AppColors.ACCENT_COLOR,
                      size: 15.0,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
                      child: Text(
                        "20 Nov, 2020",
                        style: AppStyles.blackWithDifferentFontTextStyle(
                            context, 9.5.sp)
                            .copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.APP_GREY_TEXT_COLOR),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 2.0.h,
          ),
          Text(
            "Red Zone's Opening",
            style: AppStyles.blackWithSemiBoldFontTextStyle(context, 15.0.sp)
                .copyWith(fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 2.0.h,
          ),
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: AppColors.ACCENT_COLOR,
                size: 19.0,
              ),
              SizedBox(
                width: 5.0,
              ),
              Flexible(
                child: Container(
                  child: Text(
                    "1234, Sun Set Boulivard. Lane 5, Houston, Tx 1234, 1234, Sun Set Boulivard. Lane 5, Houston, Tx 1234,",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: AppStyles.blackWithDifferentFontTextStyle(
                        context, 10.5.sp)
                        .copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.APP_GREY_TEXT_COLOR),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 2.0.h,
          ),
        ],
      ),
    ),
  );
}


Widget appBar({BuildContext context, bool isBackButton, String title, IconData icon, Function onBackClick}){
  return AppBar(
    brightness: Theme.of(context).appBarTheme.brightness,
    elevation: 0.6,
    backgroundColor: Theme.of(context).appBarTheme.color,
    centerTitle: true,
    automaticallyImplyLeading: isBackButton ? true : false,
    title: Text(
      title,
      style: AppStyles.appBarTitleTextStyle(context),
    ),
    leading: !isBackButton ? null : IconButton(
      onPressed: onBackClick,
      icon:  Icon(icon , color: Theme.of(context).appBarTheme.iconTheme.color, size: 30.0,),
    ),
  );
}

Widget appBarSearch1({BuildContext context, bool isBackButton, String title, IconData icon, Function onBackClick}){
  return AppBar(
    brightness: Theme.of(context).appBarTheme.brightness,
    elevation: 0.6,
    backgroundColor: Theme.of(context).appBarTheme.color,
    centerTitle: true,
    automaticallyImplyLeading: isBackButton ? true : false,
    title: Text(
      title,
      style: AppStyles.appBarTitleTextStyle(context),
    ),
    leading: !isBackButton ? null : IconButton(
      onPressed: onBackClick,
      icon:  Icon(icon , color: Theme.of(context).appBarTheme.iconTheme.color, size: 30.0,),
    ),
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(55.0),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
        child: Container(
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 15.0),
          child: searchTextField(
            context: context,
          ),
        ),
      ),
    ),
  );
}

Widget appBarSearch({BuildContext context, bool isBackButton, String title, IconData icon, Function onBackClick}){
  return AppBar(
    brightness: Theme.of(context).appBarTheme.brightness,
    elevation: 0.6,
    backgroundColor: Theme.of(context).appBarTheme.color,
    centerTitle: true,
    automaticallyImplyLeading: isBackButton ? true : false,
    title: Text(
      title,
      style: AppStyles.appBarTitleTextStyle(context),
    ),
    leading: !isBackButton ? null : IconButton(
      onPressed: onBackClick,
      icon: Icon(icon , color: Theme.of(context).appBarTheme.iconTheme.color, size: 30.0,),
    ),
    // bottom: PreferredSize(
    //   preferredSize: Size.fromHeight(55.0),
    //   child: Padding(
    //     padding: EdgeInsets.fromLTRB(0, 0, 0, 15),
    //     child: Container(
    //       height: 40,
    //       margin: const EdgeInsets.symmetric(horizontal: 15.0),
    //       child: searchTextField(
    //         context: context,
    //       ),
    //     ),
    //   ),
    // ),
  );
}


Widget orderRequestDetailItem(BuildContext context, bool isLast) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: networkCacheImageWithShimmerWithHeightWidth(
                imagePath:
                "https://www.sunspel.com/media/catalog/product/cache/bee6a030eca197d5b3b98b85dbca461b/m/t/mtsh0001-gyab_1_1.jpg",
                width: 60.0,
                height: 70.0,
                boxFit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hanes Sport Men's Performance Quarter T Shirt",
                    style: AppStyles.mainHeadingTextStyle(context).copyWith(
                        fontFamily: AppFonts.SF_PRO_SEMIBOLD,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.subtitle1.color,
                        fontSize: 11.0.sp),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  ReadMoreText(
                    "This is dummy copy. It is not meant to be read. It has been placed here solely to demonstrate the look and feel of finished, typeset text.",
                    trimCollapsedText: AppStrings.READ_MORE,
                    trimExpandedText: AppStrings.READ_LESS,
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    moreStyle: TextStyle(
                        fontSize: 10.0.sp,
                        color: AppColors.SUBHEADING_COLOR_2,
                        fontFamily: AppFonts.SF_PRO_FONT_REGULAR,
                        fontWeight: FontWeight.w500),
                    lessStyle: TextStyle(
                        fontSize: 10.0.sp,
                        color: AppColors.SUBHEADING_COLOR_2,
                        fontFamily: AppFonts.SF_PRO_FONT_REGULAR,
                        fontWeight: FontWeight.w500),
                    style: AppStyles.blackWithDifferentFontTextStyle(
                        context, 10.0.sp)
                        .copyWith(color: AppColors.SUBHEADING_COLOR_2),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$18.71",
                        style: AppStyles.mainHeadingTextStyle(context).copyWith(
                            fontFamily: AppFonts.SF_PRO_FONT_BOLD,
                            color: AppColors.ACCENT_COLOR,
                            fontSize: 14.0.sp),
                      ),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 14.0,
                            color: AppColors.APP_GREY_TEXT_COLOR,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Qty:',
                                style: AppStyles.blackWithSemiBoldFontTextStyle(
                                    context, 13.0)
                                    .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.SUBHEADING_COLOR_2)),
                            TextSpan(
                                text: ' ',
                                style: AppStyles.blackWithSemiBoldFontTextStyle(
                                    context, 13.0)),
                            TextSpan(
                                text: '100',
                                style: AppStyles.blackWithSemiBoldFontTextStyle(
                                    context, 13.0)
                                    .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .color)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    children: [
                      Text(
                        "Size:",
                        style: AppStyles.blackWithDifferentFontTextStyle(
                            context, 11.0.sp)
                            .copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.SUBHEADING_COLOR_2),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 2.5, 0, 0),
                        child: Text(
                          "Medium",
                          style: AppStyles.mainHeadingTextStyle(context).copyWith(
                              fontFamily: AppFonts.SF_PRO_SEMIBOLD,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).textTheme.subtitle1.color,
                              fontSize: 11.0.sp),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                ],
              ),
            )
          ],
        ),
      ),

      isLast ? Container() : divider(),
    ],
  );
}

Widget orderHistoryItem(BuildContext context, String status) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "07 Nov, 2020",
              style: AppStyles.blackWithSemiBoldFontTextStyle(context, 12.0.sp)
                  .copyWith(
                  fontWeight: FontWeight.w800,
                  fontFamily: AppFonts.SF_PRO_FONT_BOLD),
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
                  child: Text(
                    "\$450",
                    style: AppStyles.blackWithSemiBoldFontTextStyle(
                        context, 12.0.sp)
                        .copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.APP__DETAILS_TEXT_COLOR),
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.APP__DETAILS_TEXT_COLOR,
                  size: 17.0,
                )
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 14.0,
                  color: AppColors.APP_GREY_TEXT_COLOR,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Order ID:',
                      style: AppStyles.blackWithSemiBoldFontTextStyle(
                          context, 13.0)
                          .copyWith(
                          fontWeight: FontWeight.w500,
                          color:
                          Theme.of(context).textTheme.subtitle1.color)),
                  TextSpan(
                      text: ' ',
                      style: AppStyles.blackWithSemiBoldFontTextStyle(
                          context, 13.0)),
                  TextSpan(
                      text: '1234ABCD',
                      style: AppStyles.blackWithSemiBoldFontTextStyle(
                          context, 13.0)
                          .copyWith(
                          fontWeight: FontWeight.w500,
                          color:
                          Theme.of(context).textTheme.subtitle1.color)),
                ],
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.PROCESSING_COLOR.withOpacity(0.9),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0),
                child: Text(
                  status,
                  style: AppStyles.detailWithSmallTextSizeTextStyle().copyWith(
                      color: AppColors.PROCESSING_TXT_COLOR,
                      fontWeight: FontWeight.w500),
                ),
              ),
            )
          ],
        )
      ],
    ),
  );
}

Widget storeItem(BuildContext context, bool isCheckout) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              padding: EdgeInsets.fromLTRB(10, 8, 0, 0),
              child: Text("Nike",
                  style:
                      AppStyles.blackWithSemiBoldFontTextStyle(context, 15.0.sp)
                          .copyWith(fontWeight: FontWeight.w500))),
          isCheckout
              ? Container()
              : InkWell(
                  onTap: () {
                    showCustomDialog(context, "Contact Seller", "Write your views");
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 8, 10, 0),
                    child: Text(
                      "Contact Seller",
                      style: AppStyles.blackWithSemiBoldFontTextStyle(
                              context, 12.0.sp)
                          .copyWith(
                              fontWeight: FontWeight.w500, color: Colors.green),
                    ),
                  ),
                )
        ],
      ),
      Divider(
        color: AppColors.LIGHT_GREY_ARROW_COLOR,
      )
    ],
  );
}

Widget divider(){
  return Divider(
    color: AppColors.DIVIDER_COLOR,
    height: 1.0,
    thickness: 0.5,
  );
}

void showCustomDialog(BuildContext context, String title, String hint){
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Color(0xFFF7F7F7),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)),
          //this right here
          child: Container(
            width: 250,
            height: 200,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                  EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    crossAxisAlignment:
                    CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: AppStyles
                              .detailWithSmallTextSizeTextStyle()
                              .copyWith(
                              color: AppColors
                                  .APP_PRIMARY_COLOR,
                              fontSize: 12.0.sp,
                              fontWeight:
                              FontWeight.w400),
                        ),
                      ),
                      Text(
                        title,
                        style: AppStyles
                            .detailWithSmallTextSizeTextStyle()
                            .copyWith(
                            fontSize: 12.0.sp,
                            color: Theme.of(context)
                                .textTheme
                                .headline1
                                .color,
                            fontWeight:
                            FontWeight.w600),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Done",
                          style: AppStyles
                              .detailWithSmallTextSizeTextStyle()
                              .copyWith(
                              fontSize: 12.0.sp,
                              color: AppColors
                                  .ACCENT_COLOR,
                              fontWeight:
                              FontWeight.w500),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  color: AppColors.DIVIDER_COLOR_LIGHT,
                ),
                Container(
                  padding:
                  EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLength: 150,
                    maxLines: 5,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hint),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

Widget genderItem(BuildContext bc, String name, Function onTap) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new ListTile(
          title: new Text(
            name,
            style: AppStyles.blackWithDifferentFontTextStyle(bc, 11.0.sp).copyWith(color: AppColors.APP_GREY_TEXT_COLOR),
          ),
          onTap: onTap
        ),
        divider(),
      ],
    ),
  );
}

Widget handicapItem(BuildContext bc, String name, Function onTap) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new ListTile(
          title: new Text(
            name,
          ),
          onTap: onTap
        ),
        divider(),
      ],
    ),
  );
}

