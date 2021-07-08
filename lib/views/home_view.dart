import 'package:ampd/app/app_routes.dart';
import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_images.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/utils/ToastUtil.dart';
import 'package:ampd/widgets/dialog_view.dart';
import 'package:ampd/widgets/gradient_button.dart';
import 'package:ampd/widgets/offer_card_widget.dart';
import 'package:ampd/widgets/swipe_cards/swipe_cards.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:sizer/sizer.dart';

class HomeView extends StatefulWidget {
  bool isGuestLogin;

  HomeView(this.isGuestLogin);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>  with AutomaticKeepAliveClientMixin<HomeView>{

  String _appBarTitle = 'Home';
  bool _stackFinished = false;
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
    "2021-07-03 09:00:00",
    "2021-07-05 09:00:00",
    "2021-07-10 09:00:00",
    "2021-06-29 09:00:00",
    "2021-07-29 09:00:00",
  ];

  List<Coords> _locations = [
    Coords(40.7565007, -73.986803),
    Coords(24.3035846, 54.1169487),
    Coords(24.8328199, 66.9334615),
    Coords(24.8326894, 66.9334608),
    Coords(24.8325588, 66.9334601),
  ];

  List<String> _locationTitle = [
    "Starbucks",
    "Baskin-Robbins",
    "KFC",
    "Mc Donalds",
    "Pizza Hut",
  ];


  @override
  bool get wantKeepAlive => true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    for (int i = 0; i < _names.length; i++) {
      _swipeItems.add(SwipeItem(
          content: Content(text: _names[i], offer: _offers[i], offerName: _itemNames[i], time: _times[i], image: _backgrounds[i], coord: _locations[i], locationTitle: _locationTitle[i]),
          likeAction: () {
          if (!widget.isGuestLogin) {
            showDialog(
                context: context,
                builder: (BuildContext context1) {
                  return CustomDialog(
                    contex: context,
                    subTitle: "This offer has been marked Favorite!",
                    child: SvgPicture.asset(AppImages.FAV_ICON),
                    //title: "Your feedback will help us improve our services.",
                    buttonText1: AppStrings.REDEEM_NOW,
                    buttonText2: AppStrings.GO_BACK_TO_OFFER,
                    onPressed1: () {
                      Navigator.pop(context1);
                      showDialog(
                          context: context,
                          builder: (BuildContext context1) {
                            return CustomDialog(
                              contex: context,
                              subTitle: "Are you sure?",
                              //title: "Your feedback will help us improve our services.",
                              buttonText1: AppStrings.YES,
                              buttonText2: AppStrings.NO,
                              onPressed1: () {
                                Navigator.pop(context1);
                              },
                              onPressed2: () {
                                Navigator.pop(context1);
                              },
                              showImage: false,
                            );
                          });                  },
                    onPressed2: () {
                      Navigator.pop(context1);
                    },
                    showImage: true,
                  );
                });
          } else {
            Navigator.pushNamed(context, AppRoutes.SIGN_IN_VIEW);
          }
        },
          nopeAction: () {
            if(widget.isGuestLogin) {
              Navigator.pushNamed(context, AppRoutes.SIGN_IN_VIEW);
            }
//            ToastUtil.showToast(context, "Disliked ${_names[i]}");
          },));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }

  @override
  Widget build(BuildContext context) {
    final appBar1 = appBar(
        title: _appBarTitle, onBackClick: (){
      Navigator.of(context).pop();
    },
        iconColor:AppColors.WHITE_COLOR,
        hasLeading: false
    );

    final body = SafeArea(
        child: !_stackFinished? Container(
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
                  coord: _swipeItems[index].content.coord,
                  locationTitle: _swipeItems[index].content.locationTitle,
                  changeDetailTitle: (value) {
                    setState(() {
                      if(value) {
                        _appBarTitle = 'Offer Details';
                      } else {
                        _appBarTitle = 'Home';
                      }
                    });
                  },
                ),
              );
            },
            onStackFinished: () {
              setState(() {
                _stackFinished = true;
                _appBarTitle = 'Home';
              });
            },
          ),
        ) : Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Opacity(
                  opacity: 0.3,
                  child: SvgPicture.asset(AppImages.IC_COUPONS, width: 110.0, height: 110.0,)
                ),

                SizedBox(height: 10.0,),

                Text(
                  'No more coupons left',
                  style: AppStyles.poppinsTextStyle(fontSize: 18.0, weight: FontWeight.w500).copyWith(color: AppColors.UNSELECTED_COLOR),
                ),

                SizedBox(height: 30.0,),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25.0.w),
                  child: GradientButton(
                    onTap: () {
//                      print('length ${_swipeItems.length}');
                      _matchEngine = MatchEngine(swipeItems: _swipeItems);
//                      print('length ${_matchEngine.currentItem}');
                      _matchEngine.rewindMatch();
                      setState(() {
                        _stackFinished = false;
                      });
                    },
                    text: "Fetch More",
                  ),
                )
              ],
            ),
          ),
        )
    );

    return Scaffold(
      appBar: appBar1,
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
  final String locationTitle;
  final Coords coord;

  Content({this.text, this.image, this.time, this.offer, this.offerName, this.coord, this.locationTitle});
}