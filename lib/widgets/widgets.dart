import 'dart:async';

import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_fonts.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/widgets/button_border.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

import 'Skeleton.dart';
import 'gradient_button.dart';

//Widget NotificationTileView(
//    {BuildContext context, Reviews data, bool hasTopDivider = true}) {
//  return Column(
//    children: [
//      SizedBox(
//        height: 10.0,
//      ),
//
//      hasTopDivider ? divider() : Container(),
//
//      hasTopDivider
//          ? SizedBox(
//              height: 10.0,
//            )
//          : Container(),
//
//      InkWell(
//        onTap: () {},
//        child: Padding(
//          padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
////          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
//          child: Row(
//            children: [
//              circularAvatar(55.0, 55.0, data.image, 30.0),
//              SizedBox(
//                width: 10.0,
//              ),
//              Flexible(
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: [
//                    Text(data.name,
//                        style:
//                            AppStyles.blackWithBoldFontTextStyle(context, 15.0)
//                                .copyWith(color: AppColors.COLOR_BLACK)
//                                .copyWith(fontWeight: FontWeight.w600)),
//                    SizedBox(
//                      height: 5.0,
//                    ),
//                    Row(
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      children: [
////                        Icon(
////                          Icons.star,
////                          size: 14.0,
////                          color: AppColors.COLOR_GREEN_RATING,// add custom icons also
////                        ),
//
//                        Icon(
//                          FontAwesomeIcons.solidStar,
//                          color: AppColors.GREEN_BRIGHT_COLOR,
//                          size: 10.0,
//                        ),
//
//                        SizedBox(
//                          width: 3.0,
//                        ),
//
//                        Padding(
//                          padding: const EdgeInsets.only(left: 5.0),
//                          child: Text(
//                            data.rating.toString(),
//                            style: AppStyles.blackWithBoldFontTextStyle(
//                                    context, 13.0)
//                                .copyWith(color: AppColors.COLOR_GREEN_RATING),
//                          ),
//                        )
//                      ],
//                    ),
//                  ],
//                ),
//              ),
//            ],
//          ),
//        ),
//      ),
//
////      Padding(
////        padding: EdgeInsets.symmetric(horizontal: 0.0,),
////        child: Text(
////          data.description,
////          style: AppStyles.blackWithDifferentFontTextStyle(context, 12.0).copyWith(color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
////        ),
////      ),
//
//      ReadMoreText(
//        data.description,
//        // "This is dummy copy. It is not meant to be read. It has been placed here solely to demonstrate the look and feel of finished, typeset text. It is not meant to be read. It has been placed here solely to demonstrate the look and feel of finished, typeset text.",
//        trimCollapsedText: AppStrings.READ_MORE,
//        trimExpandedText: AppStrings.READ_LESS,
//        trimLines: 2,
//        textAlign: TextAlign.start,
//        trimMode: TrimMode.Line,
////        delimiter: ".",
//        style: AppStyles.blackWithDifferentFontTextStyle(context, 10.0.sp)
//            .copyWith(color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
//      ),
//
//      SizedBox(
//        height: 10.0,
//      ),
//    ],
//  );
//}

Widget searchTextField({BuildContext context}) {
  return TextFormField(
    style: AppStyles.blackWithDifferentFontTextStyle(context, 12.0),
    obscureText: false,
    textInputAction: TextInputAction.done,
    keyboardType: TextInputType.visiblePassword,
    decoration: AppStyles.decorationWithLeadingEdgeIcon(
        context, "Search", Icons.search),
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

showBottomSheetWidgetWithAnimatedBtn(
    BuildContext context,
    String title,
    String desc,
    Widget widget,widget2,

    Function onTapResend,
    ValueChanged<BuildContext> onTap,
    String btnText,
    bool showResendBtn,
    ) {
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: AppColors.WHITE_COLOR,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(30.0),topLeft: Radius.circular(30.0)),
      ),
      context: context,
      builder: (BuildContext bc) {
        onTap(bc);
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter state) {
                return SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        SvgPicture.asset(
                          AppImages.BOTTOM_SHEET,
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        Text(
                          title,
                          style:
                          AppStyles.blackWithBoldFontTextStyle(context, 20.0),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25.0,
                              ),
                              child: GestureDetector(
                                onTap: () {},
                                child: Text(
                                  desc,
                                  textAlign: TextAlign.center,
                                  style:
                                  AppStyles.detailWithSmallTextSizeTextStyle()
                                      .copyWith(fontSize: 12.0),
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 25.0,
                        ),
                        widget,
                        SizedBox(
                          height: 25.0,
                        ),
                        widget2,

                        showResendBtn
                            ? Container(
                          margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(AppStrings.DIDNT_RECEIVE,
                                  style: AppStyles
                                      .detailWithSmallTextSizeTextStyle()
                                      .copyWith(fontSize: 12)),
                              SizedBox(
                                width: 2.0,
                              ),
                              InkWell(
                                onTap: onTapResend,
                                child: Text(AppStrings.RESEND,
                                    style: AppStyles
                                        .detailWithSmallTextSizeTextStyle()
                                        .copyWith(fontSize: 12)
                                        .copyWith(
                                        color: AppColors.BLUE_COLOR)),
                              ),
                            ],
                          ),
                        )
                            : SizedBox(
                          height: 50.0,
                        ),
                      ],
                    ),
                  ),
                );
              }),
        );
      });
}
showBottomSheetWidget(
    BuildContext context,
    String title,
    String desc,
    Widget widget,
    Function onResendTap,
    ValueChanged<BuildContext> onTap,
    String btnText,
    bool showResendBtn) {
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: AppColors.WHITE_COLOR,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(30.0),topLeft: Radius.circular(30.0)),
      ),
      context: context,
      builder: (BuildContext bc) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter state) {
            return SingleChildScrollView(
              child: InkWell(
                  child: Container(
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    SvgPicture.asset(
                      AppImages.BOTTOM_SHEET,
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Text(
                      title,
                      style:
                          AppStyles.blackWithBoldFontTextStyle(context, 20.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25.0,
                          ),
                          child: GestureDetector(
                            onTap: () {},
                            child: Text(
                              desc,
                              textAlign: TextAlign.center,
                              style:
                                  AppStyles.detailWithSmallTextSizeTextStyle()
                                      .copyWith(fontSize: 12.0),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 25.0,
                    ),
                    widget,
                    SizedBox(
                      height: 25.0,
                    ),
                    GradientButton(
                      onTap: () {
                        onTap(bc);
                      },
                      text: btnText,
                    ),

                    showResendBtn
                        ? Container(
                            margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(AppStrings.DIDNT_RECEIVE,
                                    style: AppStyles
                                            .detailWithSmallTextSizeTextStyle()
                                        .copyWith(fontSize: 12)),
                                SizedBox(
                                  width: 2.0,
                                ),
                                InkWell(
                                  onTap: onResendTap,
                                  child: Text(AppStrings.RESEND,
                                      style: AppStyles
                                              .detailWithSmallTextSizeTextStyle()
                                          .copyWith(fontSize: 12)
                                          .copyWith(
                                              color: AppColors.BLUE_COLOR)),
                                ),
                              ],
                            ),
                          )
                        : SizedBox(
                            height: 50.0,
                          ),
                  ],
                ),
              )),
            );
          }),
        );
      });
}

