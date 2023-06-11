class DokanProductModel {
  int id;
  String name;
  String slug;
  String postAuthor;
  String permalink;
  String dateCreated;
  String dateCreatedGmt;
  String dateModified;
  String dateModifiedGmt;
  String type;
  String status;
  bool featured;
  String catalogVisibility;
  String description;
  String shortDescription;
  String sku;
  String price;
  String regularPrice;
  String salePrice;
  Null dateOnSaleFrom;
  Null dateOnSaleFromGmt;
  Null dateOnSaleTo;
  Null dateOnSaleToGmt;
  String priceHtml;
  bool onSale;
  bool purchasable;
  int totalSales;
  bool virtual;
  bool downloadable;
  List<Null> downloads;
  int downloadLimit;
  int downloadExpiry;
  String externalUrl;
  String buttonText;
  String taxStatus;
  String taxClass;
  bool manageStock;
  int stockQuantity;
  String lowStockAmount;
  bool inStock;
  String backorders;
  bool backordersAllowed;
  bool backordered;
  bool soldIndividually;
  String weight;
  Dimensions dimensions;
  bool shippingRequired;
  bool shippingTaxable;
  String shippingClass;
  int shippingClassId;
  bool reviewsAllowed;
  String averageRating;
  int ratingCount;
  List<int> relatedIds;
  List<Null> upsellIds;
  List<Null> crossSellIds;
  int parentId;
  String purchaseNote;
  List<Categories> categories;
  List<Null> tags;
  List<Images> images;
  List<Attributes> attributes;
  List<Null> defaultAttributes;
  List<Null> variations;
  List<Null> groupedProducts;
  int menuOrder;
  List<MetaData> metaData;
  Store store;
  bool isPurchased;
  List<AttributesData> attributesData;

  DokanProductModel(
      {this.id,
        this.name,
        this.slug,
        this.postAuthor,
        this.permalink,
        this.dateCreated,
        this.dateCreatedGmt,
        this.dateModified,
        this.dateModifiedGmt,
        this.type,
        this.status,
        this.featured,
        this.catalogVisibility,
        this.description,
        this.shortDescription,
        this.sku,
        this.price,
        this.regularPrice,
        this.salePrice,
        this.dateOnSaleFrom,
        this.dateOnSaleFromGmt,
        this.dateOnSaleTo,
        this.dateOnSaleToGmt,
        this.priceHtml,
        this.onSale,
        this.purchasable,
        this.totalSales,
        this.virtual,
        this.downloadable,
        this.downloads,
        this.downloadLimit,
        this.downloadExpiry,
        this.externalUrl,
        this.buttonText,
        this.taxStatus,
        this.taxClass,
        this.manageStock,
        this.stockQuantity,
        this.lowStockAmount,
        this.inStock,
        this.backorders,
        this.backordersAllowed,
        this.backordered,
        this.soldIndividually,
        this.weight,
        this.dimensions,
        this.shippingRequired,
        this.shippingTaxable,
        this.shippingClass,
        this.shippingClassId,
        this.reviewsAllowed,
        this.averageRating,
        this.ratingCount,
        this.relatedIds,
        this.upsellIds,
        this.crossSellIds,
        this.parentId,
        this.purchaseNote,
        this.categories,
        this.tags,
        this.images,
        this.attributes,
        this.defaultAttributes,
        this.variations,
        this.groupedProducts,
        this.menuOrder,
        this.metaData,
        this.store,
        this.isPurchased,
        this.attributesData});

  DokanProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    postAuthor = json['post_author'];
    permalink = json['permalink'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    type = json['type'];
    status = json['status'];
    featured = json['featured'];
    catalogVisibility = json['catalog_visibility'];
    description = json['description'];
    shortDescription = json['short_description'];
    sku = json['sku'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    dateOnSaleFrom = json['date_on_sale_from'];
    dateOnSaleFromGmt = json['date_on_sale_from_gmt'];
    dateOnSaleTo = json['date_on_sale_to'];
    dateOnSaleToGmt = json['date_on_sale_to_gmt'];
    priceHtml = json['price_html'];
    onSale = json['on_sale'];
    purchasable = json['purchasable'];
    totalSales = json['total_sales'];
    virtual = json['virtual'];
    downloadable = json['downloadable'];

    downloadLimit = json['download_limit'];
    downloadExpiry = json['download_expiry'];
    externalUrl = json['external_url'];
    buttonText = json['button_text'];
    taxStatus = json['tax_status'];
    taxClass = json['tax_class'];
    manageStock = json['manage_stock'];
    stockQuantity = json['stock_quantity'];
    lowStockAmount = json['low_stock_amount'];
    inStock = json['in_stock'];
    backorders = json['backorders'];
    backordersAllowed = json['backorders_allowed'];
    backordered = json['backordered'];
    soldIndividually = json['sold_individually'];
    weight = json['weight'];
    dimensions = json['dimensions'] != null
        ? new Dimensions.fromJson(json['dimensions'])
        : null;
    shippingRequired = json['shipping_required'];
    shippingTaxable = json['shipping_taxable'];
    shippingClass = json['shipping_class'];
    shippingClassId = json['shipping_class_id'];
    reviewsAllowed = json['reviews_allowed'];
    averageRating = json['average_rating'];
    ratingCount = json['rating_count'];
    relatedIds = json['related_ids'].cast<int>();


    parentId = json['parent_id'];
    purchaseNote = json['purchase_note'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }

    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes.add(new Attributes.fromJson(v));
      });
    }



    menuOrder = json['menu_order'];
    if (json['meta_data'] != null) {
      metaData = <MetaData>[];
      json['meta_data'].forEach((v) {
        metaData.add(new MetaData.fromJson(v));
      });
    }
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
    isPurchased = json['is_purchased'];
    if (json['attributesData'] != null) {
      attributesData = <AttributesData>[];
      json['attributesData'].forEach((v) {
        attributesData.add(new AttributesData.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['post_author'] = this.postAuthor;
    data['permalink'] = this.permalink;
    data['date_created'] = this.dateCreated;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['date_modified'] = this.dateModified;
    data['date_modified_gmt'] = this.dateModifiedGmt;
    data['type'] = this.type;
    data['status'] = this.status;
    data['featured'] = this.featured;
    data['catalog_visibility'] = this.catalogVisibility;
    data['description'] = this.description;
    data['short_description'] = this.shortDescription;
    data['sku'] = this.sku;
    data['price'] = this.price;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    data['date_on_sale_from'] = this.dateOnSaleFrom;
    data['date_on_sale_from_gmt'] = this.dateOnSaleFromGmt;
    data['date_on_sale_to'] = this.dateOnSaleTo;
    data['date_on_sale_to_gmt'] = this.dateOnSaleToGmt;
    data['price_html'] = this.priceHtml;
    data['on_sale'] = this.onSale;
    data['purchasable'] = this.purchasable;
    data['total_sales'] = this.totalSales;
    data['virtual'] = this.virtual;
    data['downloadable'] = this.downloadable;

    data['download_limit'] = this.downloadLimit;
    data['download_expiry'] = this.downloadExpiry;
    data['external_url'] = this.externalUrl;
    data['button_text'] = this.buttonText;
    data['tax_status'] = this.taxStatus;
    data['tax_class'] = this.taxClass;
    data['manage_stock'] = this.manageStock;
    data['stock_quantity'] = this.stockQuantity;
    data['low_stock_amount'] = this.lowStockAmount;
    data['in_stock'] = this.inStock;
    data['backorders'] = this.backorders;
    data['backorders_allowed'] = this.backordersAllowed;
    data['backordered'] = this.backordered;
    data['sold_individually'] = this.soldIndividually;
    data['weight'] = this.weight;
    if (this.dimensions != null) {
      data['dimensions'] = this.dimensions.toJson();
    }
    data['shipping_required'] = this.shippingRequired;
    data['shipping_taxable'] = this.shippingTaxable;
    data['shipping_class'] = this.shippingClass;
    data['shipping_class_id'] = this.shippingClassId;
    data['reviews_allowed'] = this.reviewsAllowed;
    data['average_rating'] = this.averageRating;
    data['rating_count'] = this.ratingCount;
    data['related_ids'] = this.relatedIds;


    data['parent_id'] = this.parentId;
    data['purchase_note'] = this.purchaseNote;
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }




    data['menu_order'] = this.menuOrder;
    if (this.metaData != null) {
      data['meta_data'] = this.metaData.map((v) => v.toJson()).toList();
    }
    if (this.store != null) {
      data['store'] = this.store.toJson();
    }
    data['is_purchased'] = this.isPurchased;
    if (this.attributesData != null) {
      data['attributesData'] =
          this.attributesData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dimensions {
  String length;
  String width;
  String height;

  Dimensions({this.length, this.width, this.height});

  Dimensions.fromJson(Map<String, dynamic> json) {
    length = json['length'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['length'] = this.length;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

class Categories {
  int id;
  String name;
  String slug;

  Categories({this.id, this.name, this.slug});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    return data;
  }
}

class Images {
  int id;
  String dateCreated;
  String dateCreatedGmt;
  String dateModified;
  String dateModifiedGmt;
  String src;
  String name;
  String alt;
  int position;

  Images(
      {this.id,
        this.dateCreated,
        this.dateCreatedGmt,
        this.dateModified,
        this.dateModifiedGmt,
        this.src,
        this.name,
        this.alt,
        this.position});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    src = json['src'];
    name = json['name'];
    alt = json['alt'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date_created'] = this.dateCreated;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['date_modified'] = this.dateModified;
    data['date_modified_gmt'] = this.dateModifiedGmt;
    data['src'] = this.src;
    data['name'] = this.name;
    data['alt'] = this.alt;
    data['position'] = this.position;
    return data;
  }
}

class Attributes {
  int id;
  String slug;
  String name;
  int position;
  bool visible;
  bool variation;
  List<String> options;

  Attributes(
      {this.id,
        this.slug,
        this.name,
        this.position,
        this.visible,
        this.variation,
        this.options});

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    name = json['name'];
    position = json['position'];
    visible = json['visible'];
    variation = json['variation'];
    options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['name'] = this.name;
    data['position'] = this.position;
    data['visible'] = this.visible;
    data['variation'] = this.variation;
    data['options'] = this.options;
    return data;
  }
}

class MetaData {
  int id;
  String key;
  String value;

  MetaData({this.id, this.key, this.value});

  MetaData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}

class Store {
  int id;
  String storeName;
  String firstName;
  String lastName;
  Social social;
  String phone;
  bool showEmail;
  Address address;
  String location;
  String banner;
  int bannerId;
  String gravatar;
  int gravatarId;
  String shopUrl;
  int productsPerPage;
  bool showMoreProductTab;
  bool tocEnabled;
  String storeToc;
  bool featured;
  Rating rating;
  bool enabled;
  String registered;
  String payment;
  bool trusted;
  StoreOpenClose storeOpenClose;

  Store(
      {this.id,
        this.storeName,
        this.firstName,
        this.lastName,
        this.social,
        this.phone,
        this.showEmail,
        this.address,
        this.location,
        this.banner,
        this.bannerId,
        this.gravatar,
        this.gravatarId,
        this.shopUrl,
        this.productsPerPage,
        this.showMoreProductTab,
        this.tocEnabled,
        this.storeToc,
        this.featured,
        this.rating,
        this.enabled,
        this.registered,
        this.payment,
        this.trusted,
        this.storeOpenClose});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeName = json['store_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    social =
    json['social'] != null ? new Social.fromJson(json['social']) : null;
    phone = json['phone'];
    showEmail = json['show_email'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    location = json['location'];
    banner = json['banner'];
    bannerId = json['banner_id'];
    gravatar = json['gravatar'];
    gravatarId = json['gravatar_id'];
    shopUrl = json['shop_url'];
    productsPerPage = json['products_per_page'];
    showMoreProductTab = json['show_more_product_tab'];
    tocEnabled = json['toc_enabled'];
    storeToc = json['store_toc'];
    featured = json['featured'];
    rating =
    json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
    enabled = json['enabled'];
    registered = json['registered'];
    payment = json['payment'];
    trusted = json['trusted'];
    storeOpenClose = json['store_open_close'] != null
        ? new StoreOpenClose.fromJson(json['store_open_close'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_name'] = this.storeName;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    if (this.social != null) {
      data['social'] = this.social.toJson();
    }
    data['phone'] = this.phone;
    data['show_email'] = this.showEmail;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['location'] = this.location;
    data['banner'] = this.banner;
    data['banner_id'] = this.bannerId;
    data['gravatar'] = this.gravatar;
    data['gravatar_id'] = this.gravatarId;
    data['shop_url'] = this.shopUrl;
    data['products_per_page'] = this.productsPerPage;
    data['show_more_product_tab'] = this.showMoreProductTab;
    data['toc_enabled'] = this.tocEnabled;
    data['store_toc'] = this.storeToc;
    data['featured'] = this.featured;
    if (this.rating != null) {
      data['rating'] = this.rating.toJson();
    }
    data['enabled'] = this.enabled;
    data['registered'] = this.registered;
    data['payment'] = this.payment;
    data['trusted'] = this.trusted;
    if (this.storeOpenClose != null) {
      data['store_open_close'] = this.storeOpenClose.toJson();
    }
    return data;
  }
}

class Social {
  String fb;
  String youtube;
  String twitter;
  String linkedin;
  String pinterest;
  String instagram;

  Social(
      {this.fb,
        this.youtube,
        this.twitter,
        this.linkedin,
        this.pinterest,
        this.instagram});

  Social.fromJson(Map<String, dynamic> json) {
    fb = json['fb'];
    youtube = json['youtube'];
    twitter = json['twitter'];
    linkedin = json['linkedin'];
    pinterest = json['pinterest'];
    instagram = json['instagram'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fb'] = this.fb;
    data['youtube'] = this.youtube;
    data['twitter'] = this.twitter;
    data['linkedin'] = this.linkedin;
    data['pinterest'] = this.pinterest;
    data['instagram'] = this.instagram;
    return data;
  }
}

class Address {
  String street1;
  String street2;
  String city;
  String zip;
  String state;
  String country;

  Address(
      {this.street1,
        this.street2,
        this.city,
        this.zip,
        this.state,
        this.country});

  Address.fromJson(Map<String, dynamic> json) {
    street1 = json['street_1'];
    street2 = json['street_2'];
    city = json['city'];
    zip = json['zip'];
    state = json['state'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street_1'] = this.street1;
    data['street_2'] = this.street2;
    data['city'] = this.city;
    data['zip'] = this.zip;
    data['state'] = this.state;
    data['country'] = this.country;
    return data;
  }
}

class Rating {
  String rating;
  int count;

  Rating({this.rating, this.count});

  Rating.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rating'] = this.rating;
    data['count'] = this.count;
    return data;
  }
}

class StoreOpenClose {
  bool enabled;
  String openNotice;
  String closeNotice;

  StoreOpenClose({this.enabled, this.openNotice, this.closeNotice});

  StoreOpenClose.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'];

    openNotice = json['open_notice'];
    closeNotice = json['close_notice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enabled'] = this.enabled;
    data['open_notice'] = this.openNotice;
    data['close_notice'] = this.closeNotice;
    return data;
  }
}

class AttributesData {
  int id;
  String name;
  List<Options> options;
  int position;
  bool visible;
  bool variation;
  int isVisible;
  int isVariation;
  int isTaxonomy;
  String value;
  String label;

  AttributesData(
      {this.id,
        this.name,
        this.options,
        this.position,
        this.visible,
        this.variation,
        this.isVisible,
        this.isVariation,
        this.isTaxonomy,
        this.value,
        this.label});

  AttributesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options.add(new Options.fromJson(v));
      });
    }
    position = json['position'];
    visible = json['visible'];
    variation = json['variation'];
    isVisible = json['is_visible'];
    isVariation = json['is_variation'];
    isTaxonomy = json['is_taxonomy'];
    value = json['value'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.options != null) {
      data['options'] = this.options.map((v) => v.toJson()).toList();
    }
    data['position'] = this.position;
    data['visible'] = this.visible;
    data['variation'] = this.variation;
    data['is_visible'] = this.isVisible;
    data['is_variation'] = this.isVariation;
    data['is_taxonomy'] = this.isTaxonomy;
    data['value'] = this.value;
    data['label'] = this.label;
    return data;
  }
}

class Options {
  int termId;
  String name;
  String slug;
  int termGroup;
  int termTaxonomyId;
  String taxonomy;
  String description;
  int parent;
  int count;
  String filter;

  Options(
      {this.termId,
        this.name,
        this.slug,
        this.termGroup,
        this.termTaxonomyId,
        this.taxonomy,
        this.description,
        this.parent,
        this.count,
        this.filter});

  Options.fromJson(Map<String, dynamic> json) {
    termId = json['term_id'];
    name = json['name'];
    slug = json['slug'];
    termGroup = json['term_group'];
    termTaxonomyId = json['term_taxonomy_id'];
    taxonomy = json['taxonomy'];
    description = json['description'];
    parent = json['parent'];
    count = json['count'];
    filter = json['filter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['term_id'] = this.termId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['term_group'] = this.termGroup;
    data['term_taxonomy_id'] = this.termTaxonomyId;
    data['taxonomy'] = this.taxonomy;
    data['description'] = this.description;
    data['parent'] = this.parent;
    data['count'] = this.count;
    data['filter'] = this.filter;
    return data;
  }
}


class Self {
  String href;

  Self({this.href});

  Self.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}
