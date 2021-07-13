import 'dart:async';
import 'dart:math';

import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/data/model/SavedCouponsModel.dart';
import 'package:ampd/views/setting_view.dart';
import 'package:ampd/widgets/MD2Indicator.dart';
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
  int _totalPages = 0;
  int _currentPage = 1;

  bool _isEnabled = true;
  bool _isInternetAvailable = true;
  bool _isPaginationLoading = false;

  ScrollController _controller;

  StreamController _streamController;

  List<SavedCoupons> _listOfSavedCoupons = [];
  TabController tabController;

  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio();
  String _searchText = "";
  List names = new List();
  List filteredNames = new List();
  Icon _searchIcon = new Icon(Icons.search_rounded, color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT,);
  Widget _appBarTitle = new Text( '' );

  int _selectedIndex = 0;
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
    //_streamController = new StreamController<List<Notifications>>.broadcast();
    //_streamController.add(null);

    tabController = new TabController(vsync:this,length: 2);
    tabController.addListener(() {
      setState(() {
        _selectedIndex = tabController.index;
        print(_selectedIndex);
      });
    });
    _listOfSavedCoupons.add(SavedCoupons(
        name: "Nice EpicReact Flyknit",
        dateTime: "May 30, 2021 - 12:45",
        timeToAvail: "Time to Avail: (1 hour)",
        image:
            "https://images.pexels.com/photos/821651/pexels-photo-821651.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"));
    _listOfSavedCoupons.add(SavedCoupons(
        name: "Nice EpicReact Flyknit",
        dateTime: "May 30, 2021 - 12:45",
        timeToAvail: "Time to Avail: (1 hour)",
        image:
            "https://images.pexels.com/photos/821651/pexels-photo-821651.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"));
    _listOfSavedCoupons.add(SavedCoupons(
        name: "Nice EpicReact Flyknit",
        dateTime: "May 30, 2021 - 12:45",
        timeToAvail: "Time to Avail: (1 hour)",
        image:
            "https://images.pexels.com/photos/821651/pexels-photo-821651.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"));
    _listOfSavedCoupons.add(SavedCoupons(
        name: "Nice EpicReact Flyknit",
        dateTime: "May 30, 2021 - 12:45",
        timeToAvail: "Time to Avail: (1 hour)",
        image:
            "https://images.pexels.com/photos/821651/pexels-photo-821651.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"));
    _listOfSavedCoupons.add(SavedCoupons(
        name: "Nice EpicReact Flyknit",
        dateTime: "May 30, 2021 - 12:45",
        timeToAvail: "Time to Avail: (1 hour)",
        image:
            "https://images.pexels.com/photos/821651/pexels-photo-821651.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"));
    _listOfSavedCoupons.add(SavedCoupons(
        name: "Nice EpicReact Flyknit",
        dateTime: "May 30, 2021 - 12:45",
        timeToAvail: "Time to Avail: (1 hour)",
        image:
            "https://images.pexels.com/photos/821651/pexels-photo-821651.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"));
    _listOfSavedCoupons.add(SavedCoupons(
        name: "Nice EpicReact Flyknit",
        dateTime: "May 30, 2021 - 12:45",
        timeToAvail: "Time to Avail: (1 hour)",
        image:
            "https://images.pexels.com/photos/821651/pexels-photo-821651.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"));

    _controller = ScrollController();
    _controller.addListener(_scrollListener);

    super.initState();
  }

  void _scrollListener() {
    print(_controller.position.extentAfter);
    if (_controller.position.extentAfter < 500) {
      if (_currentPage + 1 <= _totalPages) {
        setState(() {
          _isPaginationLoading = true;
        });
        _currentPage = _currentPage + 1;

        print('TOTAL PAGES --- $_currentPage');
      }
    }
  }


  @override
  Widget build(BuildContext context) {


    final tabBar = TabBar(
      unselectedLabelColor: Theme.of(context)
          .appBarTheme
          .textTheme
          .headline1
          .color
          .withOpacity(.54),
      labelColor: Theme.of(context).appBarTheme.textTheme.headline1.color,
      // indicatorColor: AppColors.ACCENT_COLOR,
      indicatorSize: TabBarIndicatorSize.tab,
      // indicator: UnderlineTabIndicator(),
      indicator: ShapeDecoration(
          color: AppColors.BLUE_COLOR,
          shape: RoundedRectangleBorder(
            borderRadius: (_selectedIndex == 1) ? BorderRadius.only(topRight: Radius.circular(5.0), bottomRight: Radius.circular(5.0)) :BorderRadius.only(topLeft: Radius.circular(5.0), bottomLeft: Radius.circular(5.0))
              )),
      labelStyle: AppStyles.selectedTabTextStyle(),
      unselectedLabelStyle: AppStyles.unselectedTabTextStyle(),
      tabs: [
        new Tab(
          child: Text(AppStrings.ACTIVE,
              style:
              AppStyles.blackWithBoldFontTextStyle(context, 9.0.sp)
                  .copyWith(color: (_selectedIndex == 0) ? AppColors.WHITE_COLOR : AppColors.APP__DETAILS_TEXT_COLOR_LIGHT)
                  .copyWith(fontWeight: FontWeight.w600)),

        ),
        new Tab(
          child: Text(AppStrings.EXPIRED,
              style:
              AppStyles.blackWithBoldFontTextStyle(context, 9.0.sp)
                  .copyWith(color: (_selectedIndex == 1) ? AppColors.WHITE_COLOR : AppColors.APP__DETAILS_TEXT_COLOR_LIGHT)
                  .copyWith(fontWeight: FontWeight.w600)),
        ),
      ],
      controller: tabController,
    );



    final body =  SafeArea(

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
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            ))
                    ,child: tabBar),
                SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: Container(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: tabController,
                      children: [
                        ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _listOfSavedCoupons.length,
                            itemBuilder: (context, index) {
                              return SavedCouponActiveTileView(_listOfSavedCoupons[index]);
                            }),
                        ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _listOfSavedCoupons.length,
                            itemBuilder: (context, index) {
                              return SavedCouponExpiredTileView(_listOfSavedCoupons[index]);
                            }),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        );

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

  Widget SavedCouponActiveTileView(SavedCoupons data) {
    return Column(
      children: [
        SizedBox(
          height: 10.0,
        ),
        InkWell(
          onTap: (){

          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              children: [
                Container(
                  width: 70.0,
                  height: 70.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    child: Image.network(
                      data.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.name,
                          style:
                              AppStyles.blackWithBoldFontTextStyle(context, 16.0)
                                  .copyWith(color: AppColors.COLOR_BLACK)
                                  .copyWith(fontWeight: FontWeight.w600)),
                      SizedBox(
                        height: 3.0,
                      ),
                      Text(
                        data.dateTime,
                        style: AppStyles.blackWithDifferentFontTextStyle(
                                context, 11.0)
                            .copyWith(
                                color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data.timeToAvail,
                            style: AppStyles.blackWithDifferentFontTextStyle(
                                    context, 12.0)
                                .copyWith(
                                    color:
                                        AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
                          ),
                          FlatButtonWidget(
                              onTap: () {}, text: AppStrings.REDEEM_BTN,color: AppColors.BLUE_COLOR,),
                        ],
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        divider(),
      ],
    );
  }
  Widget SavedCouponExpiredTileView(SavedCoupons data) {
    return Column(
      children: [
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              Container(
                width: 70.0,
                height: 70.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Image.network(
                    data.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.name,
                        style:
                        AppStyles.blackWithBoldFontTextStyle(context, 16.0)
                            .copyWith(color: AppColors.COLOR_BLACK)
                            .copyWith(fontWeight: FontWeight.w600)),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      data.dateTime,
                      style: AppStyles.blackWithDifferentFontTextStyle(
                          context, 11.0)
                          .copyWith(
                          color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          data.timeToAvail,
                          style: AppStyles.blackWithDifferentFontTextStyle(
                              context, 12.0)
                              .copyWith(
                              color:
                              AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
                        ),
                        FlatButtonWidget(
                            onTap: () {}, text: AppStrings.EXPIRED,color: AppColors.RED_COLOR2,),
                      ],
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        divider(),
      ],
    );
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
}
