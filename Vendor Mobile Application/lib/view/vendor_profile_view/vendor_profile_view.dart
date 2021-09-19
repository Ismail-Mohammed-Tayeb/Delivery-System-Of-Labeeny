import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

import '../../shared/size_configuration/text_sizes.dart';
import 'components/vendor_profile_view_body.dart';

class VendorProfileView extends StatefulWidget {
  VendorProfileView({Key key}) : super(key: key);

  @override
  _VendorProfileViewState createState() => _VendorProfileViewState();
}

class _VendorProfileViewState extends State<VendorProfileView> {
  bool isEditing = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              title: Text(
                'صفحتي',
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontFamily: 'Almarai',
                    fontSize: TextSizes.headline6,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.15),
              ),
        actions: [ !isEditing
                  ? IconButton(
                      icon: Icon(
                        CommunityMaterialIcons.pencil_outline,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      onPressed: () {
                        setState(() {
                          isEditing = !isEditing;
                        });
                      },
                    )
                  : IconButton(
                      icon: Icon(
                        Icons.close_outlined,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      onPressed: () {
                        setState(() {
                          isEditing = !isEditing;
                        });
                      },
                    ),],
            ),
            SliverToBoxAdapter(
              child: VendorProfileViewBody(isEditing),
            ),
          ],
        ),
      ),
    );
  }
}
