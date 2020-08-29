import 'package:flutter/material.dart';
import '../res/res.dart';

class LikeButton extends StatefulWidget {
  LikeButton({Key key, this.likeCount = 0, this.isLiked = false})
      : super(key: key);

  final int likeCount;
  final bool isLiked;

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isLiked;
  int likeCount;

  @override
  void initState() {
    super.initState();
    isLiked = widget.isLiked;
    likeCount = widget.likeCount;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          isLiked = !isLiked;
          if (isLiked) {
            likeCount++;
          } else {
            likeCount--;
          }
        });
      },
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(isLiked ? AppIcons.like_fill : AppIcons.like),
              SizedBox(width: 4.21),
              Text(
                likeCount.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  height: 16 / 14,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
