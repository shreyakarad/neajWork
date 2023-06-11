import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_woocommerce/data/api/api_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/data/model/response_model.dart';
import 'package:flutter_woocommerce/view/screens/address/controller/location_controller.dart';
import 'package:flutter_woocommerce/view/screens/auth/controller/auth_controller.dart';
import 'package:flutter_woocommerce/view/screens/profile/model/address_model.dart';
import 'package:flutter_woocommerce/view/screens/profile/model/profile_model.dart';
import 'package:flutter_woocommerce/view/screens/profile/repository/profile_repo.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_woocommerce/view/base/custom_snackbar.dart';
import 'package:flutter_woocommerce/view/screens/cart/model/state.dart' as st;

class ProfileController extends GetxController implements GetxService {
  final ProfileRepo profileRepo;
  ProfileController({@required this.profileRepo});

  ProfileModel _profileModel;
  XFile _pickedFile;
  Uint8List _rawFile;
  bool _isLoading = false;
  bool _isAvatarLoading = false;
  AddressModel _billingAddress;
  AddressModel _shippingAddress;
  String _profileImageUrl = '';
  ProfileAddressModel _shipping;
  ProfileAddressModel _billing;
  ProfileAddressModel _shipping1;
  ProfileAddressModel _billing1;
  List<st.State> _stateList;

  ProfileModel get profileModel => _profileModel;
  XFile get pickedFile => _pickedFile;
  Uint8List get rawFile => _rawFile;
  bool get isLoading => _isLoading;
  bool get isAvatarLoading => _isAvatarLoading;
  AddressModel get billingAddress => _billingAddress;
  AddressModel get shippingAddress => _shippingAddress;
  String get profileImageUrl => _profileImageUrl;
  List<st.State> get stateList => _stateList;

  ProfileAddressModel get profileShippingAddress => _shipping;
  ProfileAddressModel get profileBillingAddress => _billing;

  ProfileAddressModel get profileShippingAddress1 => _shipping1;
  ProfileAddressModel get profileBillingAddress1 => _billing1;

  Future<ResponseModel> getUserInfo() async {
    _shipping = null;
    _billing = null;
    _pickedFile = null;
    _rawFile = null;
    initList();
    ResponseModel _responseModel;
    Response response = await profileRepo.getUserInfo();
    if (response.statusCode == 200) {
      _profileModel = ProfileModel.fromJson(response.body);

      _shipping = ProfileAddressModel.fromJson(_profileModel.shipping.toJson());
      _billing = ProfileAddressModel.fromJson(_profileModel.billing.toJson());

      _shipping1 = _profileModel.shipping;
      _billing1 = _profileModel.billing;

      profileModel.metaData.forEach((metaData) {
        if(metaData.key == 'avatar_url') {
          _profileImageUrl = metaData.value;
        }
      });

      // print('Shipping_State');
      // print(Get.find<LocationController>().setStateIso(_shipping.state));

      setStateIso();

      // if(_profileMode;l.billing != null && _profileModel.billing.country.isNotEmpty) {
      //   setBillingAddress(_profileModel.billing);
      //   _billingAddress = _profileModel.billing;
      // }
      // if(_profileModel.shipping != null && _profileModel.shipping.country.isNotEmpty) {
      //   setShippingAddress(_profileModel.shipping);
      //   _shippingAddress = _profileModel.shipping;
      // }

      _responseModel = ResponseModel(true, 'successful');
    } else {
      _responseModel = ResponseModel(false, response.statusText);
      ApiChecker.checkApi(response);
    }
    update();
    return _responseModel;
  }



  void setStateIso() {
    for ( int i=0; i < _stateList.length; i++){
      if(_stateList[i].name == _shipping.state) {
        _shipping.stateIso = _stateList[i].isoCode;
        break;
      }
    }
  }


/*
  void setabc() {
    Get.find()<LocationController>().


  }
*/


  void clearProfileData() {
    _profileModel = null;
    _shipping = null;
    _billing = null;
    _shipping1 = null;
    _billing1 = null;
    _profileImageUrl = null;
    update();
  }

  Future<ResponseModel> updateUserInfo(ProfileModel updateUserModel) async {
    //print(updateUserModel.billing.firstName);
    _isLoading = true;
    update();
    ResponseModel _responseModel;
    Response response = await profileRepo.updateProfile(updateUserModel);
    _isLoading = false;
    if (response.statusCode == 200) {
      _profileModel = updateUserModel;
      _responseModel = ResponseModel(true, response.bodyString);
      getUserInfo();
      Get.find<LocationController>().removeProfileSavedAddress();
    } else {
      _responseModel = ResponseModel(false, response.statusText);
      print(response.statusText);
    }
    update();
    return _responseModel;
  }

