import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'app_colors.dart';
import 'app_constants.dart';
import 'app_fonts.dart';
import 'package:sizer/sizer.dart';

/// App Styles Class -> Resource class for storing app level styles constants
class AppStyles {

//  static TextStyle mainHeadingTextStyle(BuildContext context){
//    return TextStyle(
//        color: Theme.of(context).textTheme.headline1.color,
//        fontSize: AppTextSizes.MAIN_HEADING_SIZE,
//        fontFamily: AppFonts.PLAY_FAIR_DISPLAY_BOLD,
//        fontWeight: FontWeight.w700);
//  }
//

  static TextStyle unselectedTabTextStyle(){
    return TextStyle(
      fontSize: 13.0.sp,
      color: AppColors.UNSELECTED_COLOR,
      fontFamily: AppFonts.POPPINS,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle staticLabelsTextStyle(BuildContext context) {
    return AppStyles.blackWithSemiBoldFontTextStyle(context, 13.0.sp).copyWith(
        fontWeight: FontWeight.w400, color: AppColors.APP_TEXT2_COLOR);
  }

  static TextStyle selectedTabTextStyle(){
    return TextStyle(
      fontSize: 13.0.sp,
      color: AppColors.ACCENT_COLOR,
      fontFamily: AppFonts.POPPINS,
      fontWeight: FontWeight.w600,
    );
  }


  static TextStyle blackWithSemiBoldFontTextStyle(
      BuildContext context, double fontSize) {
    return TextStyle(
      color: Theme.of(context).appBarTheme.textTheme.headline1.color,
      fontSize: fontSize,
      fontFamily: AppFonts.POPPINS,
      fontWeight: FontWeight.w400,
    );
  }


  static TextStyle inputHintStyle(BuildContext context) {
    return TextStyle(
        color: AppColors.APP_TEXT3_COLOR,
        fontSize: AppConstants.INPUT_TEXT_SIZE,
        fontFamily: AppFonts.POPPINS,
        fontWeight: Platform.isIOS ? FontWeight.w400 : FontWeight.w200);
    // fontWeight: FontWeight.w400);
  }

  static TextStyle inputTextStyle2(BuildContext context) {
    return TextStyle(
        color: AppColors.APP__DETAILS_TEXT_COLOR,
        fontSize: AppConstants.INPUT_TEXT_SIZE,
        fontFamily: AppFonts.POPPINS,
        fontWeight: Platform.isIOS ? FontWeight.w400 : FontWeight.w200);
    // fontWeight: FontWeight.w400);
  }

  static TextStyle detailWithSmallTextSizeTextStyle() {
    return TextStyle(
        fontSize: 14.0,
        color: AppColors.APP__DETAILS_TEXT_COLOR,
        height: 1.5,
        fontFamily: AppFonts.POPPINS,
        fontWeight: FontWeight.w400);
  }

  static TextStyle blackWithDifferentFontTextStyle(
      BuildContext context, double fontSize) {
    return TextStyle(
      color: Theme.of(context).appBarTheme.textTheme.headline1.color,
      fontSize: fontSize,
      fontFamily: AppFonts.SF_PRO_FONT_REGULAR,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle blackWithBoldFontTextStyle(
      BuildContext context, double fontSize) {
    return TextStyle(
      color: AppColors.COLOR_BLACK,
      fontSize: fontSize,
      fontFamily: AppFonts.POPPINS,
      fontWeight: FontWeight.w800,
    );
  }

  static RoundedRectangleBorder rounded_btn_fb = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
      side: BorderSide(color: AppColors.APP_FB_COLOR));

  static TextStyle mainHeadingTextStyle(BuildContext context) {
    return TextStyle(
        color: Theme.of(context).textTheme.headline1.color,
        fontSize: AppConstants.MAIN_HEADING_SIZE,
        fontFamily: AppFonts.SF_PRO_FONT_REGULAR,
        fontWeight: FontWeight.w700);
  }

  static RoundedRectangleBorder rounded_btn_transparent_white =
      RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: BorderSide(color: Colors.white));

  static TextStyle bottomTabTextStyle({bool isSelected}) {
    return TextStyle(
      color: isSelected
          ? AppColors.APP_SELECTED_TEXT_COLOR
          : AppColors.APP_UN_SELECTED_TEXT_COLOR,
      fontSize: 12.0,
      fontFamily: AppFonts.CERA_PRO_MEDIUM,
    );
  }

  static TextStyle appBarTitleTextStyle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).appBarTheme.textTheme.headline1.color,
      fontSize: 18.0,
      fontFamily: AppFonts.POPPINS,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle inputTextStyle(BuildContext context) {
    return TextStyle(
        color: AppColors.LIGHT_GREY_TEXT_COLOR,
        fontSize: AppConstants.INPUT_TEXT_SIZE,
        fontFamily: AppFonts.POPPINS,
        fontWeight: Platform.isIOS ? FontWeight.w400 : FontWeight.w200);
    // fontWeight: FontWeight.w400);
  }

  static TextStyle inputTextStyleWithPoppinsMedim() {
    return TextStyle(
        color: AppColors.WHITE_COLOR,
        fontSize: AppConstants.INPUT_TEXT_SIZE,
        fontFamily: AppFonts.POPPINS,
        fontWeight: FontWeight.w200);
  }

  static TextStyle detailTextStyle({double fontSize}) {
    return TextStyle(
        fontSize: fontSize,
        color: AppColors.APP__DETAILS_TEXT_COLOR,
        fontFamily: AppFonts.POPPINS,
        fontWeight: FontWeight.w400);
  }

  static TextStyle detailBoldTextStyle({double fontSize}) {
    return TextStyle(
        fontSize: fontSize,
        color: AppColors.APP_TEXT_COLOR2,
        fontFamily: AppFonts.POPPINS,
        fontWeight: FontWeight.w800);
  }

  static TextStyle subHeadingsTextStyle(BuildContext context, double fontSize) {
    return TextStyle(
        fontSize: fontSize,
        color: Theme.of(context).textTheme.headline1.color,
        fontFamily: AppFonts.POPPINS,
        fontWeight: FontWeight.w600);
  }

  static TextStyle subHeadingsAccentColorTextStyle({double fontSize}) {
    return TextStyle(
        fontSize: fontSize,
        color: AppColors.ACCENT_COLOR,
        fontFamily: AppFonts.POPPINS,
        fontWeight: FontWeight.w200);
  }

  static TextStyle smallTextAccentColorTextStyle({double fontSize}) {
    return TextStyle(
        fontSize: fontSize,
        color: AppColors.ACCENT_COLOR,
        fontFamily: AppFonts.POPPINS,
        fontWeight: FontWeight.w200);
  }

  static TextStyle detailTextStyleWithDarkColor({double fontSize}) {
    return TextStyle(
        fontSize: fontSize,
        color: AppColors.APP_TEXT_COLOR2,
        fontFamily: AppFonts.POPPINS,
        fontWeight: FontWeight.w200);
  }

  static TextStyle poppinsTextStyle({double fontSize, FontWeight weight}){
    return TextStyle(
        fontSize: fontSize,
        color: Colors.white,
        fontFamily: AppFonts.POPPINS,
        fontWeight: weight
    );
  }

  static TextStyle inputTextStyleWithPoppinsBold() {
    return TextStyle(
        color: AppColors.WHITE_COLOR,
        fontSize: 14.0,
        fontFamily: AppFonts.POPPINS,
        fontWeight: FontWeight.w600);
  }

  static TextStyle mainHeadingsTextStyle({double fontSize}) {
    return TextStyle(
        fontSize: fontSize,
        color: Colors.black,
        fontFamily: AppFonts.POPPINS,
        fontWeight: FontWeight.w800);
  }

//
//  static TextStyle detailItalicTextStyle(){
//    return TextStyle(
//        fontSize: AppTextSizes.SMALL_TEXT_SIZE,
//        color: AppColors.APP__DETAILS_TEXT_COLOR,
//        fontFamily: AppFonts.SF_PRO_FONT_REGULAR,
//        fontWeight: FontWeight.w400,
//        fontStyle: FontStyle.italic
//    );
//  }
//
//  static InputDecoration decoration(String title) {
//    return InputDecoration(
//      focusedBorder: OutlineInputBorder(
//        borderRadius: BorderRadius.circular(5.0),
//        borderSide:
//        const BorderSide(color: AppColors.ACCENT_COLOR, width: 1.0),
//      ),
//      hintText: title,
//      labelText: title,
//      alignLabelWithHint: true,
//      labelStyle: TextStyle(
//          color: AppColors.APP_TEXT2_COLOR),
//      hintStyle: TextStyle(
//          fontSize: 17.0,
//          fontFamily: AppFonts.SF_PRO_FONT_REGULAR,
//          color: AppColors.APP_TEXT2_COLOR),
//      contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
//      enabledBorder: OutlineInputBorder(
//        borderRadius: BorderRadius.circular(5.0),
//        borderSide:
//        const BorderSide(color: AppColors.APP__DETAILS_TEXT_COLOR, width: 1.0),
//      ),
//    );
//  }
//

  static InputDecoration decorationWithLeadingEdgeIconTeeTimes(
      BuildContext context, String title, IconData iconData) {
    return InputDecoration(
      fillColor: Theme.of(context).backgroundColor,
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40.0),
        borderSide: const BorderSide(color: AppColors.ACCENT_COLOR, width: 1.0),
      ),
      prefixIcon: iconData != null
          ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                iconData,
                size: 18.0,
                color: AppColors.APP_GREY_TEXT_COLOR,
              ),
            )
          : null,
      // suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
      hintText: title,
      prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
      hintStyle: AppStyles.blackWithDifferentFontTextStyle(context, 13.0)
          .copyWith(color: AppColors.APP_GREY_TEXT_COLOR),
      contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40.0),
        borderSide:
            BorderSide(color: Theme.of(context).backgroundColor, width: 1.0),
      ),
    );
  }

  static InputDecoration decorationWithLeadingTrailingEdgeIconTeeTimes(
      BuildContext context,
      String title,
      IconData iconData1,
      IconData iconData2) {
    return InputDecoration(
      // fillColor: Theme.of(context).backgroundColor,
      fillColor: Theme.of(context).backgroundColor,
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40.0),
        borderSide: const BorderSide(color: AppColors.ACCENT_COLOR, width: 1.0),
      ),
      suffixIcon: iconData2 != null
          ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                iconData2,
                size: 18.0,
                color: AppColors.APP_GREY_TEXT_COLOR,
              ),
            )
          : null,
      prefixIcon: iconData1 != null
          ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                iconData1,
                size: 18.0,
                color: AppColors.APP_GREY_TEXT_COLOR,
              ),
            )
          : null,
      // suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
      hintText: title,
      prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
      hintStyle: AppStyles.blackWithDifferentFontTextStyle(context, 13.0)
          .copyWith(color: AppColors.APP_GREY_TEXT_COLOR),
      contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40.0),
        borderSide:
            BorderSide(color: Theme.of(context).backgroundColor, width: 1.0),
      ),
    );
  }

  static InputDecoration decorationPrice(String title) {
    String _currency =
        NumberFormat.compactSimpleCurrency(locale: 'en').currencySymbol;

    return InputDecoration(
      disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.DIVIDER_COLOR)),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.DIVIDER_COLOR)),
      hintText: title,
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.ACCENT_COLOR)),
      focusColor: AppColors.ACCENT_COLOR,
      labelText: title,
      prefix: Text('$_currency '),
      alignLabelWithHint: true,
      labelStyle: TextStyle(
          fontFamily: AppFonts.SF_PRO_FONT_REGULAR,
          fontWeight: FontWeight.w400,
          // fontSize: 15.0,
          color: AppColors.LIGHT_TEETIME_ICON_COLOR),
      hintStyle: TextStyle(
          fontSize: 17.0,
          fontFamily: AppFonts.SF_PRO_FONT_REGULAR,
          fontWeight: FontWeight.w400,
          color: AppColors.LIGHT_TEETIME_ICON_COLOR),
      contentPadding: EdgeInsets.fromLTRB(10.0, 15.0, 15.0, 10.0),

    );
  }

  static InputDecoration decorationWithBorder(String title) {
    return InputDecoration(
      /*labelText: title,
      alignLabelWithHint: true,*/
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(width: 0.5, color: AppColors.LIGHT_GREY_ARROW_COLOR)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(width: 0.5, color: AppColors.LIGHT_GREY_ARROW_COLOR)),
      hintText: title,
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(width: 0.5, color: AppColors.LIGHT_GREY_ARROW_COLOR)),
      hintStyle: TextStyle(
          fontSize: 17.0,
          fontFamily: AppFonts.POPPINS,
          fontWeight: FontWeight.w200,
          color: AppColors.LIGHT_GREY_TEXT_COLOR),
      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    );
  }

  static InputDecoration decoration(String title) {
    return InputDecoration(
      disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.DIVIDER_COLOR)),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.DIVIDER_COLOR)),
      hintText: title,
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.ACCENT_COLOR)),
      focusColor: AppColors.ACCENT_COLOR,
      labelText: title,
      alignLabelWithHint: true,
      labelStyle: TextStyle(
          fontFamily: AppFonts.SF_PRO_FONT_REGULAR,
          fontWeight: FontWeight.w400,
          // fontSize: 15.0,
          color: AppColors.LIGHT_TEETIME_ICON_COLOR),
      hintStyle: TextStyle(
          fontSize: 17.0,
          fontFamily: AppFonts.SF_PRO_FONT_REGULAR,
          fontWeight: FontWeight.w400,
          color: AppColors.LIGHT_TEETIME_ICON_COLOR),
      contentPadding: EdgeInsets.fromLTRB(10.0, 15.0, 15.0, 10.0),

    );
  }

  static InputDecoration decorationWithIcon(
      String title, IconData iconData, Function onPressed) {
    return InputDecoration(
      disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.DIVIDER_COLOR)),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.DIVIDER_COLOR)),
      suffixIcon: IconButton(
        onPressed: onPressed,
        icon: Icon(iconData),
        color: Colors.grey,
      ),
      hintText: title,
      labelText: title,
      alignLabelWithHint: true,
      labelStyle: TextStyle(
          fontFamily: AppFonts.SF_PRO_FONT_REGULAR,
          fontWeight: FontWeight.w400,
          color: AppColors.LIGHT_TEETIME_ICON_COLOR),
      hintStyle: TextStyle(
          fontSize: 17.0,
          fontFamily: AppFonts.SF_PRO_FONT_REGULAR,
          fontWeight: FontWeight.w400,
          color: AppColors.LIGHT_TEETIME_ICON_COLOR),
      contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 10.0),

    );
  }

  static InputDecoration decorationWithLeadingEdgeIcon1(
      BuildContext context, String title, IconData iconData) {
    return InputDecoration(
      fillColor: Theme.of(context).backgroundColor,
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
      prefixIcon: iconData != null
          ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                iconData,
                color: AppColors.APP_GREY_TEXT_COLOR,
              ),
            )
          : null,
      // suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
      hintText: title,
      prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
      hintStyle: AppStyles.blackWithDifferentFontTextStyle(context, 13.0)
          .copyWith(color: AppColors.APP_GREY_TEXT_COLOR),
      contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
    );
  }

  static InputDecoration decorationWithLeadingEdgeIcon(
      BuildContext context, String title, IconData iconData) {
    return InputDecoration(
      fillColor: Theme.of(context).backgroundColor,
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40.0),
        borderSide: const BorderSide(color: AppColors.ACCENT_COLOR, width: 1.0),
      ),
      prefixIcon: iconData != null
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: InkWell(
                child: Icon(
                  iconData,
                  color: AppColors.APP_GREY_TEXT_COLOR,
                ),
              ),
            )
          : null,
      // suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
      hintText: title,
      prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
      hintStyle: AppStyles.blackWithDifferentFontTextStyle(context, 13.0)
          .copyWith(color: AppColors.APP_GREY_TEXT_COLOR),
      contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(40.0),
        borderSide:
            BorderSide(color: Theme.of(context).backgroundColor, width: 1.0),
      ),
    );
  }

  // static InputDecoration decorationWithLeadingEdgeIconTeeTimes(
  //     BuildContext context, String title, IconData iconData) {
  //   return InputDecoration(
  //     fillColor: Theme.of(context).backgroundColor,
  //     filled: true,
  //     focusedBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(40.0),
  //       borderSide: const BorderSide(color: AppColors.ACCENT_COLOR, width: 1.0),
  //     ),
  //     prefixIcon: iconData != null ? Padding(
  //       padding: const EdgeInsets.all(10.0),
  //       child: Icon(
  //         iconData,
  //         size: 18.0,
  //         color: AppColors.APP_GREY_TEXT_COLOR,
  //       ),
  //     )
  //         : null,
  //     // suffixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
  //     hintText: title,
  //     prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
  //     hintStyle: AppStyles.blackWithDifferentFontTextStyle(context, 13.0).copyWith(color: AppColors.APP_GREY_TEXT_COLOR),
  //     contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
  //     enabledBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(40.0),
  //       borderSide:
  //       BorderSide(color: Theme.of(context).backgroundColor, width: 1.0),
  //     ),
  //   );
  // }

  static InputDecoration decorationWithTrailingIcon(
      String title, IconData iconData, Function onPressed) {
    return InputDecoration(
        fillColor: Colors.white,
        filled: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide:
              const BorderSide(color: AppColors.ACCENT_COLOR, width: 1.0),
        ),
        suffixIcon: IconButton(
          onPressed: onPressed,
          icon: Icon(iconData),
          color: Colors.grey,
        ),
        hintText: title,
        prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
        hintStyle: TextStyle(
            fontSize: 17.0,
            fontFamily: AppFonts.POPPINS,
            color: AppColors.APP_TEXT2_COLOR),
        labelText: title,
        alignLabelWithHint: true,
        labelStyle: TextStyle(
            fontFamily: AppFonts.POPPINS,
            color: AppColors.APP_TEXT2_COLOR),
        contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
              color: AppColors.APP__DETAILS_TEXT_COLOR, width: 1.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
              color: AppColors.APP__DETAILS_TEXT_COLOR, width: 1.0),
        ));
  }

  static InputDecoration textFieldDecoration(String title) {
    return InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide:
              const BorderSide(color: AppColors.ACCENT_COLOR, width: 1.0),
        ),
        hintText: title,
        labelText: title,
        alignLabelWithHint: true,
        labelStyle: TextStyle(
            fontFamily: AppFonts.POPPINS,
            color: AppColors.APP_TEXT2_COLOR),
        hintStyle: TextStyle(
            fontSize: 17.0,
            fontFamily: AppFonts.POPPINS,
            color: AppColors.APP_TEXT2_COLOR),
        contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
              color: AppColors.APP__DETAILS_TEXT_COLOR, width: 1.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
              color: AppColors.APP__DETAILS_TEXT_COLOR, width: 1.0),
        ));
  }

  static TextStyle subHeadingsTextStyleSfUiFont(
      BuildContext context, double fontSize) {
    return TextStyle(
        fontSize: fontSize,
        color: Theme.of(context).textTheme.headline1.color,
        fontFamily: AppFonts.SF_UI_DISPLAY,
        fontWeight: FontWeight.w600);
  }
