import 'dart:io';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controller/product_controllers/product_management_controller.dart';
import '../../../controller/store_controller/category_controller.dart';
import '../../../controller/store_controller/store_controller.dart';
import '../../../model/store_related_models/product_model.dart';
import '../../../model/store_related_models/sub_category_model.dart';
import '../../../shared/design_components/custom_circular_progress_indicator/custom_circular_progress_indicator.dart';
import '../../../shared/design_components/custom_elevated_button/custom_elevated_button.dart';
import '../../../shared/design_components/custom_lookslike_container/custom_lookslike_container.dart';
import '../../../shared/design_components/custom_textfield/custom_textfield.dart';
import '../../../shared/size_configuration/size_config.dart';
import '../../../shared/size_configuration/text_sizes.dart';

class AddProductContainer extends StatefulWidget {
  AddProductContainer() : super();

  @override
  _AddProductContainerState createState() => _AddProductContainerState();
}

class _AddProductContainerState extends State<AddProductContainer> {
  String _productName;
  //Remember to parse string here so that the given value for the model is correct
  double _productPrice;
  String _productDescription;
  int _productSize = CustomLookLikeContainer.currentPage;
  int _selectedSubCategoryIndex = -1;
  bool _isService = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(getProportionateScreenWidth(5)),
        child: Container(
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                )
              ],
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(
                  getProportionateScreenWidth(20),
                ),
                topLeft: Radius.circular(
                  getProportionateScreenWidth(20),
                ),
              ),
              border: Border.all(color: Theme.of(context).accentColor)),
          width: double.infinity,
          height: double.infinity,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                buildHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          Center(
                            child: Stack(
                              children: [
                                Container(
                                  width: getProportionateScreenHeight(300),
                                  height: getProportionateScreenHeight(300),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(.8),
                                    shape: BoxShape.circle,
                                    image: _productImage == null
                                        ? null
                                        : DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(_productImage),
                                          ),
                                  ),
                                  child: _productImage == null
                                      ? Icon(
                                          Icons.add_a_photo_outlined,
                                          color: Theme.of(context).primaryColor,
                                          size:
                                              getProportionateScreenHeight(200),
                                        )
                                      : null,
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: ElevatedButton(
                                    onPressed: _getImageFromImagePicker,
                                    child: Icon(Icons.camera_alt_rounded),
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: Container(
                              width: getProportionateScreenWidth(250),
                              child: CustomTextFeild(
                                hintText: 'إسم المنتج',
                                obscureText: false,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                onChanged: (txt) {
                                  if (txt.trim().length == 0) {
                                    _productName = null;
                                    return;
                                  }
                                  _productName = txt.trim();
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: Container(
                              width: getProportionateScreenWidth(250),
                              child: CustomTextFeild(
                                hintText: 'سعر المنتج',
                                obscureText: false,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                onChanged: (txt) {
                                  if (txt.trim().length == 0) {
                                    _productPrice = null;
                                    return;
                                  }
                                  _productPrice = double.parse(txt.trim());
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: Container(
                              width: getProportionateScreenWidth(250),
                              child: CustomTextFeild(
                                maxLine: null,
                                hintText: 'وصف المنتج',
                                obscureText: false,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.multiline,
                                onChanged: (txt) {
                                  if (txt.trim().length == 0) {
                                    _productDescription = null;
                                    return;
                                  }
                                  _productDescription = txt.trim();
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _isService = !_isService;
                                });
                              },
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Checkbox(
                                        value: _isService,
                                        onChanged: (val) {
                                          setState(() {
                                            _isService = val;
                                          });
                                        }),
                                    Text(
                                      'أنا أقدم خدمة',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .copyWith(
                                            fontFamily: 'Almarai',
                                            fontSize: TextSizes.headline6,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.15,
                                          ),
                                    ),
                                  ]),
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),
                          _isService
                              ? SizedBox.shrink()
                              : CustomLookLikeContainer(),
                          SizedBox(height: getProportionateScreenHeight(10)),
                          Text(
                            'الرجاء إختيار الصنف العام قبل الإضافة:',
                            style:
                                Theme.of(context).textTheme.headline6.copyWith(
                                      fontFamily: 'Almarai',
                                      fontSize: TextSizes.headline6,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.15,
                                    ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(15)),
                          buildListViewOfSubCategories(),
                          SizedBox(height: getProportionateScreenHeight(30)),
                          CustomElevatedButton(
                            onPressed: _addProduct,
                            buttonWidth: 250,
                            buttonheight: 50,
                            child: Text(
                              'إضافة',
                              style:
                                  Theme.of(context).textTheme.button.copyWith(
                                        fontFamily: 'Almarai',
                                        fontSize: TextSizes.button,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.15,
                                      ),
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(30)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Stack buildHeader() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(
                top: getProportionateScreenWidth(15),
                bottom: getProportionateScreenWidth(15)),
            child: Text(
              'إضافة منتج/خدمة جديدة',
              style: Theme.of(context).textTheme.headline6.copyWith(
                    fontFamily: 'Almarai',
                    fontSize: TextSizes.headline6,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.15,
                  ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(top: getProportionateScreenWidth(10)),
            child: GestureDetector(
              onTap: () {
                navigator.pop();
              },
              child: Icon(
                Icons.chevron_left_sharp,
                size: 40,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Material buildListViewOfSubCategories() {
    return Material(
      child: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.2),
            blurRadius: 3,
            offset: Offset(3, 3),
            spreadRadius: 4,
          )
        ]),
        width: double.infinity,
        height: getProportionateScreenHeight(300),
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 0,
          child: FutureBuilder<List<SubCategoryModel>>(
            future: CategoryController().getSubCategoriesFromCategoryId(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return Center(
                  child: CustomCircularProgressIndicator(),
                );
              }
              if (snapshot.data.length == 0) {
                setState(() {
                  _selectedSubCategoryIndex = -1;
                });
                return Text('لا يوجد أصناف');
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    trailing: Icon(
                      _selectedSubCategoryIndex ==
                              snapshot.data[index].subCategoryId
                          ? CommunityMaterialIcons.circle
                          : CommunityMaterialIcons.circle_outline,
                      color: Theme.of(context).accentColor,
                    ),
                    onTap: () {
                      setState(() {
                        _selectedSubCategoryIndex =
                            snapshot.data[index].subCategoryId;
                      });
                    },
                    title: Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Text(
                        snapshot.data[index].subCategoryName,
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            fontFamily: 'Almarai',
                            fontSize: TextSizes.headline5,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.15),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  //This is the helping method to get the image from gallery or camera
  File _productImage;
  final picker = ImagePicker();

  void _getImageFromImagePicker() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _productImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _addProduct() async {
    ProductModel toAdd;
    if (_productName == null ||
        _productPrice == null ||
        _productDescription == null ||
        _selectedSubCategoryIndex == -1 ||
        _productImage == null) {
      print('Something Is Null');
      return;
    }

    _productSize = CustomLookLikeContainer.currentPage;
    toAdd = ProductModel(
      subCategoryId: _selectedSubCategoryIndex,
      storeId: StoreController.gbStoreModel.storeId,
      productName: _productName,
      productDescription: _productDescription,
      productPrice: _productPrice,
      productSize: _isService ? -1 : _productSize,
    );
    bool res =
        await ProductManagementController().addProduct(toAdd, _productImage);
    print("$res");
    if (res) {
      Navigator.pop(context);
      return;
    }
    //TODO: toast show error
  }
}

addProductAlertDialog() {
  Get.dialog(
    AddProductContainer(),
    barrierDismissible: true,
  );
}
