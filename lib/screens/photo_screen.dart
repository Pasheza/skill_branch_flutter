import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../res/res.dart';
import '../widgets/widgets.dart';

class FullScreenImage extends StatefulWidget {
  FullScreenImage({
    Key key,
    this.photo = '',
    this.altDescription = '',
    this.userName = '',
    this.name = '',
    this.heroTag,
    this.userPhoto = '',
  }) : super(key: key);

  final String photo;
  final String altDescription;
  final String userName;
  final String name;
  final String heroTag;
  final String userPhoto;
  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    _playAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _playAnimation() async {
    try {
      await _controller.forward().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

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
          Hero(
            tag: widget.heroTag,
            child: Photo(
              photoLink: widget.photo,
            ),
          ),
          _buildDescription(widget.altDescription),
          PhotoMetaStaggerAnimation(
            controller: _controller,
            userName: widget.userName,
            name: widget.userName,
            userPhoto: widget.userPhoto,
          ),
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

class PhotoMetaStaggerAnimation extends StatelessWidget {
  PhotoMetaStaggerAnimation({
    Key key,
    this.controller,
    this.userName,
    this.name,
    this.userPhoto,
  })  : avatarOpacity = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.0,
              0.5,
              curve: Curves.ease,
            ),
          ),
        ),
        headerOpacity = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(
              0.5,
              1.0,
              curve: Curves.ease,
            ),
          ),
        ),
        super(key: key);

  final Animation<double> controller;
  final Animation<double> avatarOpacity;
  final Animation<double> headerOpacity;
  final String userName;
  final String name;
  final String userPhoto;

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              Opacity(
                opacity: avatarOpacity.value,
                child: UserAvatar(userPhoto),
              ),
              SizedBox(width: 6),
              Opacity(
                opacity: headerOpacity.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: AppStyles.h2Black,
                    ),
                    Text(
                      '@$userName',
                      style:
                          AppStyles.h5Black.copyWith(color: AppColors.manatee),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
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
