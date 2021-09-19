import 'package:flutter/material.dart';

import '../../size_configuration/text_sizes.dart';

class CustomSliverAppBarForSearch extends StatefulWidget {
  CustomSliverAppBarForSearch(
      {Key key,
      this.onchanged,
      this.lableText,
      this.hintText,
      this.textEditingController})
      : super(key: key);
  final Function(String) onchanged;
  final String lableText;
  final String hintText;
  final TextEditingController textEditingController;

  @override
  _CustomSliverAppBarForSearchState createState() =>
      _CustomSliverAppBarForSearchState();
}

class _CustomSliverAppBarForSearchState
    extends State<CustomSliverAppBarForSearch> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: SliverAppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        pinned: true,
        snap: false,
        floating: true,
        flexibleSpace: Container(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextField(
              textInputAction: TextInputAction.search,
              // keyboardType: keyboardType,
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: widget.hintText,
                  hintStyle:
                      Theme.of(context).inputDecorationTheme.hintStyle.copyWith(
                            fontSize: TextSizes.body2,
                            fontFamily: 'Almarai',
                          ),
                  contentPadding: EdgeInsets.zero,
                  prefixIcon: Icon(
                    Icons.search_outlined,
                    color: Theme.of(context).colorScheme.secondary,
                  )
                  //Your Styling Goes Here
                  ),

              controller: widget.textEditingController,
              onChanged: widget.onchanged ?? null,
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20.0),
          child: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.black87,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(
                text: "المطاعم",
              ),
              Tab(
                text: "المنطقة",
              ),
              Tab(
                text: "المطاعم",
              ),
              Tab(
                text: "المنطقة",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
