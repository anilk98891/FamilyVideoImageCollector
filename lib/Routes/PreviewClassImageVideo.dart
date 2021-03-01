import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_familyapp/Helper/Constants.dart';
import 'package:flutter_familyapp/Model/UserListModel.dart';
import 'package:flutter_familyapp/Model/uploaderModel.dart';
import 'package:flutter_familyapp/Routes/PreviewImage.dart';
import 'package:flutter_familyapp/Routes/PreviewVideo.dart';
import 'package:flutter_familyapp/Routes/PreviewVideo.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

enum previewType { video, image }

class PreviewController extends StatefulWidget {
  PreviewController({this.previewTypeObj, this.usersObj});

  previewType previewTypeObj;
  UsersListModel usersObj;

  @override
  _PreviewControllerState createState() => _PreviewControllerState();
}

class _PreviewControllerState extends State<PreviewController> {
  UploaderParent uploaderListObj;
  List<UploaderModel> uploadObj;
  ImageFormat _format = ImageFormat.JPEG;
  int _quality = 10;
  int _size = 200;
  String _tempDir;
  String filePath;

  _getImage(videoPathUrl) async {
    final thumbnail = await VideoThumbnail.thumbnailFile(
        video: videoPathUrl,
        thumbnailPath: _tempDir,
        imageFormat: _format,
        maxHeight: _size,
        maxWidth: _size,
        quality: _quality);
    return thumbnail;
  }

  Future<void> apiCallUserList(previewType type) async {
    dynamic object = await getUsers(Constants().baseURL +
        (type == previewType.image
            ? '/image/${widget.usersObj.id}'
            : '/video/${widget.usersObj.id}'));
    uploaderListObj = UploaderParent.fromJson(object);
    uploadObj = uploaderListObj.userobj;
  }

  Future<dynamic> getUsers(String url) async {
    try {
      Response response = await get(url);
      print(response.body);
      return (jsonDecode(response.body));
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getTemporaryDirectory().then((d) => _tempDir = d.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preview'),
      ),
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
            future: apiCallUserList(widget.previewTypeObj),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return uploadObj == null ? Container() :GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemCount: uploadObj.length,
                    itemBuilder: (context, index) {
                      return widget.previewTypeObj == previewType.image
                          ? GridTile(
                            child: Card(
                              child: GestureDetector(
                                  child: CachedNetworkImage(
                                    imageUrl: uploadObj[index].url,
                                    placeholder: (context, url) => Center(child: new CircularProgressIndicator()),
                                    errorWidget: (context, url, error) => new Icon(Icons.error),
                                  ),
                                  onTap: () => {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => PreviewImage(
                                              imageUrl: uploadObj[index].url,
                                            )))
                                  },
                                ),
                            ),
                          )
                          : FutureBuilder(
                              future: _getImage(uploadObj[index].url),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return GestureDetector(
                                    onTap: () => {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PreviewVideo(
                                                    url: uploadObj[index].url
                                                  )))
                                    },
                                    child: new GridTile(
                                      child: new Card(
                                          color: Colors.black,
                                          child: new Center(
                                            child: Image.asset(
                                                snapshot.data.toString()),
                                          )),
                                    ),
                                  );
                                } else {
                                  return Center(
                                    child: Container(
                                        child: CircularProgressIndicator()),
                                  );
                                }
                              },
                            );
                    });
              } else {
                return Container(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