  Future<ResponseModel> updateProfileAvatar() async {
    _isAvatarLoading = true;
    update();
    ResponseModel _responseModel;
    Response response = await profileRepo.updateAvatar(_pickedFile);
    _pickedFile = null;
    _isAvatarLoading = false;
    if (response.statusCode == 200) {
      getUserInfo();
      showCustomSnackBar('profile_avatar_uploaded'.tr, isError: false);
    } else {
      _responseModel = ResponseModel(false, response.statusText);
      print(response.statusText);
    }
    update();
    return _responseModel;
  }

  void pickImage() async {
    _pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(_pickedFile != null) {
      updateProfileAvatar();
    }
    update();
  }

  void initData() {
    _pickedFile = null;
    _rawFile = null;
  }

  Future removeUser() async {
    _isLoading = true;
    update();
    Response response = await profileRepo.deleteUser();
    _isLoading = false;
    if (response.statusCode == 200) {
      showCustomSnackBar('your_account_removed_successfully'.tr, isError: false);
      Get.find<AuthController>().clearSharedData();
    }else{
      Get.back();
      ApiChecker.checkApi(response);
    }
  }

  void setBillingAddress(AddressModel billingAddress) {
    profileRepo.setBillingAddress(billingAddress);
  }

  void setShippingAddress(AddressModel shippingAddress) {
    profileRepo.setShippingAddress(shippingAddress);
  }

  AddressModel getShippingAddress({bool notify = false}) {
    _shippingAddress = profileRepo.getShippingAddress();
    if(notify) {
      update();
    }
    return profileRepo.getShippingAddress();
  }

  AddressModel getBillingAddress({bool notify = false}) {
    _billingAddress = profileRepo.getBillingAddress();
    if(notify) {
      update();
    }
    return profileRepo.getBillingAddress();
  }

  // void setAddress(AddressModel address, bool isBilling, bool fromProfile) async {
  //   if(fromProfile) {
  //     _isLoading = true;
  //     update();
  //     Response response = await profileRepo.updateAddress(address, isBilling);
  //     _isLoading = false;
  //     if (response.statusCode == 200) {
  //       if(isBilling) {
  //         _billingAddress = address;
  //       }else {
  //         _shippingAddress = address;
  //       }
  //       showCustomSnackBar('updated_successfully'.tr, isError: false);
  //     } else {
  //       ApiChecker.checkApi(response);
  //     }
  //   }else {
  //     if(isBilling) {
  //       _billingAddress = address;
  //     }else {
  //       _shippingAddress = address;
  //     }
  //   }
  //   update();
  // }

  Future<void> setProfileAddress(AddressModel address, bool isShipping, {bool fromCheckout = false}) async {
    _isLoading = true;
    update();
    print('profile address call');
    ProfileAddressModel _profileAddress = ProfileAddressModel(
      firstName: address.firstName,
      lastName: address.lastName,
      company: address.company,
      address1: address.address1,
      address2: address.address2,
      city: address.city,
      postcode: address.postcode,
      country: address.country.isoCode,
      state: address.state.name,
      email: address.email,
      phone: address.phone
    );
    if(isShipping) {
      _shipping = ProfileAddressModel.fromJson(_profileAddress.toJson());
    } else {
      _billing = ProfileAddressModel.fromJson(_profileAddress.toJson());
    }
    if(fromCheckout){
      await profileRepo.updateAddress(_profileAddress, isShipping);
    }
    _isLoading = false;
    update();
  }



  ProfileAddressModel convertProfileAddress (AddressModel address) {
    ProfileAddressModel _profileAddress;
    _profileAddress = ProfileAddressModel(
        firstName: address.firstName,
        lastName: address.lastName,
        company: address.company,
        address1: address.address1,
        address2: address.address2,
        city: address.city,
        postcode: address.postcode,
        country: address.country.isoCode,
        state: address.state.name,
        email: address.email,
        phone: address.phone
    );
    return _profileAddress;
  }

  initList() async{
    _stateList = await loadState();
  }

  Future<List<st.State>> loadState() async {
    final res = await rootBundle.loadString('assets/country_state/state.json');
    final data = jsonDecode(res) as List;
    return List<st.State>.from(data.map((item) => st.State.fromJson(item)));
  }
}