showProfilePhotoBottomSheetWidget(
  BuildContext context,
  String title,
  String desc,
  Widget widget,
  ValueChanged<BuildContext> onTap,
) {
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: AppColors.WHITE_COLOR,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(30.0),topLeft: Radius.circular(30.0)),
      ),
      context: context,
      builder: (BuildContext bc) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter state) {
            return SingleChildScrollView(
              child: InkWell(
                  child: Container(
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    SvgPicture.asset(
                      AppImages.BOTTOM_SHEET,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      title,
                      style:
                          AppStyles.blackWithBoldFontTextStyle(context, 20.0),
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25.0,
                          ),
                          child: GestureDetector(
                            onTap: () {},
                            child: Text(
                              desc,
                              textAlign: TextAlign.center,
                              style:
                                  AppStyles.detailWithSmallTextSizeTextStyle()
                                      .copyWith(fontSize: 12.0),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 10.0,
                    ),
                    widget,
                    SizedBox(
                      height: 25.0,
                    ),
                  ],
                ),
              )),
            );
          }),
        );
      });
}

showiOSBirthdayDatePicker(BuildContext context, bool isAllowFutureDates,
    bool isAllowPastDates, Function onConfirm) {
  DatePicker.showDatePicker(context,
      showTitleActions: true,
      theme: DatePickerTheme(
        backgroundColor: Theme.of(context).backgroundColor,
        cancelStyle: TextStyle(color: Colors.grey),
        itemStyle: TextStyle(
            color: Theme.of(context).appBarTheme.textTheme.headline1.color),
        //  containerHeight: 20.0.h,
      ),
      minTime: DateTime(1920, 1, 1),
      maxTime: DateTime.now().subtract(Duration(days: 4380)),
      onChanged: (date) {
    print('change $date');
  }, onConfirm: onConfirm, currentTime: DateTime.now(), locale: LocaleType.en);
}

