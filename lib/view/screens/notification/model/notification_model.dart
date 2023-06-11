class NotificationModel {
  int id;
  String title;
  String description;
  String type;
  String image;
  String date;

  NotificationModel(
      {this.id,
        this.title,
        this.description,
        this.type,
        this.image,
        this.date});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    type = json['type'];
    image = json['image'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['type'] = this.type;
    data['image'] = this.image;
    data['date'] = this.date;
    return data;
  }
}




// class NotificationModel {
//   int id;
//   Data data;
//   String createdAt;
//   String updatedAt;
//
//   NotificationModel({this.id, this.data, this.createdAt, this.updatedAt});
//
//   NotificationModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     if (this.data != null) {
//       data['data'] = this.data.toJson();
//     }
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
//
// class Data {
//   String title;
//   String description;
//   String image;
//   String type;
//
//   Data({this.title, this.description, this.image, this.type});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//     description = json['description'];
//     image = json['image'];
//     type = json['type'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['title'] = this.title;
//     data['description'] = this.description;
//     data['image'] = this.image;
//     data['type'] = this.type;
//     return data;
//   }
// }
