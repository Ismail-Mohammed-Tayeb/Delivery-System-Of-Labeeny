import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/store_controller/category_controller.dart';
import '../../../model/store_related_models/sub_category_model.dart';
import '../../../shared/design_components/custom_circular_progress_indicator/custom_circular_progress_indicator.dart';
import '../../../shared/design_components/custom_elevated_button/custom_elevated_button.dart';
import '../../../shared/design_components/custom_textfield/custom_textfield.dart';
import '../../../shared/size_configuration/size_config.dart';
import '../../../shared/size_configuration/text_sizes.dart';

class RecommendSubCategoryContainer extends StatefulWidget {
  RecommendSubCategoryContainer({Key key}) : super(key: key);

  @override
  _RecommendSubCategoryContainerState createState() =>
      _RecommendSubCategoryContainerState();
}

class _RecommendSubCategoryContainerState
    extends State<RecommendSubCategoryContainer> {
  List<SubCategoryModel> _subCategories;
  String _recommenedSubCategoryName;
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
                    offset: Offset(0, 3))
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
                            height: getProportionateScreenHeight(45),
                          ),
                          Material(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                // color: Colors.red
                              ),
                              width: getProportionateScreenWidth(300),
                              child: CustomTextFeild(
                                // rightContentPadding: 10,
                                // lableText: 'رقم الهاتف',
                                hintText: 'إسم الصنف المقترح',
                                obscureText: false,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                onChanged: (txt) {
                                  // print(txt);
                                  if (txt.trim().length == 0) {
                                    _recommenedSubCategoryName = null;
                                    return;
                                  }
                                  for (SubCategoryModel item
                                      in _subCategories) {
                                    if (txt.trim() == item.subCategoryName) {
                                      print('This Item Already Exists');
                                      //TODO: Show SnackBar That the entered String already Exists in list
                                      _recommenedSubCategoryName = null;
                                      return;
                                    }
                                  }
                                  _recommenedSubCategoryName = txt.trim();
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(20),
                          ),
                          CustomElevatedButton(
                            onPressed: _recommendSubCategory,
                            buttonWidth: 250,
                            buttonheight: 50,
                            child: Text(
                              'تأكيد',
                              style: Theme.of(context)
                                  .textTheme
                                  .button
                                  .copyWith(
                                      fontFamily: 'Almarai',
                                      fontSize: TextSizes.button,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.15),
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(10),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: getProportionateScreenHeight(15)),
                            child: Row(
                              children: [
                                Text(
                                  'الأصناف:',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                          fontFamily: 'Almarai',
                                          fontSize: TextSizes.headline6,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.15),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(15),
                          ),
                          buildListViewOfSubCategories(),
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
              'إقتراح صنف',
              style: Theme.of(context).textTheme.headline6.copyWith(
                    fontFamily: 'Almarai',
                    fontSize: TextSizes.headline5,
                    // color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.15,
                  ),
            ),
          ),
        ),
        // SizedBox(width: 20),
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
        width: double.infinity,
        height: SizeConfiguration.screenHeight,
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 5,
          child: FutureBuilder<List<SubCategoryModel>>(
            future: CategoryController().getSubCategoriesFromCategoryId(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return Center(
                  child: CustomCircularProgressIndicator(),
                );
              }
              //Assign current data to the given list so that no reputation will
              //occur and no database request will be done unless the given string is
              //unique and non repeated among the available data
              _subCategories = snapshot.data;
              if (snapshot.data.length == 0) {
                return Text('لا يوجد أصناف');
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Text(
                        snapshot.data[index].subCategoryName,
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            fontFamily: 'Almarai',
                            fontSize: TextSizes.headline6,
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

  _recommendSubCategory() async {
    print(_recommenedSubCategoryName);
    //TODO: Show SnackBar Here To Say that the input isn't valid
    if (_recommenedSubCategoryName == null) return;
    bool recommendSubCategoryResult = await CategoryController()
        .recommedSubCategory(_recommenedSubCategoryName.trim());
    print('Recommended Sub Category Result $recommendSubCategoryResult');
    //TODO: Show Success SnackBar Here
    if (recommendSubCategoryResult) {
      return;
    }
  }
}

recommendSubCategoryAlertDialog() {
  Get.dialog(
    RecommendSubCategoryContainer(),
    barrierDismissible: true,
  );
}
