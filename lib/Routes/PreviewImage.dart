import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_familyapp/Routes/PreviewClassImageVideo.dart';
import 'package:photo_view/photo_view.dart';

class PreviewImage extends StatefulWidget {
  PreviewImage({this.imageUrl});

  String imageUrl;

  @override
  _PreviewImageState createState() => _PreviewImageState();
}

class _PreviewImageState extends State<PreviewImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onHorizontalDragCancel: (){
          Navigator.pop(context);
        },
        child: PhotoView(
          imageProvider: CachedNetworkImageProvider(widget.imageUrl),
        ),
      ),
    );
  }
}
