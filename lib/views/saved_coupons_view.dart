import 'package:ampd/appresources/app_styles.dart';
import 'package:flutter/material.dart';

class SavedCouponsView extends StatefulWidget {
  @override
  _SavedCouponsViewState createState() => _SavedCouponsViewState();
}

class _SavedCouponsViewState extends State<SavedCouponsView>  with AutomaticKeepAliveClientMixin<SavedCouponsView>{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.yellow,
        child: Text(
          "Saved Coupons",
          style: AppStyles.blackWithDifferentFontTextStyle(context, 30.0),
        ),
      ),
    );
  }
}
