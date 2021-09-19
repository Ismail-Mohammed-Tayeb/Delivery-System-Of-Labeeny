import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../../controllers/delivery_boy_controller/delivery_boy_controller.dart';
import '../../../models/delivery_boy_model.dart';
import '../../../shared/design_components/custom_elevated_button/custom_elevated_button.dart';
import '../../../shared/size_configuration/size_config.dart';
import '../../../shared/size_configuration/text_sizes.dart';
import '../../wrapper_view/wrapper_view.dart';

class RateDeliveryBoyViewBody extends StatefulWidget {
  final DeliveryBoyModel deliveryBoy;
  RateDeliveryBoyViewBody({@required this.deliveryBoy}) : super();

  @override
  _RateDeliveryBoyViewBodyState createState() =>
      _RateDeliveryBoyViewBodyState();
}

class _RateDeliveryBoyViewBodyState extends State<RateDeliveryBoyViewBody> {
  double _customerRatingVal;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: getProportionateScreenWidth(300),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          textDirection: TextDirection.rtl,
          children: [
            buildProfileImageAvatar(),
            Text(
              widget.deliveryBoy.name,
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontFamily: 'Almarai',
                    fontSize: TextSizes.body1,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.15,
                  ),
            ),
            SizedBox(
              height: getProportionateScreenWidth(100),
            ),
            Text(
              'تقييمك للسائق:',
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontFamily: 'Almarai',
                    fontSize: TextSizes.body1,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.15,
                  ),
            ),
            RatingBar.builder(
              initialRating: widget.deliveryBoy.rating,
              itemSize: getProportionateScreenWidth(50),
              direction: Axis.horizontal,
              ignoreGestures: false,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(2),
              ),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Theme.of(context).accentColor,
              ),
              onRatingUpdate: (rate) {
                _customerRatingVal = rate;
              },
            ),
            CustomElevatedButton(
              child: Text(
                'تأكيد',
                style: Theme.of(context).textTheme.button.copyWith(
                      fontFamily: 'Almarai',
                      fontSize: TextSizes.button,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              onPressed: _rateDeliveryBoy,
              buttonheight: 53.3,
              buttonWidth: double.infinity,
            ),
            SizedBox(
              height: getProportionateScreenWidth(40),
            )
          ],
        ),
      ),
    );
  }

  Widget buildProfileImageAvatar({bool isEditing}) {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).accentColor,
            radius: getProportionateScreenHeight(130),
            child: Container(
              width: getProportionateScreenHeight(250),
              height: getProportionateScreenHeight(250),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    widget.deliveryBoy.portraitImageURL,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _rateDeliveryBoy() async {
    if (_customerRatingVal == null) {
      //TODO: Design Show Custom Toast Error
      return;
    }
    double newRating =
        ((widget.deliveryBoy.rating * widget.deliveryBoy.numberOfPeopleRating) +
                (_customerRatingVal)) /
            (widget.deliveryBoy.numberOfPeopleRating + 1);
    bool ratingRes = await DeliveryBoyController.rateDeliveryBoy(
      widget.deliveryBoy.userId,
      newRating,
      (widget.deliveryBoy.numberOfPeopleRating + 1),
    );
    if (ratingRes != null && ratingRes == true) {
      // TODO: Desing Show Toast Saying that the rating was done successfully
      print('Rating Done Successfully');
      navigator.pushReplacementNamed(WrapperView.routeName);

      return;
    }
    // TODO: Desing Show Toast Saying that the rating failed
    print('Rating Failed');
  }
}