showiOSDatePicker(BuildContext context, bool isAllowFutureDates,
    bool isAllowPastDates, Function onConfirm) {
  DatePicker.showDatePicker(context,
      showTitleActions: true,
      theme: DatePickerTheme(
        backgroundColor: Theme.of(context).backgroundColor,
        cancelStyle: TextStyle(color: Colors.grey),
        itemStyle: TextStyle(
            color: Theme.of(context).appBarTheme.textTheme.headline1.color),
        //  containerHeight: 20.0.h,
      ),
      // minTime: isAllowPastDates ? DateTime(1920, 1, 1) : DateTime.now(),
      minTime: DateTime.now(),
      // maxTime: isAllowFutureDates ? DateTime(DateTime.now().year, 12, 31) : DateTime.now(), onChanged: (date) {
      maxTime: DateTime(DateTime.now().year, 12, 31).add(Duration(days: 1825)),
      onChanged: (date) {
    print('change $date');
  }, onConfirm: onConfirm, currentTime: DateTime.now(), locale: LocaleType.en);
}

cupertinoTimePicker(BuildContext context, Function onConfirm) {
  DatePicker.showTime12hPicker(context,
      theme: DatePickerTheme(
        backgroundColor: Theme.of(context).backgroundColor,
        cancelStyle: TextStyle(color: Colors.grey),
        itemStyle: TextStyle(
            color: Theme.of(context).appBarTheme.textTheme.headline1.color),
        //  containerHeight: 20.0.h,
      ),
      showTitleActions: true, onChanged: (date) {
    print(
        'change $date in time zone ' + date.timeZoneOffset.inHours.toString());
  }, onConfirm: onConfirm, currentTime: DateTime.now());
}

Widget searchTextFieldTeeTimes(
    {String hintText,
    FocusNode focusNode,
    BuildContext context,
    bool enabled,
    TextEditingController controller,
    Function onSearch,
    Function onChange}) {
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
    decoration: AppStyles.decorationWithLeadingEdgeIconTeeTimes(
        context, hintText, Icons.search),
  );
}

