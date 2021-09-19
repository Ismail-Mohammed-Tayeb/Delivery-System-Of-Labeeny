import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../controller/store_controller/store_controller.dart';
import '../../../model/zone_name_model.dart';
import '../../../shared/size_configuration/size_config.dart';
import '../../../shared/size_configuration/text_sizes.dart';

class StoreViewBody extends StatefulWidget {
  StoreViewBody({Key key}) : super(key: key);

  @override
  _StoreViewBodyState createState() => _StoreViewBodyState();
}

class _StoreViewBodyState extends State<StoreViewBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              height: getProportionateScreenHeight(420),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
              ),
              width: double.infinity,
              height: getProportionateScreenHeight(350),
              child: StoreController.gbStoreModel.logoImage == null
                  ? Icon(
                      Icons.store_sharp,
                      size: 70,
                      color: Colors.white,
                    )
                  : Image.network(
                      StoreController.gbStoreModel.bannerImage,
                      fit: BoxFit.cover,
                    ),
            ),
            Positioned(
              top: getProportionateScreenHeight(275),

              ///To make  sure that the logo icon is set to the middle of the screen
              ///we assume that the container is in the half of width minus container size
              right: SizeConfiguration.screenWidth * .5 -
                  (getProportionateScreenHeight(65)),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(55),
                  border: Border.all(
                      color: Theme.of(context).primaryColor, width: 5),
                ),
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).accentColor,
                  radius: getProportionateScreenHeight(65),
                  backgroundImage:
                      StoreController.gbStoreModel.logoImage == null
                          ? null
                          : NetworkImage(
                              StoreController.gbStoreModel.logoImage,
                            ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
            right: getProportionateScreenWidth(10),
            bottom: getProportionateScreenWidth(13),
            top: getProportionateScreenWidth(30),
          ),
          child: Row(
            children: [
              Text(
                'إسم المتجر: ',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontFamily: 'Almarai',
                      fontSize: TextSizes.body1,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                StoreController.gbStoreModel.storeName,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontFamily: 'Almarai',
                      fontSize: TextSizes.body1,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            right: getProportionateScreenWidth(10),
            bottom: getProportionateScreenWidth(13),
          ),
          child: Row(
            children: [
              Text(
                'إقتباس: ',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontFamily: 'Almarai',
                      fontSize: TextSizes.body1,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                StoreController.gbStoreModel.quote,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontFamily: 'Almarai',
                      fontSize: TextSizes.body1,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            right: getProportionateScreenWidth(10),
            bottom: getProportionateScreenWidth(13),
          ),
          child: Row(
            children: [
              Text(
                'عنوان المتجر: ',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontFamily: 'Almarai',
                      fontSize: TextSizes.body1,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              FutureBuilder<ZoneNameModel>(
                future: StoreController.getZoneNameFromId(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.data == null || !snapshot.hasData) {
                    return Text(
                      'جاري التحميل..',
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontFamily: 'Almarai',
                            fontSize: TextSizes.body1,
                            fontWeight: FontWeight.w500,
                          ),
                    );
                  }
                  return Text(
                    snapshot.data.zoneName,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontFamily: 'Almarai',
                          fontSize: TextSizes.body1,
                          fontWeight: FontWeight.w500,
                        ),
                  );
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            right: getProportionateScreenWidth(10),
            bottom: getProportionateScreenWidth(13),
          ),
          child: Row(
            children: [
              Text(
                'تقييم المتجر: ',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontFamily: 'Almarai',
                      fontSize: TextSizes.body1,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              RatingBar.builder(
                initialRating: 4, //TODO: read rate from database
                itemSize: getProportionateScreenWidth(23),
                direction: Axis.horizontal,
                ignoreGestures: true,
                // updateOnDrag: false,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(2)),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Theme.of(context).iconTheme.color,
                ),
                onRatingUpdate: null,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            right: getProportionateScreenWidth(10),
            bottom: getProportionateScreenWidth(13),
          ),
          child: Row(
            children: [
              Text(
                'المردود الشهري: ',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontFamily: 'Almarai',
                      fontSize: TextSizes.body1,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                '20000000 ل.س',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontFamily: 'Almarai',
                      fontSize: TextSizes.body1,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
