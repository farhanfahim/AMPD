import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:ampd/widgets/button_border.dart';
import 'package:ampd/widgets/gradient_button.dart';
import 'package:sizer/sizer.dart';

class CustomDialog extends StatefulWidget {
  String title;
  bool showAnimatedBtn;
  String subTitle;
  bool showImage;
  String buttonText1;
  String buttonText2;
  Function onPressed1;
  Function onPressed2;
  Function onPressed3;
  Widget child,btnWidget;
  BuildContext contex ;


  CustomDialog({this.title = "", this.showAnimatedBtn = false,this.buttonText1 = "",this.buttonText2 = "", this.onPressed1,this.onPressed2,this.onPressed3,this.btnWidget, this.child,this.contex,this.subTitle = "",this.showImage});

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    double height  =  MediaQuery.of(context).size.height * 0.48;
    double width  =  MediaQuery.of(context).size.width * 0.4 ;
    double height1  =  MediaQuery.of(context).size.height * 0.5;

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
                      borderRadius: BorderRadius.all(Radius.circular(20.0))
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      //mainAxisAlignment: MainAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width * .13),
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                          child: Text(
                            widget.subTitle,
                            style:
                            AppStyles.blackWithSemiBoldFontTextStyle(context, 18.0).copyWith(fontWeight: FontWeight.w600),textAlign: TextAlign.center,
                          ),
                        ),
                        widget.showImage?   Container(
//                          height: 15.0.h,
                          height: 100.0,
                          margin: EdgeInsets.fromLTRB(0.0, 40.0, 0, 30),
                          child: Center(
                            child: widget.child,
                          ),
                        ):Container(),
                        SizedBox(
                          height: 35.0,
                        ),
                        widget.showAnimatedBtn?widget.btnWidget:
                        GradientButton(
                          onTap: () { widget.onPressed1();},
                          text: widget.buttonText1,
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ButtonBorder(
                          onTap: () { widget.onPressed2();},
                          text: widget.buttonText2,
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
                      child:
                      FloatingActionButton(
                        heroTag: "tag",
                        backgroundColor:AppColors.BLUE_COLOR ,
                        // backgroundColor:
                        // AppColors.PRIMARY_COLORTWO,
                        elevation: 2,
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20.0,
                        ),
                        onPressed: widget.onPressed3,
                        // onPressed: widget.addClickListner
                      )
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}