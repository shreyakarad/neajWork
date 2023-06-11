import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_woocommerce/controller/config_controller.dart';
import 'package:flutter_woocommerce/data/model/prediction_model.dart';
import 'package:flutter_woocommerce/view/base/custom_snackbar.dart';
//import 'package:flutter_woocommerce/view/screens/address/model/country_model.dart';
import 'package:flutter_woocommerce/view/screens/address/repository/location_repo.dart';
import 'package:flutter_woocommerce/view/screens/auth/controller/auth_controller.dart';
import 'package:flutter_woocommerce/view/screens/cart/controller/cart_controller.dart';
import 'package:flutter_woocommerce/view/screens/profile/model/address_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocode/geocode.dart';
//import 'package:flutter_woocommerce/view/screens/address/model/state_model.dart' as st;
import 'package:flutter_woocommerce/view/screens/cart/model/country.dart';
import 'package:flutter_woocommerce/view/screens/cart/model/state.dart' as st;


class LocationController extends GetxController implements GetxService {
  final LocationRepo locationRepo;
  LocationController({@required this.locationRepo});

  Position _position = Position(longitude: 0, latitude: 0, timestamp: DateTime.now(), accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1);
  Position _pickPosition = Position(longitude: 0, latitude: 0, timestamp: DateTime.now(), accuracy: 1, altitude: 1, heading: 1, speed: 1, speedAccuracy: 1);
  bool _loading = false;
  String _address = '';
  String _pickAddress = '';
  List<Marker> _markers = <Marker>[];
  List<AddressModel> _userAddressList;
  List<AddressModel> _addressList;
  List<AddressModel> _addressList1;
  List<AddressModel> _allAddressList;
  int _addressTypeIndex = 0;
  List<String> _addressTypeList = ['home', 'office', 'others'];
  bool _isLoading = false;
  bool _inZone = false;
  int _zoneID = 0;
  bool _buttonDisabled = true;
  GoogleMapController _mapController;
  List<PredictionModel> _predictionList = [];
  bool _updateAddAddressData = true;
  bool get updateAddAddressData => _updateAddAddressData;
  Address _shippingPlaceMark;
  Address _billingPlaceMark;
  List<Country> _countryList;
  List<st.State> _stateList;
  Country _selectedCountry ;
  Country _selectedHintCountry ;
  st.State _selectedState;
  st.State _selectedHintState ;
  List<st.State> dropdownStateList=[];

  bool _profileShippingSelected = false;
  bool _profileBillingSelected = false;

  int _profileShippingSelectedIndex = -1;
  int _profileBillingSelectedIndex = -1;




  List<PredictionModel> get predictionList => _predictionList;
  bool get isLoading => _isLoading;
  bool get loading => _loading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;
  String get address => _address;
  String get pickAddress => _pickAddress;
  List<Marker> get markers => _markers;
  List<AddressModel> get addressList => _addressList;
  List<String> get addressTypeList => _addressTypeList;
  int get addressTypeIndex => _addressTypeIndex;
  bool get inZone => _inZone;
  int get zoneID => _zoneID;
  bool get buttonDisabled => _buttonDisabled;
  GoogleMapController get mapController => _mapController;
  Address get shippingPlaceMark => _shippingPlaceMark;
  Address get billingPlaceMark => _billingPlaceMark;
  List<Country> get countryList => _countryList;
  List<st.State> get stateList => _stateList;
  Country get selectedCountry => _selectedCountry;
  Country get selectedHintCountry => _selectedHintCountry;
  st.State get selectedState => _selectedState;
  st.State get selectedHintState => _selectedHintState;
  bool get profileShippingSelected => _profileShippingSelected;
  bool get profileBillingSelected => _profileBillingSelected;




  int selectedShippingAddressIndex = -1;
  int selectedBillingAddressIndex = -1;

  void setShippingAddressIndex(int index, {bool notify = true}){
    selectedShippingAddressIndex = index;
    _profileShippingSelected = false;
    showCustomSnackBar('shipping_address_selected'.tr, isError: false);
    print('Shipping Address');
    print(index);
    Get.find<CartController>().getShippingMethod();
    update();
    if(notify){
      update();
    }

  }
  void setBillingAddressIndex(int index, {bool notify = true}){
    selectedBillingAddressIndex = index;
    _profileBillingSelected = false;
    showCustomSnackBar('billing_address_selected'.tr, isError: false);
    update();
    if(notify){
      update();
    }
  }


  void selectProShipping(bool fromShipping) {
    if(fromShipping) {
      _profileShippingSelected = true;
      selectedShippingAddressIndex = -1;
      Get.back();
      showCustomSnackBar('shipping_address_selected'.tr, isError: false);
      Get.find<CartController>().getShippingMethod();
      update();
    } else {
      showCustomSnackBar('shipping_address_cant_selected'.tr);
    }
  }

  void selectProBilling(bool fromBilling) {
    if(fromBilling) {
      _profileBillingSelected = true;
      selectedBillingAddressIndex = -1;
      Get.back();
      showCustomSnackBar('billing_address_selected'.tr, isError: false);
      update();
    } else {
      showCustomSnackBar('billing_address_cant_selected'.tr);
    }
  }



  void emptyOrderAddress ({bool notify = true}) {
    selectedShippingAddressIndex = -1;
    selectedBillingAddressIndex = -1;
    _profileShippingSelected = false;
    _profileBillingSelected = false;
    if(notify){
      update();
    }
  }

