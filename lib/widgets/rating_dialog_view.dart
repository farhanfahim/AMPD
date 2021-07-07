import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:ampd/widgets/button_border.dart';
import 'package:ampd/widgets/gradient_button.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class CustomRatingDialog extends StatefulWidget {
  String title;
  String subTitle;
  bool showImage;
  String buttonText1;
  Function onPressed1;
  Widget child;
  Widget ratingBar;
  BuildContext contex;

  CustomRatingDialog(
      {this.title = "",
      this.buttonText1 = "",
      this.onPressed1,
      this.child,
      this.contex,
      this.subTitle = "",
        this.ratingBar,
      this.showImage});

  @override
  _CustomRatingState createState() => _CustomRatingState();
}

class _CustomRatingState extends State<CustomRatingDialog> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.48;
    double width = MediaQuery.of(context).size.width * 0.4;
    double height1 = MediaQuery.of(context).size.height * 0.5;

    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 0.0),
      backgroundColor: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      //mainAxisAlignment: MainAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * .13),
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                          child: Text(
                            widget.subTitle,
                            style: AppStyles.blackWithSemiBoldFontTextStyle(
                                context, 20.0),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        Container(

                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Text(
                            widget.title,
                            style: AppStyles.blackWithSemiBoldFontTextStyle(
                                context, 15.0).copyWith(color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        widget.showImage
                            ? Container(
                                height: 10.0.h,
                                margin: EdgeInsets.fromLTRB(0.0, 40.0, 0, 30),
                                child: Center(
                                  child: widget.child,
                                ),
                              )
                            : Container(),
                        SizedBox(
                          height: 30.0,
                        ),


                        Container(
                          child: Center(
                            child: widget.ratingBar,
                          ),
                        ),

                        SizedBox(
                          height: 40.0,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                          decoration: ShapeDecoration(
                              color: AppColors.APP_COLOR_EXTRA_LIGHT_GREY,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(
                                      width: 0.5,
                                      color: AppColors.LIGHT_GREY_ARROW_COLOR))),
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            maxLength: 150,
                            maxLines: 3,
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: "Comments...",hintStyle: AppStyles.inputHintStyle(context)),
                            style: AppStyles.inputTextStyle2(context),
                          ),
                        ),
                        SizedBox(
                          height: 35.0,
                        ),
                        GradientButton(
                          onTap: () {
                            widget.onPressed1();
                          },
                          text: widget.buttonText1,
                        ),
                        SizedBox(
                          height: 45.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                right: 15,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                      width: 50,
                      height: 50,
                      child: FloatingActionButton(
                        heroTag: "tag",
                        backgroundColor: AppColors.BLUE_COLOR,
                        // backgroundColor:
                        // AppColors.PRIMARY_COLORTWO,
                        elevation: 2,
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20.0,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        // onPressed: widget.addClickListner
                      )),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
