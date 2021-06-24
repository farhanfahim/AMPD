import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/widgets/offer_card_widget.dart';
import 'package:ampd/widgets/swipe_cards/swipe_cards.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  List<String> _names = ["Offer 25% Off", "Offer 15% Off", "\$5 Off", "Offer 20% Off", "\$10 Off"];
  List<String> _backgrounds = [
    "https://i.pinimg.com/originals/50/2e/75/502e75acb506f2ee8c3cdbf788b951f1.jpg",
    "https://1000logos.net/wp-content/uploads/2016/10/Baskin-Robbins-emblem.jpg",
    "https://fsa.zobj.net/crop.php?r=uGpNyI_vMtmX0Dj-46X9O1IF5Sc4TrgIL5X2xYQqXkCO-QfpA6fMZhog9EZe0nkocECPSP7mXs3DQZHJYjmgsdxE2T0EZnDw2xc64kvCCuxBJLoyDo9XQCAD95mgYsf91cMKBUQTxBdJgtW8",
    "https://media.designrush.com/inspiration_images/134933/conversions/_1511456189_555_McDonald's-mobile.jpg",
    "https://wallpaperaccess.com/full/3188912.png"
  ];
  List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (int i = 0; i < _names.length; i++) {
      _swipeItems.add(SwipeItem(
          content: Content(text: _names[i], image: _backgrounds[i], color: _colors[i]),
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
          height: 550,
          width: double.infinity,
          child: SwipeCards(
            matchEngine: _matchEngine,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.zero,
                child: OfferCardWidget(
                  image: _swipeItems[index].content.image,
                  color: _swipeItems[index].content.color,
                  text: _swipeItems[index].content.text,
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
  final Color color;

  Content({this.text, this.image, this.color});
}