import 'package:flutter/material.dart';

import '../../../../controllers/category_controllers/category_controller.dart';
import '../../../../models/category_model.dart';
import '../../../../shared/design_components/custom_progress_indicator/custom_progress_indicator.dart';
import '../../../../shared/design_components/main_category_item/main_category_item.dart';
import '../../../../shared/size_configuration/size_config.dart';

class MainVategoryViewBody extends StatefulWidget {
  MainVategoryViewBody({Key key}) : super(key: key);

  @override
  _MainVategoryViewBodyState createState() => _MainVategoryViewBodyState();
}

class _MainVategoryViewBodyState extends State<MainVategoryViewBody> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoryModel>>(
      future: CategoryController().getAllCategories(),
      builder: (context, snapshot) {
        if (snapshot.data == null || !snapshot.hasData) {
          return Center(
            //TODO: Theme CustomCircularProgressBar
            child: CustomCircularProgressIndicator(),
          );
        }
        return GridView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: snapshot.data.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: getProportionateScreenWidth(20)),
              child: Container(
                width: getProportionateScreenWidth(375),
                child: MainCategoryItem(
                  categoryModel: snapshot.data[index],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
