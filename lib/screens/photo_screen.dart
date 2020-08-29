import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skill_branch_flutter/res/res.dart';
import 'package:skill_branch_flutter/widgets/widgets.dart';

class FullScreenImage extends StatefulWidget {
  FullScreenImage(
      {Key key,
      this.photo = '',
      this.altDescription = '',
      this.userName = '',
      this.name = ''})
      : super(key: key);

  final String photo;
  final String altDescription;
  final String userName;
  final String name;
  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: Text(
          'Photo',
          style: AppStyles.h1Black,
        ),
        leading: IconButton(
            icon: Icon(
              CupertinoIcons.back,
              color: AppColors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Photo(photoLink: widget.photo),
          _buildDescription(widget.altDescription),
          _buildPhotoMeta(widget.userName, widget.name),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Container(
                    width: 105,
                    height: 36,
                    child: LikeButton(likeCount: 10, isLiked: true)),
              ),
              _buildButton('Save'),
              _buildButton('Visit')
            ],
          )
        ],
      ),
    );
  }
}

Widget _buildDescription(String description) {
  return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(description,
          maxLines: 3, overflow: TextOverflow.ellipsis, style: AppStyles.h3));
}

Widget _buildPhotoMeta(String userName, String name) {
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
                  name,
                  style: AppStyles.h2Black,
                ),
                Text(
                  '@$userName',
                  style: AppStyles.h5Black.copyWith(color: AppColors.manatee),
                )
              ],
            )
          ],
        )
      ],
    ),
  );
}

Widget _buildButton(String text) {
  return GestureDetector(
    onTap: () {},
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        alignment: Alignment.center,
        width: 105,
        height: 36,
        decoration: BoxDecoration(
          color: AppColors.dodgerBlue,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          text,
          style: TextStyle(color: AppColors.white),
        ),
      ),
    ),
  );
}
