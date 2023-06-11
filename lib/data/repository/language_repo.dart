import 'package:flutter_woocommerce/data/model/language_model.dart';
import 'package:flutter_woocommerce/util/app_constants.dart';
import 'package:flutter/material.dart';

class LanguageRepo {
  List<LanguageModel> getAllLanguages({BuildContext context}) {
    return AppConstants.languages;
  }
}
