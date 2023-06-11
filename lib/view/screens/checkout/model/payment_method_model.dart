class PaymentMethodModel {
  String id;
  String title;
  String description;
  bool enabled;
  String methodTitle;
  String methodDescription;
  List<String> methodSupports;
  bool needsSetup;
  String connectionUrl;

  PaymentMethodModel(
      {this.id,
        this.title,
        this.description,
        this.enabled,
        this.methodTitle,
        this.methodDescription,
        this.methodSupports,
        this.needsSetup,
        this.connectionUrl});

  PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    enabled = json['enabled'];
    methodTitle = json['method_title'];
    methodDescription = json['method_description'];
    methodSupports = json['method_supports'].cast<String>();
    needsSetup = json['needs_setup'];
    connectionUrl = json['connection_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['enabled'] = this.enabled;
    data['method_title'] = this.methodTitle;
    data['method_description'] = this.methodDescription;
    data['method_supports'] = this.methodSupports;
    data['needs_setup'] = this.needsSetup;
    data['connection_url'] = this.connectionUrl;
    return data;
  }
}
