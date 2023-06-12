// To parse this JSON data, do
//
//     final getCountryResponse = getCountryResponseFromJson(jsonString);

import 'dart:convert';

List<GetCountryResponse> getCountryResponseFromJson(String str) =>
    List<GetCountryResponse>.from(
        json.decode(str).map((x) => GetCountryResponse.fromJson(x)));

class GetCountryResponse {
  String code;
  String name;
  String symbol;
  Links links;

  GetCountryResponse({
    this.code,
    this.name,
    this.symbol,
    this.links,
  });

  factory GetCountryResponse.fromJson(Map<String, dynamic> json) =>
      GetCountryResponse(
        code: json["code"],
        name: json["name"],
        symbol: json["symbol"],
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "symbol": symbol,
        "_links": links.toJson(),
      };
}

class Links {
  List<Collection> self;
  List<Collection> collection;

  Links({
    this.self,
    this.collection,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: List<Collection>.from(
            json["self"].map((x) => Collection.fromJson(x))),
        collection: List<Collection>.from(
            json["collection"].map((x) => Collection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": List<Collection>.from(self.map((x) => x.toJson())),
        "collection": List<Collection>.from(collection.map((x) => x.toJson())),
      };
}

class Collection {
  String href;

  Collection({
    this.href,
  });

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
      };
}

// class GetCountryResponse {
//   String code;
//   String name;
//   String symbol;
//   Links links;
//
//   GetCountryResponse({
//     this.code,
//     this.name,
//     this.symbol,
//     this.links,
//   });
//
//   factory GetCountryResponse.fromJson(Map<String, dynamic> json) =>
//       GetCountryResponse(
//         code: json["code"],
//         name: json["name"],
//         symbol: json["symbol"],
//         links: Links.fromJson(json["_links"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "code": code,
//         "name": name,
//         "symbol": symbol,
//         "_links": links.toJson(),
//       };
// }
//
// class Links {
//   List<Collection> self;
//   List<Collection> collection;
//
//   Links({
//     this.self,
//     this.collection,
//   });
//
//   factory Links.fromJson(Map<String, dynamic> json) => Links(
//         self: List<Collection>.from(
//             json["self"].map((x) => Collection.fromJson(x))),
//         collection: List<Collection>.from(
//             json["collection"].map((x) => Collection.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "self": List<dynamic>.from(self.map((x) => x.toJson())),
//         "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
//       };
// }
//
// class Collection {
//   String href;
//
//   Collection({
//     this.href,
//   });
//
//   factory Collection.fromJson(Map<String, dynamic> json) => Collection(
//         href: json["href"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "href": href,
//       };
// }
