import 'package:get_storage/get_storage.dart';

import '../model/api models/res model/getCountryResponseModel.dart';

class PrefManagerUtils {
  static GetStorage getStorage = GetStorage();
  static String country = 'country';
  static String login = 'login';

  ///country
  static Future setCountry(String value) async {
    await getStorage.write(country, value);
  }

  static String getCountry() {
    return getStorage.read(country) ?? '';
  }

  ///login
  static Future setLogin(bool value) async {
    await getStorage.write(login, value);
  }

  static bool getLogin() {
    return getStorage.read(login) ?? false;
  }
}
