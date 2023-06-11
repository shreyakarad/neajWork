class BannerModel {
  int id;
  String bannerType;
  String resourceType;
  int product;
  int category;
  bool status;
  String image;
  String date;

  BannerModel(
      {this.id,
        this.bannerType,
        this.resourceType,
        this.product,
        this.status,
        this.image,
        this.date,
        this.category
      });

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bannerType = json['banner_type'];
    resourceType = json['resource_type'];
    product = json['product'];
    status = json['status'];
    image = json['image'];
    date = json['date'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['banner_type'] = this.bannerType;
    data['resource_type'] = this.resourceType;
    data['product'] = this.product;
    data['status'] = this.status;
    data['image'] = this.image;
    data['date'] = this.date;
    data['category'] = this.category;
    return data;
  }
}
