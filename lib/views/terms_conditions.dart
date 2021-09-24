import 'dart:async';
import 'dart:math';

import 'package:ampd/app/app.dart';
import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_fonts.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/data/model/PageModel.dart';
import 'package:ampd/utils/ToastUtil.dart';
import 'package:ampd/utils/Util.dart';
import 'package:ampd/utils/loader.dart';
import 'package:ampd/viewmodel/about_viewmodel.dart';
import 'package:ampd/viewmodel/term_condition_viewmodel.dart';
import 'package:ampd/widgets/NoRecordFound.dart';
import 'package:ampd/widgets/button_border.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

class TermsConditionsView extends StatefulWidget {
  @override
  _TermsConditionsState createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditionsView> {
  static ValueKey key3 = ValueKey('key_2');

  bool _blockNavigation = false;
  TermsConditionViewModel _termsConditionViewModel;
  bool _isInternetAvailable = true;
  PageModel model;
  bool _enabled = true;
  bool isDataLoad = true;
  StreamController _streamController;

  @override
  void initState() {
    super.initState();

    _streamController = new StreamController<PageModel>.broadcast();
    _streamController.add(null);

    _termsConditionViewModel = TermsConditionViewModel(App());
    subscribeToViewModel();
    callPageApi();
  }

  @override
  Widget build(BuildContext context) {
    bool pushNotificationSwitch = false;
    int a  = 0;
    return Scaffold(
        appBar: appBar(
            title: "",
            onBackClick: () {
              Navigator.of(context).pop();
            },
            iconColor: AppColors.COLOR_BLACK),
        backgroundColor: AppColors.WHITE_COLOR,
        body: SafeArea(
          child: StreamBuilder<PageModel>(
              stream: _streamController.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.9,
                    child: Center(
                      child: Container(
                        height: 60.0,
                        child: Loader(
                            isLoading: isDataLoad,
                            color: AppColors.ACCENT_COLOR
                        ),
                      ),
                    ),
                  );
                } else {

                  return snapshot.data!= null ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      children: [
                        Header(
                            heading1: AppStrings.TERMS_CONDITION,
                            heading2: AppStrings.TERMS_AND_CONDITIONS_HELP),
                        SizedBox(
                          height: 30.0,
                        ),

                        Expanded(
                          child: aboutUsText(snapshot.data.content,context),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  ): Center(
                      child: NoRecordFound("No about us",
                          AppImages.NO_NOTIFICATIONS_IMAGE)
                  );
                }
              }),
        ));
  }

  Future<void> callPageApi() async {
    Util.check().then((value) {
      if (value != null && value) {
        // Internet Present Case
        setState(() {
          _isInternetAvailable = true;
        });

        var map = Map<String, dynamic>();
        _termsConditionViewModel.getpage(map);
      } else {
        setState(() {
          _isInternetAvailable = false;
          ToastUtil.showToast(context, "No internet");
        });
      }
    });
  }

  void subscribeToViewModel() {
    _termsConditionViewModel
        .getTermConditionRepository()
        .getRepositoryResponse()
        .listen((response) async {

      if(mounted) {
        setState(() {
          _enabled = true;
          isDataLoad= false;
        });
      }

      if (response.data is PageModel) {
        model = response.data;
        _streamController.add(model);

      }else if (response.data is DioError) {
        if (response.statusCode == 401) {
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.WELCOME_VIEW, (Route<dynamic> route) => false);
        }else{
          _isInternetAvailable = Util.showErrorMsg(context, response.data);
        }
      } else {
        ToastUtil.showToast(context, response.msg);
      }
    });
  }
}

class Header extends StatelessWidget {
  final String heading1;
  final String heading2;

  const Header({
    this.heading1,
    this.heading2,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.0,
          ),
          Text(
            heading1,
            style: AppStyles.blackWithBoldFontTextStyle(context, 18.0)
                .copyWith(color: AppColors.COLOR_BLACK),
          ),
          SizedBox(
            height: 6.0,
          ),
          Text(
            heading2,
            style: AppStyles.blackWithDifferentFontTextStyle(context, 14.0)
                .copyWith(color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
          ),
        ],
      ),
    );
  }


}

Widget aboutUsText(String content,BuildContext ctx) {
  return Container(
    child: Html(
      data: content,
      onLinkTap: (val){
        Util.launchInWebViewWithJavaScript(val);
      },
      defaultTextStyle: AppStyles.blackWithDifferentFontTextStyle(ctx, 14.0)
          .copyWith(color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
    ),
    // child: Text(aboutUsResponse.content,
    //     style: AppStyles.detailTextStyle()
    //         .copyWith(color: AppColors.APP__DETAILS_TEXT_COLOR)),
  );
}

customHandler(IconData icon) {
  return FlutterSliderHandler(
    decoration: BoxDecoration(),
    child: Container(
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.3), shape: BoxShape.circle),
        child: Icon(
          icon,
          color: Colors.white,
          size: 23,
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              color: Colors.blue.withOpacity(0.3),
              spreadRadius: 0.05,
              blurRadius: 5,
              offset: Offset(0, 1))
        ],
      ),
    ),
  );
}

