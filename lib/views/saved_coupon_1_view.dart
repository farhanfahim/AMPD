import 'dart:async';
import 'dart:math';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:ampd/app/app.dart';
import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/data/model/SavedCouponModel.dart';
import 'package:ampd/utils/ToastUtil.dart';
import 'package:ampd/utils/Util.dart';
import 'package:ampd/utils/loader.dart';
import 'package:ampd/viewmodel/saved_coupon_viewmodel.dart';
import 'package:ampd/views/setting_view.dart';
import 'package:ampd/views/active_coupons_view.dart';
import 'package:ampd/views/expire_coupons_view.dart';
import 'package:ampd/widgets/NoRecordFound.dart';
import 'package:ampd/widgets/flat_button.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class SavedCoupons1View extends StatefulWidget {
  @override
  _SavedCoupons1ViewState createState() => _SavedCoupons1ViewState();
}

class _SavedCoupons1ViewState extends State<SavedCoupons1View> with SingleTickerProviderStateMixin {

  int _selectedIndex = 0;


  bool _enabled = true;

  TabController tabController;


  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio();
  String _searchText = "";
  List names = new List();
  List filteredNames = new List();
  Icon _searchIcon = new Icon(Icons.search_rounded, color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT,);
  Widget _appBarTitle = new Text( '' );

  _SavedCoupons1ViewState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          filteredNames = names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  @override
  void initState()  {


    tabController = new TabController(vsync:this,length: 2);
    tabController.addListener(() {
      setState(() {
        _selectedIndex = tabController.index;
        print(_selectedIndex);
      });
    });

    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    final tabBar = TabBar(
      unselectedLabelColor: Theme
          .of(context)
          .appBarTheme
          .textTheme
          .headline1
          .color
          .withOpacity(.54),
      labelColor: Theme
          .of(context)
          .appBarTheme
          .textTheme
          .headline1
          .color,
      // indicatorColor: AppColors.ACCENT_COLOR,
      indicatorSize: TabBarIndicatorSize.tab,
      // indicator: UnderlineTabIndicator(),
      indicator: ShapeDecoration(
          color: AppColors.BLUE_COLOR,
          shape: RoundedRectangleBorder(
              borderRadius: (_selectedIndex == 1) ? BorderRadius.only(
                  topRight: Radius.circular(5.0),
                  bottomRight: Radius.circular(5.0)) : BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  bottomLeft: Radius.circular(5.0))
          )),
      labelStyle: AppStyles.selectedTabTextStyle(),
      unselectedLabelStyle: AppStyles.unselectedTabTextStyle(),
      tabs: [
        new Tab(
          child: Text(AppStrings.ACTIVE,
              style:
              AppStyles.blackWithBoldFontTextStyle(context, 9.0.sp)
                  .copyWith(color: (_selectedIndex == 0)
                  ? AppColors.WHITE_COLOR
                  : AppColors.APP__DETAILS_TEXT_COLOR_LIGHT)
                  .copyWith(fontWeight: FontWeight.w600)),

        ),
        new Tab(
          child: Text(AppStrings.EXPIRED,
              style:
              AppStyles.blackWithBoldFontTextStyle(context, 9.0.sp)
                  .copyWith(color: (_selectedIndex == 1)
                  ? AppColors.WHITE_COLOR
                  : AppColors.APP__DETAILS_TEXT_COLOR_LIGHT)
                  .copyWith(fontWeight: FontWeight.w600)),
        ),
      ],
      controller: tabController,
    );


    final body = Container(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Header(
                    heading1: AppStrings.SAVED_COUPONS,
                    heading2: AppStrings.SHOW_ALL_COUPONS),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                    decoration: ShapeDecoration(
                        color: AppColors.WHITE_COLOR,
                        shadows: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(
                                0, 2), // changes position of shadow
                          ),
                        ],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ))
                    , child: tabBar),
                SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: tabController,
                    children: [
                      ActiveCouponsView(),
                      ExpireCouponsView(),


                    ],
                  ),
                ),

              ],
            )));

    return DefaultTabController(
      length: 2,
      child: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Scaffold(
          appBar: searchAppBar(context),
          backgroundColor: AppColors.WHITE_COLOR,
          body: SafeArea(child: body),
        ),
      ),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Widget searchAppBar(BuildContext context) {
    return new AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: _appBarTitle,
      actions: <Widget>[
        IconButton(
          icon: _searchIcon,
          onPressed: _searchPressed,

        ),

        Container(
          margin: EdgeInsets.only(right: 20.0),
          child: GestureDetector(
            child: SvgPicture.asset(
              AppImages.FILTER,
            ),
            onTap: (){
              Navigator.pushNamed(context, AppRoutes.FILTER_VIEW);
            },
          ),
        ),
      ],
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close,color: AppColors.APP__DETAILS_TEXT_COLOR,);
        this._appBarTitle = new TextFormField(
          cursorColor: AppColors.APP__DETAILS_TEXT_COLOR,
          keyboardType: TextInputType.text,
          decoration: new InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: "Search..."),
        );

      } else {
        this._searchIcon = new Icon(Icons.search ,color: AppColors.APP__DETAILS_TEXT_COLOR,);
        this._appBarTitle = new Text(
          '',
          style: AppStyles.blackWithDifferentFontTextStyle(
              context, 15.0)
              .copyWith(
              color: AppColors.APP__DETAILS_TEXT_COLOR),
        );
        filteredNames = names;
        _filter.clear();
      }
    });
  }

  static String formatUTCTime(String time) {
    DateTime tempDate = new DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'").parse(
        time);
    return DateFormat("MMM dd, yyyy - HH:mm").format(tempDate);
  }


  bool checkExpiry(String expiry){
    DateTime now = DateTime.now();
    DateTime dateTime = DateTime.parse(expiry);
    if(dateTime.isAfter(now)){
      return false;
    }else{
      return true;
    }
  }

}

/*

 */