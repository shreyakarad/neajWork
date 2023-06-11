import 'package:flutter/material.dart';
import 'package:flutter_woocommerce/view/screens/rough/reopositry/rough_repo.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';


class RoughController extends GetxController implements GetxService{
  final SharedPreferences sharedPreferences;
  RoughRepo roughRepo;
  RoughController({@required this.sharedPreferences, @required this.roughRepo});






}