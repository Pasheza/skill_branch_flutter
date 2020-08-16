import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:skill_branch_flutter/res/res.dart';
import 'package:skill_branch_flutter/widgets/widgets.dart';

const String kFlutterDash =
    'https://miro.medium.com/max/664/1*Xm96KtLeIAAMtAYWcr1-MA.png';

class Feed extends StatefulWidget {
  Feed({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _FeedState();
  }
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Column(children: <Widget>[
              _buildItem(),
              Divider(
                thickness: 2,
                color: AppColors.mercury,
              )
            ]);
          }),
    );
  }
}

Widget _buildItem() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Photo(photoLink: kFlutterDash),
      _buildPhotoMeta(),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text('This is flutter Dash. I love him',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.h3.copyWith(color: AppColors.black)),
      )
    ],
  );
}

Widget _buildPhotoMeta() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: [
            UserAvatar('https://skill-branch.ru/img/speakers/Adechenko.jpg'),
            SizedBox(width: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Kirill Adechenko',
                  style: AppStyles.h2Black,
                ),
                Text(
                  '@kaparray',
                  style: AppStyles.h5Black.copyWith(color: AppColors.manatee),
                )
              ],
            )
          ],
        ),
        LikeButton(10, true)
      ],
    ),
  );
}
