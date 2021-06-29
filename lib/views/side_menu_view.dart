import 'package:ampd/appresources/app_styles.dart';
import 'package:flutter/material.dart';

class SideMenuView extends StatefulWidget {
  @override
  _SideMenuViewState createState() => _SideMenuViewState();
}

class _SideMenuViewState extends State<SideMenuView> with AutomaticKeepAliveClientMixin<SideMenuView> {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final body = SafeArea(
        child: Center(
          child: Container(
            child: Text(
              "Side Menu",
              style: AppStyles.blackWithDifferentFontTextStyle(context, 30.0),
            ),
          ),
        )
    );

    return Scaffold(
      body: body,
    );
  }
}
