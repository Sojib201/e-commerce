// To parse this JSON data, do
//
//     final productListDataModel = productListDataModelFromJson(jsonString);

import 'dart:convert';

ProductListDataModel productListDataModelFromJson(String str) => ProductListDataModel.fromJson(json.decode(str));

String productListDataModelToJson(ProductListDataModel data) => json.encode(data.toJson());

class ProductListDataModel {
  Products? products;

  ProductListDataModel({
    this.products,
  });

  factory ProductListDataModel.fromJson(Map<String, dynamic> json) => ProductListDataModel(
    products: json["products"] == null ? null : Products.fromJson(json["products"]),
  );

  Map<String, dynamic> toJson() => {
    "products": products?.toJson(),
  };
}

class Products {
  int? currentPage;
  List<Datum>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Products({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Datum {
  int? id;
  String? name;
  String? shortName;
  String? slug;
  String? thumbImage;
  int? qty;
  int? soldQty;
  int? price;
  int? offerPrice;
  int? isUndefine;
  int? isFeatured;
  int? newProduct;
  int? isTop;
  int? isBest;
  int? categoryId;
  int? subCategoryId;
  int? childCategoryId;
  int? brandId;
  String? averageRating;
  dynamic totalSold;
  List<dynamic>? activeVariants;

  Datum({
    this.id,
    this.name,
    this.shortName,
    this.slug,
    this.thumbImage,
    this.qty,
    this.soldQty,
    this.price,
    this.offerPrice,
    this.isUndefine,
    this.isFeatured,
    this.newProduct,
    this.isTop,
    this.isBest,
    this.categoryId,
    this.subCategoryId,
    this.childCategoryId,
    this.brandId,
    this.averageRating,
    this.totalSold,
    this.activeVariants,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    shortName: json["short_name"],
    slug: json["slug"],
    thumbImage: json["thumb_image"],
    qty: json["qty"],
    soldQty: json["sold_qty"],
    price: json["price"],
    offerPrice: json["offer_price"],
    isUndefine: json["is_undefine"],
    isFeatured: json["is_featured"],
    newProduct: json["new_product"],
    isTop: json["is_top"],
    isBest: json["is_best"],
    categoryId: json["category_id"],
    subCategoryId: json["sub_category_id"],
    childCategoryId: json["child_category_id"],
    brandId: json["brand_id"],
    averageRating: json["averageRating"],
    totalSold: json["totalSold"],
    activeVariants: json["active_variants"] == null ? [] : List<dynamic>.from(json["active_variants"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "short_name": shortName,
    "slug": slug,
    "thumb_image": thumbImage,
    "qty": qty,
    "sold_qty": soldQty,
    "price": price,
    "offer_price": offerPrice,
    "is_undefine": isUndefine,
    "is_featured": isFeatured,
    "new_product": newProduct,
    "is_top": isTop,
    "is_best": isBest,
    "category_id": categoryId,
    "sub_category_id": subCategoryId,
    "child_category_id": childCategoryId,
    "brand_id": brandId,
    "averageRating": averageRating,
    "totalSold": totalSold,
    "active_variants": activeVariants == null ? [] : List<dynamic>.from(activeVariants!.map((x) => x)),
  };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}
