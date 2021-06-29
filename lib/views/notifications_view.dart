import 'dart:async';
import 'dart:math';

import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/data/model/NotificationsModel.dart';
import 'package:ampd/data/model/ReviewModel.dart';
import 'package:ampd/views/setting_view.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/appresources/app_colors.dart';

class NotificationsView extends StatefulWidget {
  @override
  _NotificationsViewState createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  int _totalPages = 0;
  int _currentPage = 1;

  bool _isEnabled = true;
  bool _isInternetAvailable = true;
  bool _isPaginationLoading = false;

  ScrollController _controller;

  StreamController _streamController;

  List<Notifications> _listOfNotification = [];

  @override
  void initState() {
    //_streamController = new StreamController<List<Notifications>>.broadcast();
    //_streamController.add(null);

    _listOfNotification.add(Notifications(
        name: "Nice EpicReact Flyknit",
        dateTime: "May 30,2021 - 12:45",
        address: "99 Balentine Drive Newark",
        image:
            "https://images.pexels.com/photos/821651/pexels-photo-821651.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"));
    _listOfNotification.add(Notifications(
        name: "Nice EpicReact Flyknit",
        dateTime: "May 30,2021 - 12:45",
        address: "99 Balentine Drive Newark",
        image:
            "https://images.pexels.com/photos/821651/pexels-photo-821651.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"));
    _listOfNotification.add(Notifications(
        name: "Nice EpicReact Flyknit",
        dateTime: "May 30,2021 - 12:45",
        address: "99 Balentine Drive Newark",
        image:
            "https://images.pexels.com/photos/821651/pexels-photo-821651.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"));
    _listOfNotification.add(Notifications(
        name: "Nice EpicReact Flyknit",
        dateTime: "May 30,2021 - 12:45",
        address: "99 Balentine Drive Newark",
        image:
            "https://images.pexels.com/photos/821651/pexels-photo-821651.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"));
    _listOfNotification.add(Notifications(
        name: "Nice EpicReact Flyknit",
        dateTime: "May 30,2021 - 12:45",
        address: "99 Balentine Drive Newark",
        image:
            "https://images.pexels.com/photos/821651/pexels-photo-821651.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"));
    _listOfNotification.add(Notifications(
        name: "Nice EpicReact Flyknit",
        dateTime: "May 30,2021 - 12:45",
        address: "99 Balentine Drive Newark",
        image:
            "https://images.pexels.com/photos/821651/pexels-photo-821651.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"));
    _listOfNotification.add(Notifications(
        name: "Nice EpicReact Flyknit",
        dateTime: "May 30,2021 - 12:45",
        address: "99 Balentine Drive Newark",
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
                  height: 30.0,
                ),
                Expanded(
                  child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _listOfNotification.length,
                      itemBuilder: (context, index) {
                        return NotificationTileView(_listOfNotification[index]);
                      }),
                ),
              ],
            ),
          ),
        ));
  }

  Widget NotificationTileView(Notifications data) {
    return Column(
      children: [
        SizedBox(
          height: 10.0,
        ),
        InkWell(
          onTap: () {},
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
                          style: AppStyles.blackWithBoldFontTextStyle(
                                  context, 16.0)
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
                      Text(
                        data.address,
                        style: AppStyles.blackWithDifferentFontTextStyle(
                                context, 12.0)
                            .copyWith(
                                color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        divider(),
      ],
    );
  }
}
