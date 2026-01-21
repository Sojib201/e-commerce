// To parse this JSON data, do
//
//     final homeDataModel = homeDataModelFromJson(jsonString);

import 'dart:convert';

HomeDataModel homeDataModelFromJson(String str) => HomeDataModel.fromJson(json.decode(str));

String homeDataModelToJson(HomeDataModel data) => json.encode(data.toJson());

class HomeDataModel {
  List<HomepageCategory>? homepageCategories;
  List<NewArrivalProduct>? newArrivalProducts;

  HomeDataModel({
    this.homepageCategories,
    this.newArrivalProducts,
  });

  factory HomeDataModel.fromJson(Map<String, dynamic> json) => HomeDataModel(
    homepageCategories: json["homepage_categories"] == null ? [] : List<HomepageCategory>.from(json["homepage_categories"]!.map((x) => HomepageCategory.fromJson(x))),
    newArrivalProducts: json["newArrivalProducts"] == null ? [] : List<NewArrivalProduct>.from(json["newArrivalProducts"]!.map((x) => NewArrivalProduct.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "homepage_categories": homepageCategories == null ? [] : List<dynamic>.from(homepageCategories!.map((x) => x.toJson())),
    "newArrivalProducts": newArrivalProducts == null ? [] : List<dynamic>.from(newArrivalProducts!.map((x) => x.toJson())),
  };
}

class HomepageCategory {
  int? id;
  String? name;
  String? slug;
  String? icon;
  String? image;

  HomepageCategory({
    this.id,
    this.name,
    this.slug,
    this.icon,
    this.image,
  });

  factory HomepageCategory.fromJson(Map<String, dynamic> json) => HomepageCategory(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    icon: json["icon"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "icon": icon,
    "image": image,
  };
}

class NewArrivalProduct {
  int? id;
  String? name;
  String? shortName;
  String? slug;
  String? thumbImage;
  int? qty;
  int? soldQty;
  double? price;
  double? offerPrice;
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
  List<ActiveVariant>? activeVariants;

  NewArrivalProduct({
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

  factory NewArrivalProduct.fromJson(Map<String, dynamic> json) => NewArrivalProduct(
    id: json["id"],
    name: json["name"],
    shortName: json["short_name"],
    slug: json["slug"],
    thumbImage: json["thumb_image"],
    qty: json["qty"],
    soldQty: json["sold_qty"],
    price: json["price"]?.toDouble(),
    offerPrice: json["offer_price"]?.toDouble(),
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
    activeVariants: json["active_variants"] == null ? [] : List<ActiveVariant>.from(json["active_variants"]!.map((x) => ActiveVariant.fromJson(x))),
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
    "active_variants": activeVariants == null ? [] : List<dynamic>.from(activeVariants!.map((x) => x.toJson())),
  };
}

class ActiveVariant {
  int? id;
  String? name;
  int? productId;
  List<ActiveVariantItem>? activeVariantItems;

  ActiveVariant({
    this.id,
    this.name,
    this.productId,
    this.activeVariantItems,
  });

  factory ActiveVariant.fromJson(Map<String, dynamic> json) => ActiveVariant(
    id: json["id"],
    name: json["name"],
    productId: json["product_id"],
    activeVariantItems: json["active_variant_items"] == null ? [] : List<ActiveVariantItem>.from(json["active_variant_items"]!.map((x) => ActiveVariantItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "product_id": productId,
    "active_variant_items": activeVariantItems == null ? [] : List<dynamic>.from(activeVariantItems!.map((x) => x.toJson())),
  };
}

class ActiveVariantItem {
  int? productVariantId;
  String? name;
  int? price;
  int? id;

  ActiveVariantItem({
    this.productVariantId,
    this.name,
    this.price,
    this.id,
  });

  factory ActiveVariantItem.fromJson(Map<String, dynamic> json) => ActiveVariantItem(
    productVariantId: json["product_variant_id"],
    name: json["name"],
    price: json["price"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "product_variant_id": productVariantId,
    "name": name,
    "price": price,
    "id": id,
  };
}
