class UsersListModel {
  var name;
  var age;
  var status;
  var intrests;
  var id;

  UsersListModel(this.name, this.age, this.intrests, this.status, this.id);

  UsersListModel.fromJson(Map<String, dynamic> json)
      : this.name = json['name'],
        this.age = json['age'],
        this.status = json['status'],
        this.id = json['ID'],
        this.intrests = json['intrests'];
}

class UserListParent {
  final List<UsersListModel> userobj;

  UserListParent(this.userobj);

  UserListParent.fromJson(Map<String, dynamic> json)
      : userobj = json['users']
            .map<UsersListModel>((i) => UsersListModel.fromJson(i))
            .toList();
}