//
//  static InputDecoration decorationWithoutBorders(String title) {
//    return InputDecoration(
//
//      focusedBorder: InputBorder.none,
//      hintText: title,
//      hintStyle: TextStyle(
//          fontSize: 17.0,
//          fontFamily: AppFonts.SF_PRO_FONT_REGULAR,
//          color: AppColors.APP_TEXT2_COLOR),
//      contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
//      enabledBorder: InputBorder.none,
//    );
//  }
//
//  static InputDecoration decorationWithoutBordersWithPrefixText(String title, String prefixText) {
//    return InputDecoration(
//      prefixText: prefixText,
//      focusedBorder: InputBorder.none,
//      hintText: title,
//      hintStyle: TextStyle(
//          fontSize: 17.0,
//          fontFamily: AppFonts.SF_PRO_FONT_REGULAR,
//          color: AppColors.APP_TEXT2_COLOR),
//      contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
//      enabledBorder: InputBorder.none,
//    );
//  }
//
//  static TextStyle carousalTextStyle(){
//    return TextStyle(
//        color: AppColors.WHITE_COLOR,
//        fontSize: AppTextSizes.INPUT_TEXT_SIZE,
//        fontFamily: AppFonts.SF_PRO_FONT_REGULAR,
//        fontWeight: FontWeight.w300);
//  }
//
//  static TextStyle dummyTextStyle(BuildContext context){
//    return TextStyle(
//        color: Theme.of(context).textTheme.headline1.color,
//        fontSize: AppTextSizes.SMALL_TEXT_SIZE,
//        fontFamily: AppFonts.SF_PRO_FONT_REGULAR,
//        fontWeight: FontWeight.w500);
//  }
//
//  static TextStyle blackColorTextStyle(BuildContext context){
//    return TextStyle(
//        color: Colors.black,
//        fontSize: AppTextSizes.SMALL_TEXT_SIZE,
//        fontFamily: AppFonts.SF_PRO_FONT_REGULAR,
//        fontWeight: FontWeight.w500);
//  }
//
//  static TextStyle subscriptoinPlansTextStyle(BuildContext context, double fontSize){
//    return TextStyle(
//        color: Theme.of(context).textTheme.headline1.color,
//        fontSize: fontSize,
//        fontFamily: AppFonts.SF_PRO_FONT_REGULAR,
////        decoration: TextDecoration.lineThrough,
//        fontWeight: FontWeight.bold);
//  }
//
//  static TextStyle subscriptoinPlansOldPriceTextStyle(BuildContext context, double fontSize){
//    return TextStyle(
//        color: AppColors.APP_TEXT2_COLOR,
//        fontSize: fontSize,
//        fontFamily: AppFonts.SF_PRO_FONT_REGULAR,
//        decoration: TextDecoration.lineThrough,
//        fontWeight: FontWeight.bold);
//  }
//
//  static TextStyle unselectedTabTextStyle(){
//    return TextStyle(
//      fontSize: AppTextSizes.SMALL_TEXT_SIZE,
//      fontFamily: AppFonts.SF_PRO_FONT_REGULAR,
//      fontWeight: FontWeight.w400,
//    );
//  }
//
//  static TextStyle selectedTabTextStyle(){
//    return TextStyle(
//      fontSize: AppTextSizes.SMALL_TEXT_SIZE,
//      fontFamily: AppFonts.SF_PRO_FONT_REGULAR,
//      fontWeight: FontWeight.w600,
//    );
//  }
//
//  static TextStyle appBarTitleTextStyle(BuildContext context){
//    return TextStyle(
//      color: Theme.of(context).appBarTheme.textTheme.headline1.color,
//      fontSize: 20.0,
//      fontFamily: AppFonts.SF_PRO_FONT_REGULAR,
//      fontWeight: FontWeight.w500,
//    );
//  }
//
//  static TextStyle blackTextStyle(BuildContext context){
//    return TextStyle(
//      color: Theme.of(context).appBarTheme.textTheme.headline1.color,
//      fontSize: AppTextSizes.SMALL_TEXT_SIZE,
//      fontFamily: AppFonts.SF_PRO_FONT_REGULAR,
//      fontWeight: FontWeight.w300,
//    );
//  }
//
//  static TextStyle blackWithDifferentFontTextStyle(BuildContext context, double fontSize){
//    return TextStyle(
//      color: Theme.of(context).appBarTheme.textTheme.headline1.color,
//      fontSize: fontSize,
//      fontFamily: AppFonts.SF_PRO_FONT_REGULAR,
//      fontWeight: FontWeight.w300,
//    );
//  }
//
//  static TextStyle detailWithSmallTextSizeTextStyle(){
//    return TextStyle(
//        fontSize: 12.0,
//        color: AppColors.APP__DETAILS_TEXT_COLOR,
//        fontFamily: AppFonts.SF_PRO_FONT_REGULAR,
//        fontWeight: FontWeight.w400
//    );
//  }
//
//  static InputDecoration messagingTextFieldDecoration(String title){
//    return  InputDecoration(
//
//        focusedBorder: OutlineInputBorder(
//          borderRadius: BorderRadius.circular(8.0),
//          borderSide:
//          BorderSide(color: Colors.grey[500], width: 1.0),
//        ),
//      labelStyle: TextStyle(
//          color: AppColors.APP_TEXT2_COLOR),
//        hintText: title,
//        hintStyle: TextStyle(
//            fontFamily: AppFonts.SF_PRO_FONT_REGULAR,
//            color: AppColors.APP_TEXT2_COLOR),
//        contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
//        border: OutlineInputBorder(
//          borderRadius: BorderRadius.circular(8.0),
//          borderSide:
//          BorderSide(color: Colors.grey[500], width: 1.0),
//        ),
//      );
//  }
}