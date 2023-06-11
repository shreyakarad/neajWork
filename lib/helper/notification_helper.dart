import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_woocommerce/helper/route_helper.dart';
import 'package:flutter_woocommerce/util/app_constants.dart';
import 'package:flutter_woocommerce/view/screens/notification/model/notificaction_body.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class NotificationHelper {

  static Future<void> initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize = new AndroidInitializationSettings('notification_icon');
    var iOSInitialize = new IOSInitializationSettings();
    var initializationsSettings = new InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationsSettings, onSelectNotification: (String payload) async {
      NotificationBody _payload;
      try{
        print('payload');
        _payload = NotificationBody.fromJson(jsonDecode(payload));
        print(_payload.toString());
        print(_payload.notificationType.name);
        // if(payload != null && payload.isNotEmpty) {
        //   Get.toNamed(RouteHelper.getNotificationRoute());
        // }else {
        //   Get.toNamed(RouteHelper.getOrderDetailsRoute(int.parse(payload)));
        // }
        // if( != null) {
        //   Get.toNamed(RouteHelper.notificationViewRoute(message.data['type']));
        // }
        if(_payload.notificationType != null) {
          Get.toNamed(RouteHelper.notificationViewRoute(_payload.notificationType.name, fromNotification: true));
        }
      }catch (e) {}
      return;
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      NotificationBody _notificationBody = convertNotification(message.data);
      //print('onMessage: ${message.toMap()}');
      //print("onMessage: ${message.notification.title}/${message.notification.body}/${message.notification.titleLocKey}");
      print("onMessage: ${_notificationBody.notificationType}");
      print("onMessage: ${message.data['type']}");
      NotificationHelper.showNotification(message, flutterLocalNotificationsPlugin, true);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onOpenApp: ${message.notification.title}/${message.notification.body}/${message.notification.titleLocKey}");
      NotificationBody _notificationBody = convertNotification(message.data);
      try{
        // if(message.notification.titleLocKey != null && message.notification.titleLocKey.isNotEmpty) {
        //   Get.toNamed(RouteHelper.getOrderDetailsRoute(int.parse(message.notification.titleLocKey)));
        // }else {
        //   Get.toNamed(RouteHelper.getNotificationRoute());
        // }
        if(_notificationBody.type != null) {
          Get.toNamed(RouteHelper.notificationViewRoute(_notificationBody.notificationType.name,  fromNotification: true));
        }
      }catch (e) {}
    });
  }

  static Future<void> showNotification(RemoteMessage message, FlutterLocalNotificationsPlugin fln, bool data) async {
    String _title;
    String _body;
    String _orderID;
    String _image;
    NotificationBody _notificationBody = convertNotification(message.data);
    if(data) {
      _title = message.data['title'];
      _body = message.data['body'];
      _orderID = message.data['order_id'];
      _image = (message.data['image'] != null && message.data['image'].isNotEmpty)
          ? message.data['image'].startsWith('http') ? message.data['image']
          : '${AppConstants.BASE_URL}/storage/app/public/notification/${message.data['image']}' : null;
    }else {
      _title = message.notification.title;
      _body = message.notification.body;
      _orderID = message.notification.titleLocKey;
      if(GetPlatform.isAndroid) {
        _image = (message.notification.android.imageUrl != null && message.notification.android.imageUrl.isNotEmpty)
            ? message.notification.android.imageUrl.startsWith('http') ? message.notification.android.imageUrl
            : '${AppConstants.BASE_URL}/storage/app/public/notification/${message.notification.android.imageUrl}' : null;
      }else if(GetPlatform.isIOS) {
        _image = (message.notification.apple.imageUrl != null && message.notification.apple.imageUrl.isNotEmpty)
            ? message.notification.apple.imageUrl.startsWith('http') ? message.notification.apple.imageUrl
            : '${AppConstants.BASE_URL}/storage/app/public/notification/${message.notification.apple.imageUrl}' : null;
      }
    }

    if(_image != null && _image.isNotEmpty) {
      try{
        await showBigPictureNotificationHiddenLargeIcon(_title, _body, _orderID, _notificationBody,  _image, fln);
      }catch(e) {
        await showBigTextNotification(_title, _body, _orderID, _notificationBody, fln);
      }
    }else {
      await showBigTextNotification(_title, _body, _orderID, _notificationBody, fln);
    }
  }

  static Future<void> showTextNotification(String title, String body, String orderID, NotificationBody notificationBody, FlutterLocalNotificationsPlugin fln) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'stackfood', 'stackfood', playSound: true,
      importance: Importance.max, priority: Priority.max, sound: RawResourceAndroidNotificationSound('notification'),
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: notificationBody != null ? jsonEncode(notificationBody.toJson()) : null);
  }

  static Future<void> showBigTextNotification(String title, String body, String orderID, NotificationBody notificationBody, FlutterLocalNotificationsPlugin fln) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      body, htmlFormatBigText: true,
      contentTitle: title, htmlFormatContentTitle: true,
    );
    AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'stackfood', 'stackfood', importance: Importance.max,
      styleInformation: bigTextStyleInformation, priority: Priority.max, playSound: true,
      sound: RawResourceAndroidNotificationSound('notification'),
    );
    NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: notificationBody != null ? jsonEncode(notificationBody.toJson()) : null);
  }

  static Future<void> showBigPictureNotificationHiddenLargeIcon(String title, String body, String orderID, NotificationBody notificationBody, String image, FlutterLocalNotificationsPlugin fln) async {
    final String largeIconPath = await _downloadAndSaveFile(image, 'largeIcon');
    final String bigPicturePath = await _downloadAndSaveFile(image, 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath), hideExpandedLargeIcon: true,
      contentTitle: title, htmlFormatContentTitle: true,
      summaryText: body, htmlFormatSummaryText: true,
    );
    final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'stackfood', 'stackfood',
      largeIcon: FilePathAndroidBitmap(largeIconPath), priority: Priority.max, playSound: true,
      styleInformation: bigPictureStyleInformation, importance: Importance.max,
      sound: RawResourceAndroidNotificationSound('notification'),
    );
    final NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: notificationBody != null ? jsonEncode(notificationBody.toJson()) : null);
  }

  static Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  static NotificationBody convertNotification(Map<String, dynamic> data){
    if(data['type'] == 'general') {
      return NotificationBody(notificationType: NotificationType.general);
    }else if(data['type'] == 'order_status') {
      return NotificationBody(notificationType: NotificationType.order, orderId: data['order_id']);
    }else if(data['type'] == 'block'){
      return NotificationBody(notificationType: NotificationType.block, message: data['image'], orderId: data['order_id'] != null ? data['order_id'] : null);
    }else if(data['type'] == 'feed'){
      return NotificationBody(notificationType: NotificationType.feed, message: data['image'], orderId: data['order_id'] != null ? data['order_id'] : null);
    } else if(data['type'] == 'activity'){
      return NotificationBody(notificationType: NotificationType.activity, message: data['image'], orderId: data['order_id'] != null ? data['order_id'] : null);
    }else if(data['type'] == 'offer'){
      return NotificationBody(notificationType: NotificationType.offer, message: data['image'], orderId: data['order_id'] != null ? data['order_id'] : null);
    }else {
      return NotificationBody(
        notificationType: NotificationType.message,
        deliverymanId: data['sender_type'] == 'delivery_man' ? 0 : null,
        adminId: data['sender_type'] == 'admin' ? 0 : null,
        restaurantId: data['sender_type'] == 'vendor' ? 0 : null,
        conversationId: int.parse(data['conversation_id'].toString()),
      );
    }
  }
}

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  print("onBackground: ${message.notification.title}/${message.notification.body}/${message.notification.titleLocKey}/${message.notification}");
  print("onBackground: ${message.toMap().toString()}");
  // var androidInitialize = new AndroidInitializationSettings('notification_icon');
  // var iOSInitialize = new IOSInitializationSettings();
  // var initializationsSettings = new InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  // NotificationHelper.showNotification(message, flutterLocalNotificationsPlugin, true);
}