  void getUserAddress() async {
    _addressList = [];
    _userAddressList = [];
    //_addressList.addAll(locationRepo.getAddressList());
    _userAddressList.addAll(locationRepo.getAddressList());
    int _userId;
    _userId = Get.find<AuthController>().isLoggedIn() ? Get.find<AuthController>().getSavedUserId() : 0;
    if(_userAddressList.length != 0){
      _userAddressList.forEach((address) {
        if(address.id == _userId) {
          _addressList.add(address);
        }
      });
    }
  }

  Future<void> addToAddressList(AddressModel  addressModel, {int index}) async {
    getUserAddress();
    print(index);
    print('AddressIndexFunction--->${index}');
    if(index != null && index != -1) {
      //_userAddressList.replaceRange(index, index+1, [addressModel]);
      print('AddressIndexFunction--->TRUE');
      _userAddressList[index] = addressModel;
      showCustomSnackBar('address_updated_successfully'.tr, isError: false);
    } else {
      print('AddressIndexFunction-->ELSE');
      _userAddressList.add(addressModel);
      showCustomSnackBar('address_added_successfully'.tr, isError: false);
    }
    locationRepo.addAddress(_userAddressList);
    getUserAddress();
    Get.back();
    update();
  }

  void removeFromAddressList(int index) {
    _addressList.removeAt(index);
    locationRepo.addAddress(_addressList);
    update();
    showCustomSnackBar('address_deleted_successfully'.tr, isError: false);
  }

  void filterAddresses(String queryText) {
    if(_addressList != null) {
      _addressList = [];
      if (queryText == null || queryText.isEmpty) {
        _addressList.addAll(_allAddressList);
      } else {
        _allAddressList.forEach((address) {
       });
     }
     update();
    }
  }



  void setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }



  void disableButton() {
    _buttonDisabled = true;
    _inZone = true;
    update();
  }

  void setAddAddressData() {
    _position = _pickPosition;
    //_address = _pickAddress;
    _updateAddAddressData = false;
    update();
  }

  void setPickData() {
    _pickPosition = _position;
    _pickAddress = _address;
  }

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }


  void setPlaceMark(String address) {
    _address = address;
  }

  initList() async{
    _countryList = await loadCountries();
    _stateList = await loadState();
  }

  Future<List<Country>> loadCountries() async {
    final res = await rootBundle.loadString('assets/country_state/country.json');
    final data = jsonDecode(res) as List;
    return List<Country>.from(
      data.map((item) => Country.fromJson(item)),
    );
  }

  Future<List<st.State>> loadState() async {
    final res = await rootBundle.loadString('assets/country_state/state.json');
    final data = jsonDecode(res) as List;
    return List<st.State>.from(data.map((item) => st.State.fromJson(item)));
  }

  setSelectedCountry(Country country, {bool notify = true}) {
    _selectedCountry = null;
    _selectedState = null;
    _selectedHintState = null;
    _selectedCountry = country;
    getDropdownStateList();
    if(notify) {
      update();
    }
  }

  setSelectedHintCountry (Country country) {
    _selectedCountry = null;
    _selectedHintCountry = country;
    getDropdownStateList();
  }

  setSelectedHintState (st.State state) {
    _selectedState = null;
    _selectedHintState = state;
  }

  getDropdownStateList(){
    dropdownStateList=[];
    String _isoCode;

    if(_selectedCountry != null){
      _isoCode = _selectedCountry.isoCode;
    } else if (_selectedHintCountry != null) {
      _isoCode = _selectedHintCountry.isoCode;
    }
    stateList.forEach((element) {
      if(_isoCode == element.countryCode)
        dropdownStateList.add(element);
    });
  }

  setSelectedState(st.State state){
    _selectedState = state;
    update();
  }

  void setDefaultCountry () {
    print('default_country');
    if(Get.find<ConfigController>().getDefaultCountry() != null){
      for(Country country in countryList) {
        if(Get.find<ConfigController>().getDefaultCountry() == country.isoCode) {
          setSelectedCountry(country, notify: false);
    }}}
  }

  void clearCountryState() {
    _selectedState = null;
    _selectedCountry = null;
    _selectedHintCountry = null;
    _selectedHintState = null;
    removeProfileAddressSelectedIndex();
  }

  String setStateIso(String state) {
    for ( int i; i< _stateList.length; i++){
      if(_stateList[i].name == state) {
        return _stateList[i].isoCode;
      }
    }
    return '';
  }

  void setProfileSelectedShippingAddressIndex (int index) {
    _profileShippingSelectedIndex = index;
    print('--Profile--ShippingIndex---->$index');
  }

  void setProfileSelectedBillingAddressIndex (int index) {
    _profileBillingSelectedIndex = index;
    print('--Profile--BillingIndex---->$index');
  }

  void removeProfileAddressSelectedIndex () {
    _profileShippingSelectedIndex = -1;
    _profileBillingSelectedIndex = -1;
  }

  void removeProfileSavedAddress() {
    print('Remove Address Call');
    _addressList1 = [];
    _addressList1.addAll(_addressList);
    print('Address1_length-->${_addressList1.length}');
    print('Address_length-->${_addressList.length}');


    if(_profileShippingSelectedIndex != -1) {
      print('_profileShippingSelectedIndex CALL');
      if(_addressList.isNotEmpty) {
        _addressList.remove(_addressList1[_profileShippingSelectedIndex]);
      }
      _profileShippingSelectedIndex = -1;
    }

    if(_profileBillingSelectedIndex != -1) {
      print('_profileBillingSelectedIndex CALL');
      if(_addressList.isNotEmpty) {
        _addressList.remove(_addressList1[_profileBillingSelectedIndex]);
      }
      _profileBillingSelectedIndex = -1;
    }
    print('Address_length-----AFTER----->${_addressList.length}');
    locationRepo.addAddress(_addressList);
    update();

    // removeProfileAddressSelectedIndex();
  }




}