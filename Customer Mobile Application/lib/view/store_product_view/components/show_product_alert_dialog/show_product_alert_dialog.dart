import 'package:auto_size_text/auto_size_text.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../../controllers/cart_controller/cart_controller.dart';
import '../../../../controllers/store_related_controllers/store_controller.dart';
import '../../../../controllers/vendor_controller/vendor_controller.dart';
import '../../../../models/cart_product_model.dart';
import '../../../../models/exported_models.dart';
import '../../../../models/vendor_model.dart';
import '../../../../shared/custom_library/counter_widget/counter_widget.dart';
import '../../../../shared/design_components/custom_elevated_button/custom_elevated_button.dart';
import '../../../../shared/design_components/custom_progress_indicator/custom_progress_indicator.dart';
import '../../../../shared/design_components/custom_toast/customSnackBar.dart';
import '../../../../shared/size_configuration/size_config.dart';
import '../../../../shared/size_configuration/text_sizes.dart';

class ProductAlertDialogBody extends StatefulWidget {
  final ProductModel productModel;
  ProductAlertDialogBody({@required this.productModel}) : super();

  @override
  _ProductAlertDialogBodyState createState() => _ProductAlertDialogBodyState();
}

class _ProductAlertDialogBodyState extends State<ProductAlertDialogBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(getProportionateScreenWidth(8)),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(
                getProportionateScreenWidth(20),
              ),
              topLeft: Radius.circular(
                getProportionateScreenWidth(20),
              ),
            ),
          ),
          width: double.infinity,
          // height: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDialogHeader(),
              buildBodyDialog(),
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildBodyDialog() {
    int _productCount = 1;
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.productModel.productName,
              style: Theme.of(context).textTheme.headline5.copyWith(
                    fontFamily: 'Almarai',
                    fontSize: TextSizes.headline5,
                  ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            RichText(
              text: TextSpan(
                text: widget.productModel.productPrice.toString(),
                style: Theme.of(context).textTheme.headline5.copyWith(
                      fontFamily: 'Almarai',
                      fontSize: TextSizes.headline5,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.overline.color,
                    ),
                children: [
                  TextSpan(
                    text: 'SYP',
                    style: Theme.of(context).textTheme.overline.copyWith(
                          fontFamily: 'Almarai',
                          fontSize: TextSizes.caption,
                          fontWeight: FontWeight.bold,
                        ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.maxFinite,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 50,
                  maxWidth: 150,
                ),
                child: AutoSizeText(
                  widget.productModel.productDescription,
                  maxLines: 5,
                  textAlign: TextAlign.center,
                  presetFontSizes: [22, 20, 19, 18, 14],
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontFamily: 'Almarai', fontSize: TextSizes.body2),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            //This means that the given product is a service and shouldn't show buy button
            widget.productModel.productSize == -1
                ? buildBuyServiceWidget()
                : Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CounterWidget(
                          counterCallback: (val) {
                            _productCount = val;
                            print(_productCount);
                          },
                        ),
                        CustomElevatedButton(
                          buttonWidth: 400,
                          buttonheight: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                CommunityMaterialIcons.cart_arrow_down,
                              ),
                              SizedBox(
                                width: getProportionateScreenWidth(5),
                              ),
                              Text(
                                'إضافة للسة',
                                style:
                                    Theme.of(context).textTheme.button.copyWith(
                                          fontFamily: 'Almarai',
                                          fontSize: TextSizes.button,
                                          fontWeight: FontWeight.bold,
                                        ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            bool res = CartController().addProductToList(
                              CartProductModel(
                                productQuantity: _productCount,
                                product: widget.productModel,
                              ),
                            );
                            if (res) {
                              //TODO: Show Snack Bar Here
                              print('Product Added To Cart Successfully');
                              showCustomSnackBar(
                                '',
                                'تم اضافة المنتج للسلة بنجاح',
                                Icon(
                                  CommunityMaterialIcons.check_circle_outline,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                                context,
                              );
                              return;
                            }
                            // TODO: Show SnackBar Here
                            print('Product Already Exists In Cart');
                            showCustomSnackBar(
                              'تنبيه!',
                              'هذا المنتج موجود بالسلة فعلياً إذ كنت تريد زيادة الكمية يمكنك زيارة سلة المشتريات',
                              Icon(
                                CommunityMaterialIcons.alert_circle_outline,
                                color: Theme.of(context).errorColor,
                              ),
                              context,
                            );
                          },
                        )
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget buildBuyServiceWidget() {
    StoreModel currentStoreModel;
    return Expanded(
      child: FutureBuilder<StoreModel>(
        future: StoreController.getStoreById(
            widget.productModel.storeId.toString()),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: CustomCircularProgressIndicator());
          }
          currentStoreModel = snapshot.data;
          return Material(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //TODO: Design Theme Text Here
                  Text(
                    "يعد هذا المنتج خدمة\nيمكنك التواصل مع مزود هذه الخدمة عبر الرقم",
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                          fontFamily: 'Almarai',
                          fontSize: TextSizes.subtitle2,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  FutureBuilder<VendorModel>(
                    future: VendorController.getVendorFromId(
                        currentStoreModel.vendorId),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data == null) {
                        return Text(
                          'جاري التحميل..',
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                                fontFamily: 'Almarai',
                                fontSize: TextSizes.subtitle2,
                              ),
                        );
                      }
                      return Text(
                        currentStoreModel.storeName +
                            ': ${snapshot.data.phoneNumber}',
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              fontFamily: 'Almarai',
                              fontSize: TextSizes.subtitle2,
                            ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Stack buildDialogHeader() {
    return Stack(
      children: [
        Container(
          alignment: Alignment.topRight,
          height: 300,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(
                getProportionateScreenWidth(20),
              ),
              topLeft: Radius.circular(
                getProportionateScreenWidth(20),
              ),
            ),
            image: DecorationImage(
              image: NetworkImage(
                widget.productModel.productImage,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 300,
          width: double.maxFinite,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.transparent,
                Colors.transparent,
                Colors.transparent,
                Colors.black.withOpacity(0.1),
                Colors.black.withOpacity(0.3),
                Colors.black.withOpacity(0.1),
                Colors.black.withOpacity(0.3),
              ],
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                getProportionateScreenWidth(20),
              ),
            ),
          ),
        ),
        Material(
          type: MaterialType.transparency,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).textTheme.button.color,
            ),
            splashRadius: 20,
            onPressed: () {
              navigator.pop();
            },
          ),
        )
      ],
    );
  }
}

showProductAlertDialog(ProductModel productModel) {
  Get.dialog(
    ProductAlertDialogBody(productModel: productModel),
  );
}
