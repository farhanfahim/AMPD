import 'dart:async';
import 'dart:math';

import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/data/model/ReviewModel.dart';
import 'package:ampd/widgets/widgets.dart';
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

  List<Reviews> _listOfReviews = [];

  @override
  void initState() {

    //_streamController = new StreamController<List<Notifications>>.broadcast();
    //_streamController.add(null);

    _listOfReviews.add(Reviews(name:"Mark Smith",rating:4.8,description:AppStrings.REDEEM_MESSAGE_TEXT,image:"https://iconape.com/wp-content/png_logo_vector/avatar-4.png"));
    _listOfReviews.add(Reviews(name:"John Doe",rating:4.8,description:AppStrings.REDEEM_MESSAGE_TEXT,image:"https://iconape.com/wp-content/png_logo_vector/avatar-4.png"));
    _listOfReviews.add(Reviews(name:"John Doe",rating:4.8,description:AppStrings.REDEEM_MESSAGE_TEXT,image:"https://iconape.com/wp-content/png_logo_vector/avatar-4.png"));
    _listOfReviews.add(Reviews(name:"Mark Smith",rating:4.8,description:AppStrings.REDEEM_MESSAGE_TEXT,image:"https://iconape.com/wp-content/png_logo_vector/avatar-4.png"));
    _listOfReviews.add(Reviews(name:"John Doe",rating:4.8,description:AppStrings.REDEEM_MESSAGE_TEXT,image:"https://iconape.com/wp-content/png_logo_vector/avatar-4.png"));
    _listOfReviews.add(Reviews(name:"Mark Smith",rating:4.8,description:AppStrings.REDEEM_MESSAGE_TEXT,image:"https://iconape.com/wp-content/png_logo_vector/avatar-4.png"));
    _listOfReviews.add(Reviews(name:"John Doe",rating:4.8,description:AppStrings.REDEEM_MESSAGE_TEXT,image:"https://iconape.com/wp-content/png_logo_vector/avatar-4.png"));
    _listOfReviews.add(Reviews(name:"John Doe",rating:4.8,description:AppStrings.REDEEM_MESSAGE_TEXT,image:"https://iconape.com/wp-content/png_logo_vector/avatar-4.png"));
    _listOfReviews.add(Reviews(name:"John Doe",rating:4.8,description:AppStrings.REDEEM_MESSAGE_TEXT,image:"https://iconape.com/wp-content/png_logo_vector/avatar-4.png"));
    _listOfReviews.add(Reviews(name:"Mark Smith",rating:4.8,description:AppStrings.REDEEM_MESSAGE_TEXT,image:"https://iconape.com/wp-content/png_logo_vector/avatar-4.png"));
    _listOfReviews.add(Reviews(name:"Mark Smith",rating:4.8,description:AppStrings.REDEEM_MESSAGE_TEXT,image:"https://iconape.com/wp-content/png_logo_vector/avatar-4.png"));
    _listOfReviews.add(Reviews(name:"John Doe",rating:4.8,description:AppStrings.REDEEM_MESSAGE_TEXT,image:"https://iconape.com/wp-content/png_logo_vector/avatar-4.png"));
    _listOfReviews.add(Reviews(name:"Mark Smith",rating:4.8,description:AppStrings.REDEEM_MESSAGE_TEXT,image:"https://iconape.com/wp-content/png_logo_vector/avatar-4.png"));
    _listOfReviews.add(Reviews(name:"MJohn Doe",rating:4.8,description:AppStrings.REDEEM_MESSAGE_TEXT,image:"https://iconape.com/wp-content/png_logo_vector/avatar-4.png"));
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
        appBar: appBar(title:AppStrings.REVIEWS,onBackClick: (){
          Navigator.of(context).pop();
        },iconColor:AppColors.COLOR_BLACK),
        backgroundColor: AppColors.WHITE_COLOR,
        body: SafeArea(
          child: ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: _listOfReviews.length,
              itemBuilder: (context, index) {

                return NotificationTileView(_listOfReviews[index]);
              }),
        ));

  }

  Widget NotificationTileView(Reviews data){
    return Column(
      children: [

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
          child:divider(),),
        InkWell(
          onTap: (){

          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
            child: Row(
              children: [

                circularAvatar(55.0, 55.0,
                    data.image,
                    30.0),

                SizedBox(width: 10.0,),

                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        data.name,
                        style: AppStyles.blackWithBoldFontTextStyle(context, 16.0).copyWith(color: AppColors.COLOR_BLACK).copyWith(fontWeight: FontWeight.w600)
                      ),

                      SizedBox(height: 6.0,),
                      Row(
                        children: [


                          Icon(
                            Icons.star,
                            size: 14.0,
                            color: AppColors.COLOR_GREEN_RATING,// add custom icons also
                          ),

                          SizedBox(height: 5.0,),

                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              data.rating.toString(),
                              style: AppStyles.blackWithBoldFontTextStyle(context, 14.0).copyWith(color: AppColors.COLOR_GREEN_RATING),
                            ),
                          )
                        ],
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),

        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0,),
          child: Text(
            data.description,
            style: AppStyles.blackWithDifferentFontTextStyle(context, 12.0).copyWith(color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
          ),
        )

      ],
    );
  }



}



