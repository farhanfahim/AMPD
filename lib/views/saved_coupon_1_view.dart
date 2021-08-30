import 'dart:async';
import 'dart:math';

import 'package:ampd/app/app.dart';
import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/data/model/SavedCouponModel.dart';
import 'package:ampd/utils/ToastUtil.dart';
import 'package:ampd/utils/Util.dart';
import 'package:ampd/viewmodel/saved_coupon_viewmodel.dart';
import 'package:ampd/views/setting_view.dart';
import 'package:ampd/widgets/MD2Indicator.dart';
import 'package:ampd/widgets/flat_button.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:sizer/sizer.dart';

class SavedCoupons1View extends StatefulWidget {
  @override
  _SavedCoupons1ViewState createState() => _SavedCoupons1ViewState();
}

class _SavedCoupons1ViewState extends State<SavedCoupons1View> with SingleTickerProviderStateMixin {
  int _totalPages = 0;
  int _currentPage = 1;
  int _selectedIndex = 0;
  int _pageSize = 10;
  ScrollController _controller;
  StreamController _streamController;

  List<DataClass> dataList = <DataClass>[];
  List<DataClass> expiredCouponList = <DataClass>[];
  List<DataClass> activeCouponList = <DataClass>[];
  bool _enabled = true;
  bool _isPaginationLoading = false;
  bool _isInternetAvailable = false;

  SavedCouponViewModel _savedCouponViewModel;
  TabController tabController;

  final PagingController<int, DataClass> _pagingController =
  PagingController(firstPageKey: 1);

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

   /* _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });*/

    //_streamController = new StreamController<List<Notifications>>.broadcast();
    //_streamController.add(null);

    tabController = new TabController(vsync:this,length: 2);
    tabController.addListener(() {
      setState(() {
        _selectedIndex = tabController.index;
        print(_selectedIndex);
      });
    });

    _savedCouponViewModel = SavedCouponViewModel(App());
    subscribeToViewModel();
    callSavedCouponApi();

    _controller = ScrollController();
    _controller.addListener(_scrollListener);

    super.initState();
  }



  Future<void> _fetchPage(int pageKey) async {
    try {
      print('_fetchPage');

      callSavedCouponApi();
    } catch (error) {
      print('error1: $error');
      _pagingController.error = error;
    }
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
                            itemCount: dataList.length,
                            itemBuilder: (context, index) {
                              return activeCouponList.isNotEmpty?SavedCouponActiveTileView(activeCouponList[index]):Container(
                                child:  Text(
                                  "No Active Coupons",
                                  style: AppStyles.blackWithDifferentFontTextStyle(
                                      context, 12.0)
                                      .copyWith(
                                      color:
                                      AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
                                ),
                              );
                            }),
                        ListView.builder(
                            physics: ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: dataList.length,
                            itemBuilder: (context, index) {
                              return expiredCouponList.isNotEmpty?SavedCouponExpiredTileView(expiredCouponList[index]):Container(
                                child:  Text(
                                  "No Expired Coupons",
                                  style: AppStyles.blackWithDifferentFontTextStyle(
                                      context, 12.0)
                                      .copyWith(
                                      color:
                                      AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
                                ),
                              );
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
    _pagingController.dispose();
    super.dispose();
  }

  Widget SavedCouponActiveTileView(DataClass data) {
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
                      data.imageUrl,
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
                      Text(data.productName,
                          style:
                              AppStyles.blackWithBoldFontTextStyle(context, 16.0)
                                  .copyWith(color: AppColors.COLOR_BLACK)
                                  .copyWith(fontWeight: FontWeight.w600)),
                      SizedBox(
                        height: 3.0,
                      ),
                      Text(
                        data.expireAt,
                        style: AppStyles.blackWithDifferentFontTextStyle(
                                context, 11.0)
                            .copyWith(
                                color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Time to Avail:(${data.availTime } hour)",
                            style: AppStyles.blackWithDifferentFontTextStyle(
                                    context, 12.0)
                                .copyWith(
                                    color:
                                        AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
                          ),
                          FlatButtonWidget(
                              onTap: () {
                                Navigator.pushNamed(context, AppRoutes.REDEEM_NOW,arguments: {'offer_id': data.id,});
                              }, text: AppStrings.REDEEM_BTN,color: AppColors.BLUE_COLOR,),
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
  Widget SavedCouponExpiredTileView(DataClass data) {
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
                    data.imageUrl,
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
                    Text(data.productName,
                        style:
                        AppStyles.blackWithBoldFontTextStyle(context, 16.0)
                            .copyWith(color: AppColors.COLOR_BLACK)
                            .copyWith(fontWeight: FontWeight.w600)),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text(
                      data.expireAt,
                      style: AppStyles.blackWithDifferentFontTextStyle(
                          context, 11.0)
                          .copyWith(
                          color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Time to Avail:(${data.availTime } hour)",
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


  Future<void> callSavedCouponApi() async {

    Util.check().then((value) {
      if (value != null && value) {
        // Internet Present Case
        setState(() {
          _isInternetAvailable = true;
        });

        var map = Map<String, dynamic>();
        map['status'] = 10;
        _savedCouponViewModel.savedCoupons(map);
      } else {
        setState(() {
          _isInternetAvailable = false;
        });
      }
    });
  }
  void subscribeToViewModel() {
    _savedCouponViewModel
        .getHomeRepository()
        .getRepositoryResponse()
        .listen((response) async {

      if(mounted) {
        setState(() {
          _enabled = true;
        });
      }

      if(response.data is SavedCouponModel) {
        SavedCouponModel responseRegister = response.data;
        dataList = responseRegister.data.dataClass;
        DateTime now = DateTime.now();


        for(var coupon in dataList){
          String date = coupon.expireAt;
          DateTime dateTime = DateTime.parse(date);
          if(dateTime.isAfter(now)){
            activeCouponList.add(coupon);
          }else{
            expiredCouponList.add(coupon);
          }
        }
      }
      else if(response.data is DioError){
        _isInternetAvailable = Util.showErrorMsg(context, response.data);
      }
      else {
        ToastUtil.showToast(context, response.msg);
      }
    });



  }

}
