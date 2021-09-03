import 'dart:async';
import 'dart:math';

import 'package:ampd/app/app.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/data/model/NotificationModel.dart';
import 'package:ampd/utils/ToastUtil.dart';
import 'package:ampd/utils/Util.dart';
import 'package:ampd/utils/loader.dart';
import 'package:ampd/viewmodel/notification_viewmodel.dart';
import 'package:ampd/views/setting_view.dart';
import 'package:ampd/widgets/NoRecordFound.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

class NotificationsView extends StatefulWidget {
  @override
  _NotificationsViewState createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  int _totalPages = 0;
  int _currentPage = 1;
  NotificationViewModel _notificationViewModel;
  bool _isEnabled = true;
  bool _isInternetAvailable = true;
  bool _isPaginationLoading = false;
  final PagingController<int, Data> _pagingController1 =  PagingController(firstPageKey: 1);

  void initState()  {

    _pagingController1.addPageRequestListener((pageKey) {
      print(pageKey);
      _fetchPage(pageKey);
    });

    _notificationViewModel = NotificationViewModel(App());
    subscribeToViewModel();
    super.initState();
  }
  Future<void> _fetchPage(int pageKey) async {
    try {
      callNotificationApi();
    } catch (error) {
      _pagingController1.error = error;
    }
  }
  @override
  void dispose() {

    _pagingController1.dispose();
    super.dispose();
  }

  static String formatUTCTime(String time) {
    DateTime tempDate = new DateFormat("yyyy-mm-dd HH:mm:ss").parse(
        time);
    return DateFormat("MMM dd, yyyy - HH:mm").format(tempDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(
            title: "",
            onBackClick: () {
              Navigator.of(context).pop();
            },iconColor:AppColors.COLOR_BLACK),
        backgroundColor: AppColors.WHITE_COLOR,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Header(
                    heading1: AppStrings.NOTIFICATIONS,
                    heading2: AppStrings.ALL_NOTIIFICATION_SHOW_HERE),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  child: Expanded(
                    child: PagedListView<int, Data>(
                      pagingController: _pagingController1,
                      builderDelegate: PagedChildBuilderDelegate<Data>(
                        itemBuilder: (context, item, index) {

                          print('Item index: $index');

                          return NotificationTileView(item);
                        },
                        noItemsFoundIndicatorBuilder: (context) => Center(
                            child: NoRecordFound(
                                "No Result Found", AppImages.NO_TEETIMES_IMAGE)),
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
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget NotificationTileView(Data data) {
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
                    Text(data.title,
                        style: AppStyles.blackWithBoldFontTextStyle(
                                context, 16.0)
                            .copyWith(color: AppColors.COLOR_BLACK)
                            .copyWith(fontWeight: FontWeight.w600)),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      formatUTCTime(data.createdAt),
                      style: AppStyles.blackWithDifferentFontTextStyle(
                              context, 11.0)
                          .copyWith(
                              color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      data.message,
                      style: AppStyles.blackWithDifferentFontTextStyle(
                              context, 12.0)
                          .copyWith(
                              color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
                    ),
                    SizedBox(
                      height: 3.0,
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



  Future<void> callNotificationApi() async {

    Util.check().then((value) {
      if (value != null && value) {
        // Internet Present Case
        setState(() {
          _isInternetAvailable = true;
        });

        var map = Map<String, dynamic>();
        map['offset'] = _currentPage;
        _notificationViewModel.getNotification(map);
      } else {
        setState(() {
          _isInternetAvailable = false;
        });
      }
    });
  }

  void subscribeToViewModel() {
    _notificationViewModel
        .getNotificationRepository()
        .getRepositoryResponse()
        .listen((response) async {

      if(mounted) {
        setState(() {
          _isPaginationLoading = false;
        });
      }

      if(response.data is NotificationModel) {
        _isPaginationLoading = false;

        _totalPages = response.data.lastPage;

        print('Last Page: $_totalPages');

        final isNotLastPage = _currentPage + 1 <= _totalPages;
        print('_currentPage $_currentPage');
        print('isNotLastPage $isNotLastPage');

        if (!isNotLastPage) {
          // 3
          _pagingController1.appendLastPage(response.data.data);


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
