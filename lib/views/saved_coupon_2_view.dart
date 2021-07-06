import 'dart:async';
import 'dart:math';

import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/data/model/NotificationsModel.dart';
import 'package:ampd/data/model/ReviewModel.dart';
import 'package:ampd/data/model/SavedCouponsModel.dart';
import 'package:ampd/views/setting_view.dart';
import 'package:ampd/widgets/flat_button.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/appresources/app_colors.dart';

class SavedCoupons2View extends StatefulWidget {
  @override
  _SavedCoupons2ViewState createState() => _SavedCoupons2ViewState();
}

class _SavedCoupons2ViewState extends State<SavedCoupons2View> {
  int _totalPages = 0;
  int _currentPage = 1;

  bool _isEnabled = true;
  bool _isInternetAvailable = true;
  bool _isPaginationLoading = false;

  ScrollController _controller;

  StreamController _streamController;

  List<SavedCoupons> _listOfSavedCoupons = [];

  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio();
  String _searchText = "";
  List names = new List();
  List filteredNames = new List();
  Icon _searchIcon = new Icon(Icons.search_rounded, color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT,);
  Widget _appBarTitle = new Text( '' );


  _SavedCoupons2ViewState() {
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
  void initState() {
    //_streamController = new StreamController<List<Notifications>>.broadcast();
    //_streamController.add(null);

    _listOfSavedCoupons.add(SavedCoupons(
        name: "Nice EpicReact Flyknit",
        dateTime: "May 30,2021 - 12:45",
        timeToAvail: "Time to Avail: (1 hour)",
        image:
            "https://images.pexels.com/photos/821651/pexels-photo-821651.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"));
    _listOfSavedCoupons.add(SavedCoupons(
        name: "Nice EpicReact Flyknit",
        dateTime: "May 30,2021 - 12:45",
        timeToAvail: "Time to Avail: (1 hour)",
        image:
            "https://images.pexels.com/photos/821651/pexels-photo-821651.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"));
    _listOfSavedCoupons.add(SavedCoupons(
        name: "Nice EpicReact Flyknit",
        dateTime: "May 30,2021 - 12:45",
        timeToAvail: "Time to Avail: (1 hour)",
        image:
            "https://images.pexels.com/photos/821651/pexels-photo-821651.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"));
    _listOfSavedCoupons.add(SavedCoupons(
        name: "Nice EpicReact Flyknit",
        dateTime: "May 30,2021 - 12:45",
        timeToAvail: "Time to Avail: (1 hour)",
        image:
            "https://images.pexels.com/photos/821651/pexels-photo-821651.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"));
    _listOfSavedCoupons.add(SavedCoupons(
        name: "Nice EpicReact Flyknit",
        dateTime: "May 30,2021 - 12:45",
        timeToAvail: "Time to Avail: (1 hour)",
        image:
            "https://images.pexels.com/photos/821651/pexels-photo-821651.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"));
    _listOfSavedCoupons.add(SavedCoupons(
        name: "Nice EpicReact Flyknit",
        dateTime: "May 30,2021 - 12:45",
        timeToAvail: "Time to Avail: (1 hour)",
        image:
            "https://images.pexels.com/photos/821651/pexels-photo-821651.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"));
    _listOfSavedCoupons.add(SavedCoupons(
        name: "Nice EpicReact Flyknit",
        dateTime: "May 30,2021 - 12:45",
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
    return Scaffold(
        appBar: searchAppBar(context),
        backgroundColor: AppColors.WHITE_COLOR,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 15.0,
                ),
                Header(
                    heading1: AppStrings.SAVED_COUPONS,
                    heading2: AppStrings.SAVED_COUPONS_RESULT),
                SizedBox(
                  height: 30.0,
                ),
                Expanded(
                  child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _listOfSavedCoupons.length,
                      itemBuilder: (context, index) {
                        return SavedCouponTileView(_listOfSavedCoupons[index]);
                      }),
                ),
              ],
            ),
          ),
        ));
  }

  Widget SavedCouponTileView(SavedCoupons data) {
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
                      height: 6.0,
                    ),
                    Text(
                      data.dateTime,
                      style: AppStyles.blackWithDifferentFontTextStyle(
                              context, 11.0)
                          .copyWith(
                              color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
                    ),
                    SizedBox(
                      height: 6.0,
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
        SizedBox(
          height: 20.0,
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

        IconButton(
            icon: Icon(
              Icons.filter_alt_outlined,
              size: 24.0,
              color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT, // add custom icons also
            ),
            onPressed: (){Navigator.pushNamed(context, AppRoutes.FILTER_VIEW);}

        )
      ],
    );
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close,color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT,);
        this._appBarTitle = new TextFormField(
          cursorColor: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT,
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
        this._searchIcon = new Icon(Icons.search ,color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT,);
        this._appBarTitle = new Text(
          '',
          style: AppStyles.blackWithDifferentFontTextStyle(
              context, 15.0)
              .copyWith(
              color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
        );
        filteredNames = names;
        _filter.clear();
      }
    });
  }
}
