import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

import '../../shared/size_configuration/text_sizes.dart';
import 'components/user_profie_view_body.dart';

class UserProfieView extends StatefulWidget {
  UserProfieView({Key key}) : super(key: key);

  @override
  _UserProfieViewState createState() => _UserProfieViewState();
}

class _UserProfieViewState extends State<UserProfieView> {
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
              actions: [
                !isEditing
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
                      )
              ],
            ),
            SliverToBoxAdapter(
              child: UserProfieViewBody(isEditing),
            ),
          ],
        ),
      ),
    );
  }
}
