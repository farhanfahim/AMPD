import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:flutter/material.dart';


class CustomDialog extends StatefulWidget {
  String title;
  String subTitle;
  String buttonText1;
  String buttonText2;
  Function onPressed1;
  Function onPressed2;
  Widget child;
  BuildContext contex ;


  CustomDialog({this.title = "", this.buttonText1 = "",this.buttonText2 = "", this.onPressed1,this.onPressed2, this.child,this.contex,this.subTitle = ""});

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
      insetPadding: EdgeInsets.symmetric(horizontal: 15.0),
      backgroundColor: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20.0))
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [

                        Text(
                          widget.title,
                          style: AppStyles.staticLabelsTextStyle(context).copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10,),
                         Text(
                          widget.subTitle,
                          textAlign: TextAlign.center,
                          style: AppStyles.staticLabelsTextStyle(context),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width/3,
                              child: buttonWithColor(
                                title: widget.buttonText1,
                                color: AppColors.APP_MAIN_SPLASH_COLOR,
                                onTap: () {

                                  widget.onPressed1();
                                }
                                ,),
                            ),
                            SizedBox(width: 20,),
                            Container(
                              width: MediaQuery.of(context).size.width/3,
                              child: buttonWithColor(
                                color: AppColors.ACCENT_COLOR,
                                title: widget.buttonText2,
                                // btnColor: AppColors.APPGREENCOLOR,
                                onTap: () {
                                  widget.onPressed2();
                                },),
                            ),
                          ],
                        )

                      ],
                    ),
                  ),

                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                      width: 40,
                      height: 40,
                      child:
                      FloatingActionButton(
                        heroTag: "tag",
                        backgroundColor:AppColors.ACCENT_COLOR ,
                        // backgroundColor:
                        // AppColors.PRIMARY_COLORTWO,
                        elevation: 2,
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 30.0,
                        ),
                        onPressed: (){
                          Navigator.pop(context);
                        },
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