import 'package:flutter_woocommerce/view/screens/product/model/product_model.dart';

class CategoryModel {
  int id;
  String name;
  String slug;
  int parent;
  String description;
  String display;
  ImageModel image;
  int menuOrder;
  int count;

  CategoryModel(
      {this.id,
        this.name,
        this.slug,
        this.parent,
        this.description,
        this.display,
        this.image,
        this.menuOrder,
        this.count});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if(json['name'] != null){
      name = (json['name']).replaceAll('amp;', '');
    }
    slug = json['slug'];
    parent = json['parent'];
    description = json['description'];
    display = json['display'];
    image = json['image'] != null ? new ImageModel.fromJson(json['image']) : null;
    menuOrder = json['menu_order'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['parent'] = this.parent;
    data['description'] = this.description;
    data['display'] = this.display;
    if (this.image != null) {
      data['image'] = this.image.toJson();
    }
    data['menu_order'] = this.menuOrder;
    data['count'] = this.count;
    return data;
  }
}
