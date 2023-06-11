import 'package:flutter_woocommerce/view/screens/cart/model/country.dart';
import 'package:flutter_woocommerce/view/screens/cart/model/state.dart' as st;

class AddressModel {
  int id;
  String firstName;
  String lastName;
  String company;
  String address1;
  String address2;
  String city;
  String postcode;
  Country country;
  st.State state;
  String email;
  String phone;

  AddressModel(
      {this.firstName,
        this.lastName,
        this.company,
        this.address1,
        this.address2,
        this.city,
        this.postcode,
        this.country,
        this.state,
        this.email,
        this.phone,
        this.id
      });

  AddressModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    company = json['company'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    postcode = json['postcode'];
    if(json['country'] != null) {
      country = Country.fromJson(json['country']);
    }
    if(json['state'] != null) {
      state = st.State.fromJson(json['state']);
    }
    email = json['email'];
    phone = json['phone'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(this.firstName != null) {
      data['first_name'] = this.firstName;
    }
    if(this.lastName != null) {
      data['last_name'] = this.lastName;
    }
    if(this.company != null) {
      data['company'] = this.company;
    }
    if(this.address1 != null) {
      data['address_1'] = this.address1;
    }
    if(this.address2 != null) {
      data['address_2'] = this.address2;
    }
    if(this.city != null) {
      data['city'] = this.city;
    }
    if(this.postcode != null) {
      data['postcode'] = this.postcode;
    }
    if(this.country != null) {
      data['country'] = this.country;
    }
    if(this.state != null) {
      data['state'] = this.state;
    }
    if(this.email != null) {
      data['email'] = this.email;
    }
    if(this.phone != null) {
      data['phone'] = this.phone;
    }
    if(this.id != null) {
      data['id'] = this.id;
    }
    return data;
  }
}