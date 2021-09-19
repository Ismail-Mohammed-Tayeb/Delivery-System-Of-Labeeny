import 'package:auto_size_text/auto_size_text.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../size_configuration/size_config.dart';
import '../../size_configuration/text_sizes.dart';

class CustomFirstSubCategoryItem extends StatefulWidget {
  final String routeName;
  CustomFirstSubCategoryItem({@required this.routeName}) : super();

  @override
  _CustomFirstSubCategoryItemState createState() =>
      _CustomFirstSubCategoryItemState();
}

class _CustomFirstSubCategoryItemState
    extends State<CustomFirstSubCategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.bottomRight,
          width: getProportionateScreenWidth(375),
          height: getProportionateScreenHeight(400),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    offset: Offset(0, 1),
                    blurRadius: 2.5),
              ],
              borderRadius:
                  BorderRadius.circular(getProportionateScreenWidth(25))),
          child: Container(
            width: getProportionateScreenWidth(375),
            height: getProportionateScreenHeight(100),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(
                    getProportionateScreenWidth(25),
                  ),
                  topStart: Radius.circular(
                    getProportionateScreenWidth(25),
                  ),
                )),
            child: Padding(
              padding: EdgeInsets.all(getProportionateScreenWidth(8.0)),
              child: Row(
                textDirection: TextDirection.rtl,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      textDirection: TextDirection.rtl,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'فاير مان', //TODO: Nmae subCategory Functional
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontFamily: 'Almarai',
                              fontSize: TextSizes.body1,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.15),
                        ),
                        AutoSizeText(
                          'أشهى المأكولات الغربية', //TODO: subtitles subCategory Functional
                          textDirection: TextDirection.rtl,
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                              fontFamily: 'Almarai',
                              fontSize: TextSizes.subtitle1,
                              fontWeight: FontWeight.w100,
                              letterSpacing: 0.15),
                          maxLines: 1,
                          minFontSize: 14,
                          stepGranularity: 14, wrapWords: false,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                  Column(
                    textDirection: TextDirection.rtl,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        textDirection: TextDirection.rtl,
                        children: [
                          Icon(
                            CommunityMaterialIcons.star_outline,
                            size: getProportionateScreenWidth(22),
                            textDirection: TextDirection.rtl,
                          ),
                          SizedBox(
                            width: getProportionateScreenWidth(5),
                          ),
                          Text(
                            '4.5', //TODO: Rating subCategory
                            textDirection: TextDirection.rtl,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(
                                    fontFamily: 'Almarai',
                                    fontSize: TextSizes.subtitle1,
                                    fontWeight: FontWeight.normal,
                                    letterSpacing: 0.15),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        textDirection: TextDirection.rtl,
                        children: [
                          Icon(
                            CommunityMaterialIcons.truck_fast_outline, ////TODO: outline icons
                            size: getProportionateScreenWidth(22),
                            textDirection: TextDirection.rtl,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            '0.6 كم ', //TODO : destinationKM subCategory Functional
                            textDirection: TextDirection.rtl,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(
                                    fontFamily: 'Almarai',
                                    fontSize: TextSizes.subtitle1,
                                    fontWeight: FontWeight.normal,
                                    letterSpacing: 0.15),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Container(
          width: getProportionateScreenWidth(375),
          height: getProportionateScreenHeight(300),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    offset: Offset(0, 1),
                    blurRadius: 2.5),
              ],
              image: DecorationImage(
                image: NetworkImage(
                    'https://www.foodserviceweb.it/wp-content/uploads/sites/4/2020/09/SPECKTACULAR.jpg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadiusDirectional.only(
                topEnd: Radius.circular(
                  getProportionateScreenWidth(25),
                ),
                topStart: Radius.circular(
                  getProportionateScreenWidth(25),
                ),
              )),
        ),
        Positioned(
          child: SizedBox(
            width: getProportionateScreenWidth(375),
            height: getProportionateScreenHeight(400),
            child: Material(
              type: MaterialType.transparency,
              borderRadius:
                  BorderRadius.circular(getProportionateScreenWidth(25)),
              child: InkWell(
                  splashColor: Theme.of(context).accentColor.withOpacity(.08),
                  highlightColor:
                      Theme.of(context).accentColor.withOpacity(.05),
                  borderRadius: BorderRadius.circular(
                    getProportionateScreenWidth(25),
                  ),
                  onTap: () {
                    Get.toNamed(
                      widget.routeName,
                    ); //TODO:NOTE  implicit send catagoryName to another page},\
                    //TODO:send  Name subCategory in arguments
                  }),
            ),
          ),
        )
      ],
    );
  }
}