Widget productTile(
    {BuildContext context,
    String imageUrl,
    String productName,
    String productPrice,
    String productBrand,
    bool isMyProducts,
    Function onProductTap,
    Function onMenuOptionTap}) {
  return GestureDetector(
    onTap: onProductTap,
    child: Container(
      width: 160.0,
      height: 240.0,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: 160.0,
                height: 180.0,
                decoration: BoxDecoration(
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey.withOpacity(0.5),
                  //     spreadRadius: 5,
                  //     blurRadius: 7,
                  //     offset: Offset(0, 1), // changes position of shadow
                  //   ),
                  // ],
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0xFFF2F1F1),
                ),
                child: ClipRRect(
                  //networkCacheImageWithShimmerWithHeightWidth
                  borderRadius: BorderRadius.circular(10.0),
                  child: networkCacheImageWithShimmerWithHeightWidth(
                      width: 160.0,
                      height: 180.0,
                      // imagePath: "https://www.pngkit.com/png/full/89-896353_ladies-jacket-png-image-with-transparent-background-women.png",
                      imagePath: imageUrl,
                      boxFit: BoxFit.cover),
                ),
              ),
              isMyProducts
                  ? Positioned(
                      top: 5.0,
                      right: 10.0,
                      child: InkWell(
                        onTap: onMenuOptionTap,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Transform.rotate(
                            angle: 90 * pi / 180,
                            child: Container(
                              width: 30.0,
                              height: 30.0,
                              padding: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                AppImages.IC_MENU_OPTIONS,
                                width: 15.0,
                                height: 15.0,
                                color: Colors.black,
                                matchTextDirection: true,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Flexible(
              child: Text(
            productName,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.subHeadingsTextStyle(context, 11.0.sp),
          )),
          SizedBox(
            height: 3.0,
          ),
          Text(
            productBrand,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.detailTextStyle(fontSize: 10.0.sp)
                .copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 3.0,
          ),
          Text(
            productPrice,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.detailTextStyle(fontSize: 10.0.sp)
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
  );
}

Widget mostSellingTile(
    {BuildContext context,
    String imageUrl,
    String productName,
    String productPrice,
    String productBrand,
    Function onProductTap}) {
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
            child: ClipRRect(
              //networkCacheImageWithShimmerWithHeightWidth
              borderRadius: BorderRadius.circular(10.0),
              child: networkCacheImageWithShimmerWithHeightWidth(
                  width: 120.0,
                  height: 150.0,
                  // imagePath: "https://www.pngkit.com/png/full/89-896353_ladies-jacket-png-image-with-transparent-background-women.png",
                  imagePath: imageUrl,
                  boxFit: BoxFit.cover),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Flexible(
              child: Text(
            productName,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.subHeadingsTextStyle(context, 11.0.sp),
          )),
          SizedBox(
            height: 3.0,
          ),
          Text(
            productBrand,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.detailTextStyle(fontSize: 10.0.sp)
                .copyWith(fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 3.0,
          ),
          Text(
            productPrice,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.detailTextStyle(fontSize: 10.0.sp)
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
  );
}

Widget networkCacheImageWithShimmer({String imagePath}) {
  return CachedNetworkImage(
    imageUrl: imagePath,
    fit: BoxFit.cover,
    // fadeInCurve: Curves.easeIn,
    imageBuilder: (BuildContext context, ImageProvider<dynamic> imageProvider) {
      return Image(
        // width: constraints.maxWidth,
        image: imageProvider,
        fit: BoxFit.cover,
      );
    },
    placeholder: (context, url) => Skeleton(),
    errorWidget: (context, url, error) {
      return Image.asset(AppImages.NO_IMAGE_PLACEHOLDER);
    },
  );
}

Widget networkCacheImageWithShimmerWithFixedSkeleton(
    {String imagePath, BoxFit boxFit}) {
  return CachedNetworkImage(
    // height: height,
    // width: width,
    imageUrl: imagePath,
    fit: boxFit,
    // fadeInCurve: Curves.easeIn,
    imageBuilder: (BuildContext context, ImageProvider<dynamic> imageProvider) {
      return Image(
        // width: constraints.maxWidth,
        image: imageProvider,
        fit: boxFit,
      );
    },
    placeholder: (context, url) =>
        Container(height: 200.0, width: double.maxFinite, child: Skeleton()),
    errorWidget: (context, url, error) {
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

Widget networkCacheImageWithShimmerWithHeightWidth(
    {String imagePath, double height, double width, BoxFit boxFit}) {
  return CachedNetworkImage(
    height: height,
    width: width,
    imageUrl: imagePath,
    fit: boxFit,
    // fadeInCurve: Curves.easeIn,
    imageBuilder: (BuildContext context, ImageProvider<dynamic> imageProvider) {
      return Image(
        // width: constraints.maxWidth,
        image: imageProvider,
        fit: boxFit,
      );
    },
    placeholder: (context, url) => Skeleton(),
    errorWidget: (context, url, error) {
      return errorImageWidget(
        height: height,
        width: width,
        boxFit: boxFit,
      );
    },
  );
}

Widget errorImageWidget({double height, double width, BoxFit boxFit}) {
  return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Image.asset(
        AppImages.NO_IMAGE_PLACEHOLDER,
        width: width,
        height: height,
        fit: boxFit,
      ));
}

Widget circularNetworkCacheImageWithShimmerWithHeightWidth(
    {String imagePath, double radius, BoxFit boxFit}) {
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
          imageBuilder:
              (BuildContext context, ImageProvider<dynamic> imageProvider) {
            return Image(
              height: radius,
              width: radius,
              // width: constraints.maxWidth,
              image: imageProvider,
              fit: boxFit,
            );
          },
          placeholder: (context, url) => Skeleton(),
          errorWidget: (context, url, error) {
            return Image.asset(AppImages.NO_IMAGE_PLACEHOLDER);
          },
          // placeholder: (context, url) {return Image.asset(AppImages.NO_IMAGE_PLACEHOLDER); },
        ),
      ),
    ),
  );
}

Widget button({String title, BuildContext context, Function onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
        padding: const EdgeInsets.all(15.0),
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
            style: AppStyles.inputTextStyleWithPoppinsBold()
                .copyWith(letterSpacing: 0.3),
          ),
        )),
  );
}

Widget buttonWithColor(
    {String title, Color color, BuildContext context, Function onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
        padding: const EdgeInsets.all(15.0),
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
            style: AppStyles.inputTextStyleWithPoppinsBold()
                .copyWith(letterSpacing: 0.3),
          ),
        )),
  );
}

