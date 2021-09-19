import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../../controllers/cart_controller/cart_controller.dart';
import '../../../controllers/location_controllers/geo_location_controller.dart';
import '../../../controllers/store_related_controllers/store_controller.dart';
import '../../../models/cart_product_model.dart';
import '../../../models/exported_models.dart';
import '../../../shared/custom_library/counter_widget/counter_widget.dart';
import '../../../shared/design_components/custom_elevated_button/custom_elevated_button.dart';
import '../../../shared/design_components/custom_outlined_button/custom_outlined_button.dart';
import '../../../shared/design_components/custom_progress_indicator/custom_progress_indicator.dart';
import '../../../shared/design_components/custom_textfield/custom_textfield.dart';
import '../../../shared/design_components/custom_toast/customSnackBar.dart';
import '../../../shared/size_configuration/size_config.dart';
import '../../../shared/size_configuration/text_sizes.dart';

class CartViewBody extends StatefulWidget {
  CartViewBody() : super();

  @override
  _CartViewBodyState createState() => _CartViewBodyState();
}

class _CartViewBodyState extends State<CartViewBody> {
  String orderNotes;
  @override
  Widget build(BuildContext context) {
    bool isExpandedd = false;
    return Obx(
      () {
        if (CartController.currentCart.isEmpty) {
          return Container(
            height: SizeConfiguration.screenHeight * .8,
            width: double.infinity,
            child: Center(
              child: Text(
                'السلة فارغة 😫',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontFamily: 'Almarai',
                    fontSize: TextSizes.button,
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ExpansionTile(
                collapsedIconColor: Theme.of(context).iconTheme.color,
                iconColor: Theme.of(context).iconTheme.color,
                backgroundColor: Colors.transparent,
                maintainState: true,
                initiallyExpanded: true,
                childrenPadding: EdgeInsets.all(getProportionateScreenWidth(8)),
                onExpansionChanged: (isExpanded) {
                  setState(() {
                    isExpandedd = isExpanded;
                  });
                },
                title: buildStoreNameText(),
                children: [
                  // Obx Is Used Here to make sure that the cart is automatically
                  // Updated With any products that are added to the cart
                  Container(
                    width: double.infinity,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: CartController.currentCart.length,
                      itemBuilder: (context, index) {
                        return buildCartItem(CartController.currentCart[index]);
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(20)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'إجمالي الفاتورة',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                              fontFamily: 'Almarai',
                              fontSize: TextSizes.subtitle1,
                              fontWeight: FontWeight.bold),
                          textDirection: TextDirection.rtl,
                        ),
                        Text(
                          ': ',
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              fontFamily: 'Almarai',
                              fontSize: TextSizes.headline6,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.15),
                        ),
                        RichText(
                          text: TextSpan(
                              text: 'SYP ',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                    fontFamily: 'Almarai',
                                    fontSize: TextSizes.overline,
                                    fontWeight: FontWeight.bold,
                                  ),
                              children: [
                                TextSpan(
                                  text: CartController.getTotalCartPrice()
                                      .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(
                                        fontFamily: 'Almarai',
                                        fontSize: TextSizes.subtitle2,
                                        fontWeight: FontWeight.bold,
                                      ),
                                )
                              ]),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenWidth(5),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() {
                          String locationName = GeoLocationApiController
                                      .currentLocationName.value
                                      .trim()
                                      .length ==
                                  0
                              ? 'لم يتم تحديد موقع'
                              : GeoLocationApiController
                                  .currentLocationName.value;
                          return Row(
                            children: [
                              Text(
                                'الموقع المختار: ',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                        fontFamily: 'Almarai',
                                        fontSize: TextSizes.subtitle1,
                                        fontWeight: FontWeight.bold),
                                textDirection: TextDirection.rtl,
                              ),
                              Text(
                                locationName,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(
                                      fontFamily: 'Almarai',
                                      fontSize: TextSizes.subtitle2,
                                      fontWeight: FontWeight.bold,
                                    ),
                              )
                            ],
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
              CustomTextFeild(
                hintText: 'يرجى إدخال أي ملاحظات حول الطلب هنا إن وجدت',
                onChanged: (txt) {
                  if (txt.trim().length == 0) {
                    orderNotes = null;
                    return;
                  }
                  orderNotes = txt.trim();
                },
                maxLines: null,
                maxLength: 200,
              ),
              CustomElevatedButton(
                buttonWidth: 400,
                buttonheight: 50,
                child: Text(
                  'شراء',
                  style: Theme.of(context).textTheme.button.copyWith(
                        fontFamily: 'Almarai',
                        fontSize: TextSizes.button,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                onPressed: _submitOrder,
              ),
              SizedBox(height: getProportionateScreenHeight(15)),
              CustomOutlinedButton(
                buttonWidth: 400,
                buttonheight: 50,
                child: Text(
                  'حذف عناصر السلة',
                  style: Theme.of(context).textTheme.button.copyWith(
                      fontFamily: 'Almarai',
                      fontSize: TextSizes.button,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).iconTheme.color),
                ), //functional code for buying
                onPressed: () {
                  CartController().clearProductsFromCart();
                                                 showCustomSnackBar(
        '',
        'تم حذف المنجات من السلة',
       Icon(
            CommunityMaterialIcons.check_circle_outline,
            color: Theme.of(context).iconTheme.color,
          ),
        context,
      );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  FutureBuilder<StoreModel> buildStoreNameText() {
    return FutureBuilder<StoreModel>(
      future: StoreController.getStoreById(
        CartController.currentCart[0].product.storeId.toString(),
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: CustomCircularProgressIndicator());
        }
        return Text(
          snapshot.data.storeName,
          style: Theme.of(context).textTheme.headline6.copyWith(
                fontFamily: 'Almarai',
                fontSize: TextSizes.headline6,
                fontWeight: FontWeight.bold,
              ),
          textDirection: TextDirection.rtl,
        );
      },
    );
  }

  Widget buildCartItem(CartProductModel cartProductModel) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: getProportionateScreenHeight(10),
      ),
      child: Stack(
        children: [
          Slidable(
            secondaryActions: [
              IconSlideAction(
                color: Theme.of(context).primaryColor,
                iconWidget: Icon(
                  CommunityMaterialIcons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onTap: () {
                  CartController()
                      .removeProduct(cartProductModel.product.productId);
                },
              ),
            ],
            actions: [
              IconSlideAction(
                color: Theme.of(context).primaryColor,
                iconWidget: Icon(
                  CommunityMaterialIcons.delete,
                  color: Theme.of(context).errorColor,
                ),
                onTap: () {
                  CartController()
                      .removeProduct(cartProductModel.product.productId);
                },
              ),
            ],
            actionPane: SlidableDrawerActionPane(),
            child: Container(
              width: double.infinity,
              height: getProportionateScreenWidth(140),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(
                  getProportionateScreenWidth(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    offset: Offset(0, 1),
                    blurRadius: 2.5,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                textDirection: TextDirection.rtl,
                children: [
                  Expanded(
                    flex: 0,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.bottomCenter,
                          width: getProportionateScreenWidth(140),
                          height: getProportionateScreenWidth(140),
                          decoration: BoxDecoration(
                            // color: Colors.transparent,
                            borderRadius: BorderRadiusDirectional.only(
                              topEnd: Radius.circular(
                                getProportionateScreenWidth(25),
                              ),
                              bottomEnd: Radius.circular(
                                getProportionateScreenWidth(25),
                              ),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(
                                  cartProductModel.product.productImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            height: getProportionateScreenWidth(25),
                            child: CounterWidget(
                              initNumber: cartProductModel.productQuantity,
                              counterCallback: (counterVal) {
                                CartController()
                                    .makeNewQuantityToExistingProductInCart(
                                        cartProductModel.product.productId,
                                        counterVal);
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(getProportionateScreenWidth(7)),
                      width: getProportionateScreenWidth(240),
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(
                            getProportionateScreenWidth(25),
                          ),
                          bottomStart: Radius.circular(
                            getProportionateScreenWidth(25),
                          ),
                        ),
                      ),
                      child: Column(
                        textDirection: TextDirection.rtl,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cartProductModel.product.productName,
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      fontFamily: 'Almarai',
                                      fontSize: TextSizes.body1,
                                      fontWeight: FontWeight.bold,
                                    ),
                            textDirection: TextDirection.rtl,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            cartProductModel.product.productDescription,
                            style:
                                Theme.of(context).textTheme.subtitle2.copyWith(
                                      fontFamily: 'Almarai',
                                      fontSize: TextSizes.subtitle2,
                                    ),
                            textDirection: TextDirection.rtl,
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Text(
                                'سعر القطعة',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                        fontFamily: 'Almarai',
                                        fontSize: TextSizes.subtitle1,
                                        fontWeight: FontWeight.bold),
                                textDirection: TextDirection.rtl,
                              ),
                              Text(
                                ': ',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(
                                        fontFamily: 'Almarai',
                                        fontSize: TextSizes.headline6,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.15),
                              ),
                              RichText(
                                text: TextSpan(
                                    text: 'SYP ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .copyWith(
                                          fontFamily: 'Almarai',
                                          fontSize: TextSizes.overline,
                                          fontWeight: FontWeight.bold,
                                        ),
                                    children: [
                                      TextSpan(
                                        text: cartProductModel
                                            .product.productPrice
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            .copyWith(
                                              fontFamily: 'Almarai',
                                              fontSize: TextSizes.subtitle2,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      )
                                    ]),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'الإجمالي',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                        fontFamily: 'Almarai',
                                        fontSize: TextSizes.subtitle1,
                                        fontWeight: FontWeight.bold),
                              ),
                              Text(
                                ': ',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(
                                        fontFamily: 'Almarai',
                                        fontSize: TextSizes.headline6,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.15),
                              ),
                              RichText(
                                text: TextSpan(
                                    text: 'SYP ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .copyWith(
                                          fontFamily: 'Almarai',
                                          fontSize: TextSizes.overline,
                                          fontWeight: FontWeight.bold,
                                        ),
                                    children: [
                                      TextSpan(
                                        text: (cartProductModel
                                                    .product.productPrice *
                                                cartProductModel
                                                    .productQuantity)
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            .copyWith(
                                              fontFamily: 'Almarai',
                                              fontSize: TextSizes.subtitle2,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      )
                                    ]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _submitOrder() async {
    bool submittionResult =
        await CartController.submitOrderToDatabse(orderNotes);
    if (submittionResult) {
      showCustomSnackBar(
        'تمت عملية الطلب بنجاح',
        'يمكنك التوجه الى صفحة طلباتي للتأكد من حالة الطلب',
        Icon(
          Icons.check,
          color: Theme.of(context).accentColor,
          size: getProportionateScreenWidth(35),
        ),
        context,
      );
      return;
    }
    showCustomSnackBar(
      ' حدث خطأ أثناء عملية الطلب',
      'يرجى إعادة المحاولة والتأكد من إتصالك بالشبكة',
      Icon(
        Icons.error,
        color: Theme.of(context).errorColor,
        size: getProportionateScreenWidth(35),
      ),
      context,
    );
  }
}
