class UploaderModel {
  final url;
  final id;

  UploaderModel(this.url, this.id);

  UploaderModel.fromJson(Map<String, dynamic> json)
      : this.url = json['url'],
        this.id = json['user_id'];
}

class UploaderParent {
  final List<UploaderModel> userobj;

  UploaderParent(this.userobj);

  UploaderParent.fromJson(Map<String, dynamic> json)
      : userobj = json['data']
      .map<UploaderModel>((i) => UploaderModel.fromJson(i))
      .toList();
}
