import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/widgets/offer_card_widget.dart';
import 'package:ampd/widgets/swipe_cards/swipe_cards.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>  with AutomaticKeepAliveClientMixin<HomeView>{
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  List<String> _names = ["Offer 25% Off", "Offer 15% Off", "\$5 Off", "Offer 20% Off", "\$10 Off"];
  List<String> _itemNames = [
    "Starbucks Triple Mocha",
    "Double Scoop Brownie Sundae",
    "Crispy Chicken Family Bucket",
    "Original's 6 Juice Packs",
    "Red Bull Half Pack"
  ];

  List<String> _backgrounds = [
    "https://papers.co/wallpaper/papers.co-ax29-starbucks-logo-green-illustration-art-40-wallpaper.jpg?download=true",
    "https://1000logos.net/wp-content/uploads/2016/10/Baskin-Robbins-emblem.jpg",
    "https://fsa.zobj.net/crop.php?r=uGpNyI_vMtmX0Dj-46X9O1IF5Sc4TrgIL5X2xYQqXkCO-QfpA6fMZhog9EZe0nkocECPSP7mXs3DQZHJYjmgsdxE2T0EZnDw2xc64kvCCuxBJLoyDo9XQCAD95mgYsf91cMKBUQTxBdJgtW8",
    "https://media.designrush.com/inspiration_images/134933/conversions/_1511456189_555_McDonald's-mobile.jpg",
    "https://wallpaperaccess.com/full/3188912.png"
  ];

  List<String> _offers = [
    AppImages.STARBUCKS_OFFER,
    AppImages.BR_OFFER,
    AppImages.KFC_OFFER,
    AppImages.JUICE_OFFER,
    AppImages.REDBULL_OFFER,
  ];

  List<String> _times = [
    "2021-06-30 09:00:00",
    "2021-07-03 09:00:00",
    "2021-07-05 09:00:00",
    "2021-07-10 09:00:00",
    "2021-06-29 09:00:00",
  ];


  @override
  bool get wantKeepAlive => true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (int i = 0; i < _names.length; i++) {
      _swipeItems.add(SwipeItem(
          content: Content(text: _names[i], offer: _offers[i], offerName: _itemNames[i], time: _times[i], image: _backgrounds[i]),
          likeAction: () {
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text("Liked ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          },
          nopeAction: () {
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text("Nope ${_names[i]}"),
              duration: Duration(milliseconds: 500),
            ));
          },));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }
  @override
  Widget build(BuildContext context) {
    final body = SafeArea(
        child: Container(
//          height: 550,
//        color: Colors.yellow,
          height: double.maxFinite,
          width: double.infinity,
          child: SwipeCards(
            matchEngine: _matchEngine,
            itemBuilder: (BuildContext context, int index) {
              return Container(
//                height: 550.0,
                height: double.maxFinite,
                child: OfferCardWidget(
                  image: _swipeItems[index].content.image,
                  offer: _swipeItems[index].content.offer,
                  offerName: _swipeItems[index].content.offerName,
                  text: _swipeItems[index].content.text,
                  time: _swipeItems[index].content.time,
                ),
              );
            },
            onStackFinished: () {
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text("Stack Finished"),
                duration: Duration(milliseconds: 500),
              ));
            },
          ),
        )
    );

    return Scaffold(
      body: body
    );
  }
}

class Content {
  final String text;
  final String image;
  final String offer;
  final String offerName;
  final String time;
  final Color color;

  Content({this.text, this.image, this.time, this.offer, this.offerName, this.color});
}