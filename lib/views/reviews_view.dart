import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sizer/sizer.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/appresources/app_colors.dart';
class ReviewsView extends StatefulWidget {
  @override
  _ReviewsViewState createState() => _ReviewsViewState();
}

class _ReviewsViewState extends State<ReviewsView> {

  int _totalPages = 0;
  int _currentPage = 1;

  bool _isEnabled = true;
  bool _isInternetAvailable = true;
  bool _isPaginationLoading = false;

  ScrollController _controller;

  StreamController _streamController;

  //List<Notifications> _listOfUsers = [];

  @override
  void initState() {

    //_streamController = new StreamController<List<Notifications>>.broadcast();
    //_streamController.add(null);

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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back,
              color: AppColors.COLOR_BLACK,// add custom icons also
            ),
          ),
        ),
        backgroundColor: AppColors.WHITE_COLOR,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(

              children: [


              ],
            ),

          ),
        ));

  }



}

