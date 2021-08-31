import 'dart:async';
import 'package:ampd/app/app.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/data/model/OffeReviewsModel.dart';
import 'package:ampd/utils/ToastUtil.dart';
import 'package:ampd/utils/Util.dart';
import 'package:ampd/utils/loader.dart';
import 'package:ampd/viewmodel/review_viewmodel.dart';
import 'package:ampd/widgets/NoRecordFound.dart';
import 'package:ampd/widgets/NotificationTileView.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ampd/appresources/app_colors.dart';

class ReviewsView extends StatefulWidget {
  Map<String, dynamic> map;
  ReviewsView(this.map);
  @override
  _ReviewsViewState createState() => _ReviewsViewState();
}

class _ReviewsViewState extends State<ReviewsView> {

  int _totalPages = 0;
  int _currentPage = 1;
  int _selectedIndex = 0;
  ScrollController _controller;
  StreamController _streamController;

  List<ReviewsData> _listOfReviews = [];

  bool _enabled = true;
  bool _isPaginationLoading = false;
  bool _isInternetAvailable = false;

  ReviewViewModel _reviewViewModel;

  @override
  void initState()  {


    _streamController = new StreamController<List<ReviewsData>>.broadcast();
    _streamController.add(null);

    _controller = ScrollController();
    _controller.addListener(_scrollListener);


    _reviewViewModel = ReviewViewModel(App());
    subscribeToViewModel();
    callOfferReviewsApi();

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
        callOfferReviewsApi();
      }
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: appBar(title:AppStrings.REVIEWS,onBackClick: (){
          Navigator.of(context).pop();
        },iconColor:AppColors.COLOR_BLACK),
        backgroundColor: AppColors.WHITE_COLOR,
        body: SafeArea(
          child: StreamBuilder<List<ReviewsData>>(
              stream: _streamController.stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.6,
                    child: Center(
                      child: Loader(
                          isLoading: true,
                          color: AppColors.ACCENT_COLOR
                      ),
                    ),
                  );
                } else {
                  return snapshot.data.length > 0 ? ListView(
                    shrinkWrap: true,
                    controller: _controller,
                    children: [
                      _listOfReviews.length > 0? ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _listOfReviews.length,
                          itemBuilder: (context, index) {
                            print(" list length ${_listOfReviews.length}");
                            return NotificationTileView(data:_listOfReviews[index]);
                          }):Center(
                        child: Container(
                          child:  Center(
                              child: NoRecordFound("No Review Found",
                                  AppImages.NO_NOTIFICATIONS_IMAGE)
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Loader(
                          isLoading: _isPaginationLoading,
                          color: AppColors.APP_PRIMARY_COLOR,
                        ),
                      ),
                    ],

                  ) : Center(
                      child: NoRecordFound("No Review Found",
                          AppImages.NO_NOTIFICATIONS_IMAGE)
                  );
                }
              })
        ));

  }



  static String formatUTCTime(String time) {
    DateTime tempDate = new DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'").parse(
        time);
    return DateFormat("MMM dd, yyyy - HH:mm").format(tempDate);
  }

  Future<void> callOfferReviewsApi() async {

    Util.check().then((value) {
      if (value != null && value) {
        // Internet Present Case
        if(mounted) {
          setState(() {
            _isInternetAvailable = true;
          });
        }

        var map = Map<String, dynamic>();
        map['offer_id'] = widget.map['offerId'];
        _reviewViewModel.getReviews(map);
      } else {
        if(mounted) {
          setState(() {
            _isInternetAvailable = false;
          });
        }
      }
    });
  }
  void subscribeToViewModel() {
    _reviewViewModel
        .getReviewsRepository()
        .getRepositoryResponse()
        .listen((response) async {

      if(mounted) {
        setState(() {
          _enabled = true;
          _isPaginationLoading = false;
        });
      }

      if(response.data != null) {

        _listOfReviews.clear();
        Reviews model = response.data;
        _listOfReviews = model.data;
        _streamController.add(_listOfReviews);

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



