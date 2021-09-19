import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

import '../../size_configuration/size_config.dart';
import '../../size_configuration/text_sizes.dart';

class CustomLookLikeContainer extends StatefulWidget {
  static int currentPage = 0;
  static List<int> productSize = [
    1,
    15,
    45,
    225,
    900,
    5200,
    10400,
  ];
  CustomLookLikeContainer() : super();

  @override
  _CustomLookLikeContainerState createState() =>
      _CustomLookLikeContainerState();
}

class _CustomLookLikeContainerState extends State<CustomLookLikeContainer> {
  String currentSize = '';

  PageController _controller = PageController();
  List<String> dataSize = [
    'XXS',
    'XS',
    'S',
    'M',
    'L',
    'XL',
    'XXL',
  ];

  List<String> imageNames = [
    'XXS',
    'XS',
    'S',
    'M',
    'L',
    'XL',
    'XXL',
  ];
  List<String> imagesDescription = [
    'ولاعة',
    'كوب',
    'قارورة 1.5 لتر',
    'لوحة بحجم 40*30*10',
    'صندوق بحجم 60*60*60',
    'غسالة 12 لتر',
    'براد 12 قدم',
  ];
  String darkSuffix = '_DARK', lightSuffix = '_LIGHT';
  List<Widget> pages;
  _onChanged(int index) {
    setState(
      () {
        currentSize = dataSize[index];
        CustomLookLikeContainer.currentPage = index;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    fillData();
    return Container(
      color: Theme.of(context).primaryColor,
      // color: Colors.red,
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'منتجي بحجم: ',
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontFamily: 'Almarai',
                    fontSize: TextSizes.headline6,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.15),
              ),
              SizedBox(
                width: getProportionateScreenWidth(5),
              ),
              Text(
                dataSize[CustomLookLikeContainer.currentPage],
                style: Theme.of(context).textTheme.overline.copyWith(
                    fontFamily: 'Almarai',
                    fontSize: TextSizes.headline6,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.15),
              ),
            ],
          ),
          SizedBox(
            height: getProportionateScreenHeight(5),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {
                    if (CustomLookLikeContainer.currentPage <
                        dataSize.length - 1) {
                      CustomLookLikeContainer.currentPage++;
                      _controller.animateToPage(
                        CustomLookLikeContainer.currentPage,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).accentColor,
                    radius: getProportionateScreenHeight(40),
                    child: Icon(
                      CommunityMaterialIcons.arrow_right,
                      size: getProportionateScreenHeight(50),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(15),
              ),
              Column(
                children: [
                  Container(
                    height: getProportionateScreenHeight(420),
                    width: getProportionateScreenWidth(200),
                    child: PageView.builder(
                      reverse: true,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      controller: _controller,
                      itemCount: dataSize.length,
                      onPageChanged: _onChanged,
                      itemBuilder: (context, int index) {
                        return pages[index];
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: getProportionateScreenWidth(15),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () {
                    if (CustomLookLikeContainer.currentPage > 0) {
                      CustomLookLikeContainer.currentPage--;
                      _controller.animateToPage(
                        CustomLookLikeContainer.currentPage,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).accentColor,
                    radius: getProportionateScreenHeight(40),
                    child: Icon(
                      CommunityMaterialIcons.arrow_left,
                      size: getProportionateScreenHeight(50),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  fillData() {
    pages = List.generate(dataSize.length, (index) {
      return buildProductSizeContainer(
          dataSize[index], imageNames[index], imagesDescription[index]);
    });
    return pages;
  }

  Material buildProductSizeContainer(
      String textSize, String imageName, String imageDesription) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          print('ddd');
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: getProportionateScreenWidth(200),
            height: getProportionateScreenHeight(450),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 3,
                    blurRadius: 4,
                    offset: Offset(0, 2))
              ],
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Theme.of(context).accentColor),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Text(
                  'يشبه:',
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      fontFamily: 'Almarai',
                      fontSize: TextSizes.headline6,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.15),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(15),
                ),
                Text(
                  imageDesription,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.overline.copyWith(
                      fontFamily: 'Almarai',
                      fontSize: TextSizes.headline6,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.15),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(60),
                ),
                AspectRatio(
                  aspectRatio: 3 / 2,
                  child: Builder(builder: (context) {
                    if (Theme.of(context).brightness == Brightness.dark) {
                      return Image.asset(r'assets/images/product_size_images/' +
                          imageName +
                          darkSuffix +
                          '.png');
                    }
                    return Image.asset(r'assets/images/product_size_images/' +
                        imageName +
                        lightSuffix +
                        '.png');
                  }),
                  // child: Container(
                  //   decoration: BoxDecoration(
                  //     shape: BoxShape.rectangle,
                  //     image: DecorationImage(
                  //       fit: BoxFit.cover,
                  //       image: NetworkImage(
                  //           'https://i.guim.co.uk/img/media/684c9d087dab923db1ce4057903f03293b07deac/205_132_1915_1150/master/1915.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=14a95b5026c1567b823629ba35c40aa0'),
                  //     ),
                  //   ),
                  // ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
