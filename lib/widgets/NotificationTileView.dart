import 'package:ampd/appresources/app_colors.dart';
import 'package:ampd/appresources/app_strings.dart';
import 'package:ampd/appresources/app_styles.dart';
import 'package:ampd/data/model/OfferModel.dart';
import 'package:ampd/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';

class NotificationTileView extends StatefulWidget {
  Reviews data;
  bool hasTopDivider;

  NotificationTileView({this.data, this.hasTopDivider = true});

  @override
  _NotificationTileViewState createState() => _NotificationTileViewState();
}

class _NotificationTileViewState extends State<NotificationTileView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10.0,
        ),

        widget.hasTopDivider ? divider() : Container(),

        widget.hasTopDivider
            ? SizedBox(
          height: 10.0,
        )
            : Container(),

        InkWell(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
//          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
            child: Row(
              children: [
                circularAvatar(55.0, 55.0, widget.data.image, 30.0),
                SizedBox(
                  width: 10.0,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.data.name,
                          style:
                          AppStyles.blackWithBoldFontTextStyle(context, 15.0)
                              .copyWith(color: AppColors.COLOR_BLACK)
                              .copyWith(fontWeight: FontWeight.w600)),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
//                        Icon(
//                          Icons.star,
//                          size: 14.0,
//                          color: AppColors.COLOR_GREEN_RATING,// add custom icons also
//                        ),

                          Icon(
                            FontAwesomeIcons.solidStar,
                            color: AppColors.GREEN_BRIGHT_COLOR,
                            size: 10.0,
                          ),

                          SizedBox(
                            width: 3.0,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              widget.data.rating.toString(),
                              style: AppStyles.blackWithBoldFontTextStyle(
                                  context, 13.0)
                                  .copyWith(color: AppColors.COLOR_GREEN_RATING),
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

//      Padding(
//        padding: EdgeInsets.symmetric(horizontal: 0.0,),
//        child: Text(
//          data.description,
//          style: AppStyles.blackWithDifferentFontTextStyle(context, 12.0).copyWith(color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
//        ),
//      ),

        ReadMoreText(
          widget.data.review,
          // "This is dummy copy. It is not meant to be read. It has been placed here solely to demonstrate the look and feel of finished, typeset text. It is not meant to be read. It has been placed here solely to demonstrate the look and feel of finished, typeset text.",
          trimCollapsedText: AppStrings.READ_MORE,
          trimExpandedText: AppStrings.READ_LESS,
          trimLines: 2,
          textAlign: TextAlign.start,
          trimMode: TrimMode.Line,
//        delimiter: ".",
          style: AppStyles.blackWithDifferentFontTextStyle(context, 10.0.sp)
              .copyWith(color: AppColors.APP__DETAILS_TEXT_COLOR_LIGHT),
        ),

        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}
