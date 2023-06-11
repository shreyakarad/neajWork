import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_woocommerce/controller/localization_controller.dart';
import 'package:flutter_woocommerce/controller/theme_controller.dart';
import 'package:flutter_woocommerce/helper/notification_helper.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/theme/dark_theme.dart';
import 'package:flutter_woocommerce/theme/light_theme.dart';
import 'package:flutter_woocommerce/util/app_constants.dart';
import 'package:flutter_woocommerce/util/messages.dart';
import 'package:flutter_woocommerce/view/screens/notification/model/notificaction_body.dart';
import 'package:flutter_woocommerce/view/screens/root/not_found_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';
import 'helper/di_container.dart' as di;
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  if (GetPlatform.isIOS || GetPlatform.isAndroid) {
    HttpOverrides.global = new MyHttpOverrides();
  }

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);

  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Map<String, Map<String, String>> _languages = await di.init();

  String _orderID;
  NotificationBody _body;
  try {
    if (GetPlatform.isMobile) {
      final RemoteMessage remoteMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      if (remoteMessage != null) {
        _body = NotificationHelper.convertNotification(remoteMessage.data);
        _orderID = remoteMessage.data['type'];
        print(
            '---Notification_Body---${remoteMessage.data.toString()}/${_body.message}');
      }
      await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
      FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
    }
  } catch (e) {}

  PendingDynamicLinkData _initialLink =
      await FirebaseDynamicLinks.instance.getInitialLink();

  runApp(MyApp(
      languages: _languages, orderID: _orderID, initialLink: _initialLink));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  final String orderID;
  final PendingDynamicLinkData initialLink;
  MyApp(
      {@required this.languages,
      @required this.orderID,
      @required this.initialLink});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Color(0xFFC0BAFB),
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light));

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Color(0x50202020),
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));

    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return GetBuilder<LocalizationController>(
          builder: (localizeController) {
            return GetMaterialApp(
              title: AppConstants.APP_NAME,
              debugShowCheckedModeBanner: false,
              navigatorKey: Get.key,
              theme: themeController.darkTheme ? dark : light,
              locale: localizeController.locale,
              translations: Messages(languages: languages),
              fallbackLocale: Locale(AppConstants.languages[0].languageCode,
                  AppConstants.languages[0].countryCode),
              initialRoute: RouteHelper.getSplashRoute(initialLink, orderID),
              getPages: RouteHelper.routes,
              unknownRoute: GetPage(name: '/', page: () => NotFoundScreen()),
              defaultTransition: Transition.topLevel,
              transitionDuration: Duration(milliseconds: 500),
            );
          },
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
