enum NotificationType{
  message,
  order,
  general,
  block,
  verification,
  offer,
  feed,
  activity,
}

class NotificationBody {
  NotificationType notificationType;
  String orderId;
  int adminId;
  int deliverymanId;
  int restaurantId;
  String type;
  String message;
  int conversationId;

  NotificationBody({
    this.notificationType,
    this.orderId,
    this.adminId,
    this.deliverymanId,
    this.restaurantId,
    this.type,
    this.message,
    this.conversationId,
  });

  NotificationBody.fromJson(Map<String, dynamic> json) {
    notificationType = convertToEnum(json['order_notification']);
    orderId = json['order_id'];
    adminId = json['admin_id'];
    deliverymanId = json['deliveryman_id'];
    restaurantId = json['restaurant_id'];
    type = json['type'];
    conversationId = json['conversation_id'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_notification'] = this.notificationType.toString();
    data['order_id'] = this.orderId;
    data['admin_id'] = this.adminId;
    data['deliveryman_id'] = this.deliverymanId;
    data['restaurant_id'] = this.restaurantId;
    data['type'] = this.type;
    data['conversation_id'] = this.conversationId;
    data['message'] = this.message;
    return data;
  }

  NotificationType convertToEnum(String enumString) {
    if(enumString == NotificationType.general.toString()) {
      return NotificationType.general;
    }else if(enumString == NotificationType.order.toString()) {
      return NotificationType.order;
    }else if(enumString == NotificationType.message.toString()) {
      return NotificationType.message;
    }else if(enumString == NotificationType.block.toString()) {
      return NotificationType.block;
    }else if(enumString == NotificationType.feed.toString()) {
      return NotificationType.feed;
    }else if(enumString == NotificationType.offer .toString()) {
      return NotificationType.offer;
    }else if(enumString == NotificationType.activity.toString()) {
      return NotificationType.activity;
    }
    return NotificationType.general;
  }

}
