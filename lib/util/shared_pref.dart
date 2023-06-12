import 'package:get_storage/get_storage.dart';

import '../model/api models/res model/getCountryResponseModel.dart';

class PrefManagerUtils {
  static GetStorage getStorage = GetStorage();
  static String country = 'country';

  ///country
  static Future setCountry(String value) async {
    await getStorage.write(country, value);
  }

  static String getCountry() {
    return getStorage.read(country) ?? '';
  }
}
