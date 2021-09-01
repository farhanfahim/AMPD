import 'dart:math';

import 'package:ampd/app/app.dart';
import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_fonts.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/data/model/SavedCouponModel.dart';
import 'package:ampd/utils/ToastUtil.dart';
import 'package:ampd/utils/Util.dart';
import 'package:ampd/utils/loader.dart';
import 'package:ampd/viewmodel/saved_coupon_viewmodel.dart';
import 'package:ampd/widgets/NoRecordFound.dart';
import 'package:ampd/widgets/button_border.dart';
import 'package:ampd/widgets/flat_button.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

class ActiveCouponsView extends StatefulWidget {

  @override
  _ActiveCouponsState createState() => _ActiveCouponsState();
}

class _ActiveCouponsState extends State<ActiveCouponsView> {

  int _totalPages = 0;
  int _currentPage = 1;
  int _selectedIndex = 0;
  final PagingController<int, DataClass> _pagingController1 =  PagingController(firstPageKey: 1);

  List<DataClass> dataList = List<DataClass>();

  bool _enabled = true;
  bool _isPaginationLoading = false;
  bool _isInternetAvailable = false;

  SavedCouponViewModel _savedCouponViewModel;


  @override
  void initState()  {

    _pagingController1.addPageRequestListener((pageKey) {
      print(pageKey);
      _fetchPage(pageKey);
    });

    _savedCouponViewModel = SavedCouponViewModel(App());
    subscribeToViewModel();
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      callSavedCouponApi();
    } catch (error) {
      _pagingController1.error = error;
    }
  }
  @override
  void dispose() {

    _pagingController1.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

        backgroundColor: AppColors.WHITE_COLOR,
        body: SafeArea(
          child: PagedListView<int, DataClass>(
            pagingController: _pagingController1,
            builderDelegate: PagedChildBuilderDelegate<DataClass>(
              itemBuilder: (context, item, index) {

                print('Item index: $index');

                return SavedCouponActiveTileView(item);
              },
              noItemsFoundIndicatorBuilder: (context) => Center(
                  child: NoRecordFound(
                      "No Active Coupon Found", AppImages.NO_TEETIMES_IMAGE)),
              firstPageProgressIndicatorBuilder: (context) => Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Center(
                  child: Container(
                    height: 60.0,
                    child: Loader(
                        isLoading: true,
                        color: AppColors.ACCENT_COLOR
                    ),
                  ),
                ),
              ),
              newPageProgressIndicatorBuilder: (context) => Padding(
                padding: EdgeInsets.all(5),
                child: Container(
                  height: 30.0,
                  child: Loader(
                    isLoading: true,
                    color: AppColors.APP_PRIMARY_COLOR,
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  static String formatUTCTime(String time) {
    DateTime tempDate = new DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'").parse(
        time);
    return DateFormat("MMM dd, yyyy - HH:mm").format(tempDate);
  }

  Widget SavedCouponActiveTileView(DataClass data) {
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
                      formatUTCTime(data.expireAt),
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
        SizedBox(
          height: 10.0,
        ),
        divider(),
      ],
    );
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
        map['offset'] = _currentPage;
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
        .getSavedCouponRepository()
        .getRepositoryResponse()
        .listen((response) async {

      if(mounted) {
        setState(() {
          _enabled = true;
          _isPaginationLoading = false;
        });
      }

      if(response.data is SavedCouponModel) {
        _isPaginationLoading = false;

        _totalPages = response.data.lastPage;

        print('Last Page: $_totalPages');

        final isNotLastPage = _currentPage + 1 <= _totalPages;
        print('_currentPage $_currentPage');
        print('isNotLastPage $isNotLastPage');

        if (!isNotLastPage) {
          // 3
          _pagingController1.appendLastPage(response.data.dataClass);

        } else {
          final nextPageKey = _currentPage + 1;
          _currentPage = _currentPage + 1;

          print('New Page: $_totalPages');

            _pagingController1.appendPage(response.data.dataClass, nextPageKey);
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