Widget reviewItem(
  BuildContext context,
) {
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
                          imageUrl:
                              "https://expertphotography.com/wp-content/uploads/2020/08/social-media-profile-photos-3.jpg",
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
                      padding:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
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
                  style:
                      AppStyles.blackWithDifferentFontTextStyle(context, 9.0.sp)
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

cupertinoModalPopupDialog(
    BuildContext context, String title, String body, Function onPressed) {
  var alert = new CupertinoAlertDialog(
    // barrierDismissible: false,
    title: new Text(title),
    content: Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: new Text(body),
    ),
    actions: <Widget>[
      new CupertinoDialogAction(
          child: const Text('OK'), isDefaultAction: true, onPressed: onPressed),
    ],
  );
  showDialog(context: context, child: alert, barrierDismissible: false);
}

Widget circularAvatar(
    double width, double height, String img_url, double radius) {
  return CircleAvatar(
    radius: radius,
    backgroundColor: Colors.transparent,
    child: ClipOval(
      child: CachedNetworkImage(
        width: width,
        height: height,
        imageUrl: img_url,
        fit: BoxFit.cover,
        // fadeInCurve: Curves.easeIn,
        imageBuilder:
            (BuildContext context, ImageProvider<dynamic> imageProvider) {
          return Image(
            // width: constraints.maxWidth,
            image: imageProvider,
            fit: BoxFit.cover,
          );
        },
        placeholder: (context, url) => Skeleton(),
        errorWidget: (context, url, error) {
          return Image.asset(AppImages.NO_IMAGE_PLACEHOLDER);
        },
      ),
    ),
  );
}

Widget circularAvatarWithBoxFit(
    double width, double height, String img_url, double radius, BoxFit boxFit) {
  return CircleAvatar(
    radius: radius,
    backgroundColor: Colors.transparent,
    child: ClipOval(
      child: CachedNetworkImage(
        width: width,
        height: height,
        imageUrl: img_url,
        fit: boxFit,
        // fadeInCurve: Curves.easeIn,
        imageBuilder:
            (BuildContext context, ImageProvider<dynamic> imageProvider) {
          return Image(
            // width: constraints.maxWidth,
            image: imageProvider,
            fit: boxFit,
          );
        },
        placeholder: (context, url) => Skeleton(),
        errorWidget: (context, url, error) {
          return Image.asset(AppImages.NO_IMAGE_PLACEHOLDER);
        },
      ),
    ),
  );
}

