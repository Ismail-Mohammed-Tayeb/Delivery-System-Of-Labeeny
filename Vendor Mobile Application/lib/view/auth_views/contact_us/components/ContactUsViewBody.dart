import 'package:flutter/material.dart';

import '../../../../shared/size_configuration/size_config.dart';

class ContactUsViewBody extends StatelessWidget {
  const ContactUsViewBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              width: getProportionateScreenWidth(300),
              height: getProportionateScreenWidth(300),
              child: Image.asset(
                'assets/images/welogo.png',
                fit: BoxFit.fill,
                color: Theme.of(context).accentColor,
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [],
            ),
            SizedBox(
              height: getProportionateScreenHeight(30),
            ),
            Text(
              'Labeeny Application was made possible thanks to\n (WE) Team Members 🤟🏻',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: getProportionateScreenHeight(18),
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Text(
              '☕ Made With ❤ and',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: getProportionateScreenHeight(18),
              ),
            ),
            Text(
              '\nCopyrights Reserved ©\nWE Programming Team 2020-2021', //TODO: refactor conact us view body
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: getProportionateScreenHeight(18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTeamMemberPhoto(String name, String imagePath) {
    return Container(
      child: Column(
        children: [
          CircleAvatar(
            radius: getProportionateScreenWidth(35),
            child: Container(
              width: getProportionateScreenWidth(65),
              height: getProportionateScreenWidth(65),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(imagePath),
                ),
              ),
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(7),
          ),
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: getProportionateScreenHeight(17),
            ),
          ),
        ],
      ),
    );
  }
}
