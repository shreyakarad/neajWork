class CouponModel {
  int id;
  String code;
  String amount;
  String status;
  String dateCreated;
  String discountType;
  String description;
  String dateExpires;
  int usageCount;
  bool individualUse;
  List<int> productIds;
  List<int> excludedProductIds;
  int usageLimit;
  int usageLimitPerUser;
  int limitUsageToXItems;
  bool freeShipping;
  List<int> productCategories;
  List<int> excludedProductCategories;
  bool excludeSaleItems;
  String minimumAmount;
  String maximumAmount;
  List<String> emailRestrictions;
  List<String> usedBy;

  CouponModel(
      {this.id,
        this.code,
        this.amount,
        this.status,
        this.dateCreated,
        this.discountType,
        this.description,
        this.dateExpires,
        this.usageCount,
        this.individualUse,
        this.productIds,
        this.excludedProductIds,
        this.usageLimit,
        this.usageLimitPerUser,
        this.limitUsageToXItems,
        this.freeShipping,
        this.productCategories,
        this.excludedProductCategories,
        this.excludeSaleItems,
        this.minimumAmount,
        this.maximumAmount,
        this.emailRestrictions,
        this.usedBy
      });

  CouponModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    amount = json['amount'];
    status = json['status'];
    dateCreated = json['date_created'];
    discountType = json['discount_type'];
    description = json['description'];
    dateExpires = json['date_expires'];
    usageCount = json['usage_count'];
    individualUse = json['individual_use'];
    productIds = json['product_ids'].cast<int>();
    excludedProductIds = json['excluded_product_ids'].cast<int>();
    usageLimit = json['usage_limit'];
    usageLimitPerUser = json['usage_limit_per_user'];
    limitUsageToXItems = json['limit_usage_to_x_items'];
    freeShipping = json['free_shipping'];
    productCategories = json['product_categories'].cast<int>();
    excludedProductCategories = json['excluded_product_categories'].cast<int>();
    excludeSaleItems = json['exclude_sale_items'];
    minimumAmount = json['minimum_amount'];
    maximumAmount = json['maximum_amount'];
    emailRestrictions = json['email_restrictions'].cast<String>();
    usedBy = json['used_by'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['date_created'] = this.dateCreated;
    data['discount_type'] = this.discountType;
    data['description'] = this.description;
    data['date_expires'] = this.dateExpires;
    data['usage_count'] = this.usageCount;
    data['individual_use'] = this.individualUse;
    data['product_ids'] = this.productIds;
    data['excluded_product_ids'] = this.excludedProductIds;
    data['usage_limit'] = this.usageLimit;
    data['usage_limit_per_user'] = this.usageLimitPerUser;
    data['limit_usage_to_x_items'] = this.limitUsageToXItems;
    data['free_shipping'] = this.freeShipping;
    data['product_categories'] = this.productCategories;
    data['excluded_product_categories'] = this.excludedProductCategories;
    data['exclude_sale_items'] = this.excludeSaleItems;
    data['minimum_amount'] = this.minimumAmount;
    data['maximum_amount'] = this.maximumAmount;
    data['email_restrictions'] = this.emailRestrictions;
    data['used_by'] = this.usedBy;
    return data;
  }
}