Widget teeTimesItem(BuildContext context) {
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
              circularAvatar(
                  45.0,
                  45.0,
                  "https://cdn.fastly.picmonkey.com/contentful/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=800&q=70",
                  20.0),
              SizedBox(
                width: 8.0,
              ),
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

Widget appBar(
    {BuildContext context,
    String title,
    Function onBackClick,
    Function onActionClick,
    Color iconColor,
    bool showCloseIcon,
    bool hasLeading = true,
    bool showAction = false,
    bool showActionIcon = false,
    String actionText}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    title: new Text(
      title,
      style: AppStyles.blackWithBoldFontTextStyle(context, 20.0)
          .copyWith(fontWeight: FontWeight.w600),
    ),
    leading: hasLeading
        ? showCloseIcon?Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: GestureDetector(
        onTap: () {
          onBackClick();
        },
        child: Transform.rotate(
          angle: 180 * pi / 180,
          child: Icon(
            Icons.clear,
            size: 32.0,
            color: iconColor, // add custom icons also
          ),
        ),
      ),
    ):Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: GestureDetector(
              onTap: () {
                onBackClick();
              },
              child: Transform.rotate(
                angle: 180 * pi / 180,
                child: Icon(
                  Icons.arrow_right_alt,
                  size: 32.0,
                  color: iconColor, // add custom icons also
                ),
              ),
            ),
          )
        : Container(),
    actions: <Widget>[

      showActionIcon
          ? Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              margin: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: SvgPicture.asset(
                  AppImages.NOTIFICATION,
                ),
                onTap: (){
                  onActionClick();
                },
              ),
            ),
          )
          : Container(),
      showAction
          ? Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                  onTap: () {
                    onActionClick();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top:20.0),
                    child: Text(
                      actionText,
                      style: AppStyles.blackWithBoldFontTextStyle(context, 12.0)
                          .copyWith(fontWeight: FontWeight.w400).copyWith(color: AppColors.BLUE_COLOR),
                    ),
                  )))
          : Container()
    ],
  );
}

Widget appBarSearch1(
    {BuildContext context,
    bool isBackButton,
    String title,
    IconData icon,
    Function onBackClick}) {
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
    leading: !isBackButton
        ? null
        : IconButton(
            onPressed: onBackClick,
            icon: Icon(
              icon,
              color: Theme.of(context).appBarTheme.iconTheme.color,
              size: 30.0,
            ),
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

Widget appBarSearch(
    {BuildContext context,
    bool isBackButton,
    String title,
    IconData icon,
    Function onBackClick}) {
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
    leading: !isBackButton
        ? null
        : IconButton(
            onPressed: onBackClick,
            icon: Icon(
              icon,
              color: Theme.of(context).appBarTheme.iconTheme.color,
              size: 30.0,
            ),
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
                          style: AppStyles.mainHeadingTextStyle(context)
                              .copyWith(
                                  fontFamily: AppFonts.SF_PRO_SEMIBOLD,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .color,
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

Widget divider() {
  return Divider(
    color: AppColors.DIVIDER_COLOR,
    height: 1.0,
    thickness: 0.5,
  );
}

void showCustomDialog(BuildContext context, String title, String btn1Title,
    String btn2Title, bool showImage, SvgPicture image) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Color(0xFFFFFFFFF),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          //this right here
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .13),
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                  child: Text(
                    title,
                    style:
                        AppStyles.blackWithSemiBoldFontTextStyle(context, 18.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                showImage
                    ? Container(
                        height: 10.0.h,
                        margin: EdgeInsets.fromLTRB(0.0, 40.0, 0, 30),
                        child: Center(
                          child: image,
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 35.0,
                ),
                GradientButton(
                  onTap: () {},
                  text: btn1Title,
                ),
                SizedBox(
                  height: 20.0,
                ),
                ButtonBorder(
                  onTap: () {},
                  text: btn2Title,
                ),
                SizedBox(
                  height: 45.0,
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
              style: AppStyles.blackWithDifferentFontTextStyle(bc, 11.0.sp)
                  .copyWith(color: AppColors.APP_GREY_TEXT_COLOR),
            ),
            onTap: onTap),
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
            onTap: onTap),
        divider(),
      ],
    ),
  );
}
