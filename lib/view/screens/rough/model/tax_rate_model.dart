class TaxRate {
  int id;
  String country;
  String state;
  String postcode;
  String city;
  String rate;
  String name;
  int priority;
  bool compound;
  bool shipping;
  int order;
  List<String> cities;

  TaxRate({this.id, this.country, this.state, this.postcode, this.city, this.rate, this.name, this.priority, this.compound, this.shipping, this.order, this.cities});

  TaxRate.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  country = json['country'];
  state = json['state'];
  postcode = json['postcode'];
  city = json['city'];
  rate = json['rate'];
  name = json['name'];
  priority = json['priority'];
  compound = json['compound'];
  shipping = json['shipping'];
  order = json['order'];
  cities = json['cities'].cast<String>();
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this.id;
  data['country'] = this.country;
  data['state'] = this.state;
  data['postcode'] = this.postcode;
  data['city'] = this.city;
  data['rate'] = this.rate;
  data['name'] = this.name;
  data['priority'] = this.priority;
  data['compound'] = this.compound;
  data['shipping'] = this.shipping;
  data['order'] = this.order;
  data['cities'] = this.cities;
  return data;
  }
}