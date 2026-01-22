// To parse this JSON data, do
//
//     final productDetailsDataModel = productDetailsDataModelFromJson(jsonString);

import 'dart:convert';

ProductDetailsDataModel productDetailsDataModelFromJson(String str) => ProductDetailsDataModel.fromJson(json.decode(str));

String productDetailsDataModelToJson(ProductDetailsDataModel data) => json.encode(data.toJson());

class ProductDetailsDataModel {
  Product? product;
  List<Gellery>? gellery;
  String? tags;
  int? totalProductReviewQty;
  int? totalReview;
  List<dynamic>? productReviews;
  List<dynamic>? specifications;
  RecaptchaSetting? recaptchaSetting;
  List<Product>? relatedProducts;
  DefaultProfile? defaultProfile;
  bool? isSellerProduct;
  dynamic seller;
  int? sellerTotalProducts;
  List<dynamic>? thisSellerProducts;
  int? sellerReviewQty;
  int? sellerTotalReview;

  ProductDetailsDataModel({
    this.product,
    this.gellery,
    this.tags,
    this.totalProductReviewQty,
    this.totalReview,
    this.productReviews,
    this.specifications,
    this.recaptchaSetting,
    this.relatedProducts,
    this.defaultProfile,
    this.isSellerProduct,
    this.seller,
    this.sellerTotalProducts,
    this.thisSellerProducts,
    this.sellerReviewQty,
    this.sellerTotalReview,
  });

  factory ProductDetailsDataModel.fromJson(Map<String, dynamic> json) => ProductDetailsDataModel(
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
    gellery: json["gellery"] == null ? [] : List<Gellery>.from(json["gellery"]!.map((x) => Gellery.fromJson(x))),
    tags: json["tags"],
    totalProductReviewQty: json["totalProductReviewQty"],
    totalReview: json["totalReview"],
    productReviews: json["productReviews"] == null ? [] : List<dynamic>.from(json["productReviews"]!.map((x) => x)),
    specifications: json["specifications"] == null ? [] : List<dynamic>.from(json["specifications"]!.map((x) => x)),
    recaptchaSetting: json["recaptchaSetting"] == null ? null : RecaptchaSetting.fromJson(json["recaptchaSetting"]),
    relatedProducts: json["relatedProducts"] == null ? [] : List<Product>.from(json["relatedProducts"]!.map((x) => Product.fromJson(x))),
    defaultProfile: json["defaultProfile"] == null ? null : DefaultProfile.fromJson(json["defaultProfile"]),
    isSellerProduct: json["is_seller_product"],
    seller: json["seller"],
    sellerTotalProducts: json["sellerTotalProducts"],
    thisSellerProducts: json["this_seller_products"] == null ? [] : List<dynamic>.from(json["this_seller_products"]!.map((x) => x)),
    sellerReviewQty: json["sellerReviewQty"],
    sellerTotalReview: json["sellerTotalReview"],
  );

  Map<String, dynamic> toJson() => {
    "product": product?.toJson(),
    "gellery": gellery == null ? [] : List<dynamic>.from(gellery!.map((x) => x.toJson())),
    "tags": tags,
    "totalProductReviewQty": totalProductReviewQty,
    "totalReview": totalReview,
    "productReviews": productReviews == null ? [] : List<dynamic>.from(productReviews!.map((x) => x)),
    "specifications": specifications == null ? [] : List<dynamic>.from(specifications!.map((x) => x)),
    "recaptchaSetting": recaptchaSetting?.toJson(),
    "relatedProducts": relatedProducts == null ? [] : List<dynamic>.from(relatedProducts!.map((x) => x.toJson())),
    "defaultProfile": defaultProfile?.toJson(),
    "is_seller_product": isSellerProduct,
    "seller": seller,
    "sellerTotalProducts": sellerTotalProducts,
    "this_seller_products": thisSellerProducts == null ? [] : List<dynamic>.from(thisSellerProducts!.map((x) => x)),
    "sellerReviewQty": sellerReviewQty,
    "sellerTotalReview": sellerTotalReview,
  };
}

class DefaultProfile {
  String? image;

  DefaultProfile({
    this.image,
  });

  factory DefaultProfile.fromJson(Map<String, dynamic> json) => DefaultProfile(
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
  };
}

class Gellery {
  int? id;
  int? productId;
  String? image;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Gellery({
    this.id,
    this.productId,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Gellery.fromJson(Map<String, dynamic> json) => Gellery(
    id: json["id"],
    productId: json["product_id"],
    image: json["image"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "image": image,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Product {
  int? id;
  String? name;
  String? shortName;
  String? slug;
  String? thumbImage;
  int? vendorId;
  int? categoryId;
  int? subCategoryId;
  int? childCategoryId;
  int? brandId;
  int? qty;
  String? weight;
  int? soldQty;
  String? shortDescription;
  String? longDescription;
  dynamic videoLink;
  String? sku;
  String? seoTitle;
  String? seoDescription;
  double? price;
  double? offerPrice;
  dynamic tags;
  int? showHomepage;
  int? isUndefine;
  int? isFeatured;
  int? newProduct;
  int? isTop;
  int? isBest;
  int? status;
  int? isSpecification;
  int? approveByAdmin;
  IsBundleProduct? isBundleProduct;
  String? bundleProducts;
  BundleProductOfferType? bundleProductOfferType;
  String? bundleProductOffer;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? averageRating;
  dynamic totalSold;
  Brand? category;
  Brand? brand;
  List<dynamic>? activeVariants;
  List<dynamic>? avgReview;

  Product({
    this.id,
    this.name,
    this.shortName,
    this.slug,
    this.thumbImage,
    this.vendorId,
    this.categoryId,
    this.subCategoryId,
    this.childCategoryId,
    this.brandId,
    this.qty,
    this.weight,
    this.soldQty,
    this.shortDescription,
    this.longDescription,
    this.videoLink,
    this.sku,
    this.seoTitle,
    this.seoDescription,
    this.price,
    this.offerPrice,
    this.tags,
    this.showHomepage,
    this.isUndefine,
    this.isFeatured,
    this.newProduct,
    this.isTop,
    this.isBest,
    this.status,
    this.isSpecification,
    this.approveByAdmin,
    this.isBundleProduct,
    this.bundleProducts,
    this.bundleProductOfferType,
    this.bundleProductOffer,
    this.createdAt,
    this.updatedAt,
    this.averageRating,
    this.totalSold,
    this.category,
    this.brand,
    this.activeVariants,
    this.avgReview,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    shortName: json["short_name"],
    slug: json["slug"],
    thumbImage: json["thumb_image"],
    vendorId: json["vendor_id"],
    categoryId: json["category_id"],
    subCategoryId: json["sub_category_id"],
    childCategoryId: json["child_category_id"],
    brandId: json["brand_id"],
    qty: json["qty"],
    weight: json["weight"],
    soldQty: json["sold_qty"],
    shortDescription: json["short_description"],
    longDescription: json["long_description"],
    videoLink: json["video_link"],
    sku: json["sku"],
    seoTitle: json["seo_title"],
    seoDescription: json["seo_description"],
    price: json["price"]?.toDouble(),
    offerPrice: json["offer_price"]?.toDouble(),
    tags: json["tags"],
    showHomepage: json["show_homepage"],
    isUndefine: json["is_undefine"],
    isFeatured: json["is_featured"],
    newProduct: json["new_product"],
    isTop: json["is_top"],
    isBest: json["is_best"],
    status: json["status"],
    isSpecification: json["is_specification"],
    approveByAdmin: json["approve_by_admin"],
    isBundleProduct: isBundleProductValues.map[json["is_bundle_product"]]!,
    bundleProducts: json["bundle_products"],
    bundleProductOfferType: bundleProductOfferTypeValues.map[json["bundle_product_offer_type"]]!,
    bundleProductOffer: json["bundle_product_offer"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    averageRating: json["averageRating"],
    totalSold: json["totalSold"],
    category: json["category"] == null ? null : Brand.fromJson(json["category"]),
    brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
    activeVariants: json["active_variants"] == null ? [] : List<dynamic>.from(json["active_variants"]!.map((x) => x)),
    avgReview: json["avg_review"] == null ? [] : List<dynamic>.from(json["avg_review"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "short_name": shortName,
    "slug": slug,
    "thumb_image": thumbImage,
    "vendor_id": vendorId,
    "category_id": categoryId,
    "sub_category_id": subCategoryId,
    "child_category_id": childCategoryId,
    "brand_id": brandId,
    "qty": qty,
    "weight": weight,
    "sold_qty": soldQty,
    "short_description": shortDescription,
    "long_description": longDescription,
    "video_link": videoLink,
    "sku": sku,
    "seo_title": seoTitle,
    "seo_description": seoDescription,
    "price": price,
    "offer_price": offerPrice,
    "tags": tags,
    "show_homepage": showHomepage,
    "is_undefine": isUndefine,
    "is_featured": isFeatured,
    "new_product": newProduct,
    "is_top": isTop,
    "is_best": isBest,
    "status": status,
    "is_specification": isSpecification,
    "approve_by_admin": approveByAdmin,
    "is_bundle_product": isBundleProductValues.reverse[isBundleProduct],
    "bundle_products": bundleProducts,
    "bundle_product_offer_type": bundleProductOfferTypeValues.reverse[bundleProductOfferType],
    "bundle_product_offer": bundleProductOffer,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "averageRating": averageRating,
    "totalSold": totalSold,
    "category": category?.toJson(),
    "brand": brand?.toJson(),
    "active_variants": activeVariants == null ? [] : List<dynamic>.from(activeVariants!.map((x) => x)),
    "avg_review": avgReview == null ? [] : List<dynamic>.from(avgReview!.map((x) => x)),
  };
}

class Brand {
  int? id;
  String? name;
  String? slug;
  String? logo;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? icon;
  String? image;

  Brand({
    this.id,
    this.name,
    this.slug,
    this.logo,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.icon,
    this.image,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    logo: json["logo"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    icon: json["icon"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "logo": logo,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "icon": icon,
    "image": image,
  };
}

enum BundleProductOfferType {
  FIXED,
  PERCENTAGE
}

final bundleProductOfferTypeValues = EnumValues({
  "fixed": BundleProductOfferType.FIXED,
  "percentage": BundleProductOfferType.PERCENTAGE
});

enum IsBundleProduct {
  NO,
  YES
}

final isBundleProductValues = EnumValues({
  "no": IsBundleProduct.NO,
  "yes": IsBundleProduct.YES
});

class RecaptchaSetting {
  int? id;
  String? siteKey;
  String? secretKey;
  int? status;
  dynamic createdAt;
  DateTime? updatedAt;

  RecaptchaSetting({
    this.id,
    this.siteKey,
    this.secretKey,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory RecaptchaSetting.fromJson(Map<String, dynamic> json) => RecaptchaSetting(
    id: json["id"],
    siteKey: json["site_key"],
    secretKey: json["secret_key"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "site_key": siteKey,
    "secret_key": secretKey,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}




// // To parse this JSON data, do
// //
// //     final productDetailsDataModel = productDetailsDataModelFromJson(jsonString);
//
// import 'dart:convert';
//
// ProductDetailsDataModel productDetailsDataModelFromJson(String str) => ProductDetailsDataModel.fromJson(json.decode(str));
//
// String productDetailsDataModelToJson(ProductDetailsDataModel data) => json.encode(data.toJson());
//
// class ProductDetailsDataModel {
//   Product? product;
//   List<Gellery>? gellery;
//   String? tags;
//   int? totalProductReviewQty;
//   int? totalReview;
//   List<dynamic>? productReviews;
//   List<dynamic>? specifications;
//   RecaptchaSetting? recaptchaSetting;
//   List<RelatedProduct>? relatedProducts;
//   DefaultProfile? defaultProfile;
//   bool? isSellerProduct;
//   dynamic seller;
//   int? sellerTotalProducts;
//   List<dynamic>? thisSellerProducts;
//   int? sellerReviewQty;
//   int? sellerTotalReview;
//
//   ProductDetailsDataModel({
//     this.product,
//     this.gellery,
//     this.tags,
//     this.totalProductReviewQty,
//     this.totalReview,
//     this.productReviews,
//     this.specifications,
//     this.recaptchaSetting,
//     this.relatedProducts,
//     this.defaultProfile,
//     this.isSellerProduct,
//     this.seller,
//     this.sellerTotalProducts,
//     this.thisSellerProducts,
//     this.sellerReviewQty,
//     this.sellerTotalReview,
//   });
//
//   factory ProductDetailsDataModel.fromJson(Map<String, dynamic> json) => ProductDetailsDataModel(
//     product: json["product"] == null ? null : Product.fromJson(json["product"]),
//     gellery: json["gellery"] == null ? [] : List<Gellery>.from(json["gellery"]!.map((x) => Gellery.fromJson(x))),
//     tags: json["tags"],
//     totalProductReviewQty: json["totalProductReviewQty"],
//     totalReview: json["totalReview"],
//     productReviews: json["productReviews"] == null ? [] : List<dynamic>.from(json["productReviews"]!.map((x) => x)),
//     specifications: json["specifications"] == null ? [] : List<dynamic>.from(json["specifications"]!.map((x) => x)),
//     recaptchaSetting: json["recaptchaSetting"] == null ? null : RecaptchaSetting.fromJson(json["recaptchaSetting"]),
//     relatedProducts: json["relatedProducts"] == null ? [] : List<RelatedProduct>.from(json["relatedProducts"]!.map((x) => RelatedProduct.fromJson(x))),
//     defaultProfile: json["defaultProfile"] == null ? null : DefaultProfile.fromJson(json["defaultProfile"]),
//     isSellerProduct: json["is_seller_product"],
//     seller: json["seller"],
//     sellerTotalProducts: json["sellerTotalProducts"],
//     thisSellerProducts: json["this_seller_products"] == null ? [] : List<dynamic>.from(json["this_seller_products"]!.map((x) => x)),
//     sellerReviewQty: json["sellerReviewQty"],
//     sellerTotalReview: json["sellerTotalReview"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "product": product?.toJson(),
//     "gellery": gellery == null ? [] : List<dynamic>.from(gellery!.map((x) => x.toJson())),
//     "tags": tags,
//     "totalProductReviewQty": totalProductReviewQty,
//     "totalReview": totalReview,
//     "productReviews": productReviews == null ? [] : List<dynamic>.from(productReviews!.map((x) => x)),
//     "specifications": specifications == null ? [] : List<dynamic>.from(specifications!.map((x) => x)),
//     "recaptchaSetting": recaptchaSetting?.toJson(),
//     "relatedProducts": relatedProducts == null ? [] : List<dynamic>.from(relatedProducts!.map((x) => x.toJson())),
//     "defaultProfile": defaultProfile?.toJson(),
//     "is_seller_product": isSellerProduct,
//     "seller": seller,
//     "sellerTotalProducts": sellerTotalProducts,
//     "this_seller_products": thisSellerProducts == null ? [] : List<dynamic>.from(thisSellerProducts!.map((x) => x)),
//     "sellerReviewQty": sellerReviewQty,
//     "sellerTotalReview": sellerTotalReview,
//   };
// }
//
// class DefaultProfile {
//   String? image;
//
//   DefaultProfile({
//     this.image,
//   });
//
//   factory DefaultProfile.fromJson(Map<String, dynamic> json) => DefaultProfile(
//     image: json["image"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "image": image,
//   };
// }
//
// class Gellery {
//   int? id;
//   int? productId;
//   String? image;
//   int? status;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   Gellery({
//     this.id,
//     this.productId,
//     this.image,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory Gellery.fromJson(Map<String, dynamic> json) => Gellery(
//     id: json["id"],
//     productId: json["product_id"],
//     image: json["image"],
//     status: json["status"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "product_id": productId,
//     "image": image,
//     "status": status,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//   };
// }
//
// class Product {
//   int? id;
//   String? name;
//   String? shortName;
//   String? slug;
//   String? thumbImage;
//   int? vendorId;
//   int? categoryId;
//   int? subCategoryId;
//   int? childCategoryId;
//   int? brandId;
//   int? qty;
//   String? weight;
//   int? soldQty;
//   String? shortDescription;
//   String? longDescription;
//   dynamic videoLink;
//   dynamic sku;
//   String? seoTitle;
//   String? seoDescription;
//   int? price;
//   int? offerPrice;
//   dynamic tags;
//   int? showHomepage;
//   int? isUndefine;
//   int? isFeatured;
//   int? newProduct;
//   int? isTop;
//   int? isBest;
//   int? status;
//   int? isSpecification;
//   int? approveByAdmin;
//   IsBundleProduct? isBundleProduct;
//   String? bundleProducts;
//   BundleProductOfferType? bundleProductOfferType;
//   String? bundleProductOffer;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String? averageRating;
//   String? totalSold;
//   Brand? category;
//   Brand? brand;
//   List<dynamic>? activeVariants;
//   List<dynamic>? avgReview;
//
//   Product({
//     this.id,
//     this.name,
//     this.shortName,
//     this.slug,
//     this.thumbImage,
//     this.vendorId,
//     this.categoryId,
//     this.subCategoryId,
//     this.childCategoryId,
//     this.brandId,
//     this.qty,
//     this.weight,
//     this.soldQty,
//     this.shortDescription,
//     this.longDescription,
//     this.videoLink,
//     this.sku,
//     this.seoTitle,
//     this.seoDescription,
//     this.price,
//     this.offerPrice,
//     this.tags,
//     this.showHomepage,
//     this.isUndefine,
//     this.isFeatured,
//     this.newProduct,
//     this.isTop,
//     this.isBest,
//     this.status,
//     this.isSpecification,
//     this.approveByAdmin,
//     this.isBundleProduct,
//     this.bundleProducts,
//     this.bundleProductOfferType,
//     this.bundleProductOffer,
//     this.createdAt,
//     this.updatedAt,
//     this.averageRating,
//     this.totalSold,
//     this.category,
//     this.brand,
//     this.activeVariants,
//     this.avgReview,
//   });
//
//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//     id: json["id"],
//     name: json["name"],
//     shortName: json["short_name"],
//     slug: json["slug"],
//     thumbImage: json["thumb_image"],
//     vendorId: json["vendor_id"],
//     categoryId: json["category_id"],
//     subCategoryId: json["sub_category_id"],
//     childCategoryId: json["child_category_id"],
//     brandId: json["brand_id"],
//     qty: json["qty"],
//     weight: json["weight"],
//     soldQty: json["sold_qty"],
//     shortDescription: json["short_description"],
//     longDescription: json["long_description"],
//     videoLink: json["video_link"],
//     sku: json["sku"],
//     seoTitle: json["seo_title"],
//     seoDescription: json["seo_description"],
//     price: json["price"],
//     offerPrice: json["offer_price"],
//     tags: json["tags"],
//     showHomepage: json["show_homepage"],
//     isUndefine: json["is_undefine"],
//     isFeatured: json["is_featured"],
//     newProduct: json["new_product"],
//     isTop: json["is_top"],
//     isBest: json["is_best"],
//     status: json["status"],
//     isSpecification: json["is_specification"],
//     approveByAdmin: json["approve_by_admin"],
//     isBundleProduct: isBundleProductValues.map[json["is_bundle_product"]]!,
//     bundleProducts: json["bundle_products"],
//     bundleProductOfferType: bundleProductOfferTypeValues.map[json["bundle_product_offer_type"]]!,
//     bundleProductOffer: json["bundle_product_offer"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     averageRating: json["averageRating"],
//     totalSold: json["totalSold"],
//     category: json["category"] == null ? null : Brand.fromJson(json["category"]),
//     brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
//     activeVariants: json["active_variants"] == null ? [] : List<dynamic>.from(json["active_variants"]!.map((x) => x)),
//     avgReview: json["avg_review"] == null ? [] : List<dynamic>.from(json["avg_review"]!.map((x) => x)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "short_name": shortName,
//     "slug": slug,
//     "thumb_image": thumbImage,
//     "vendor_id": vendorId,
//     "category_id": categoryId,
//     "sub_category_id": subCategoryId,
//     "child_category_id": childCategoryId,
//     "brand_id": brandId,
//     "qty": qty,
//     "weight": weight,
//     "sold_qty": soldQty,
//     "short_description": shortDescription,
//     "long_description": longDescription,
//     "video_link": videoLink,
//     "sku": sku,
//     "seo_title": seoTitle,
//     "seo_description": seoDescription,
//     "price": price,
//     "offer_price": offerPrice,
//     "tags": tags,
//     "show_homepage": showHomepage,
//     "is_undefine": isUndefine,
//     "is_featured": isFeatured,
//     "new_product": newProduct,
//     "is_top": isTop,
//     "is_best": isBest,
//     "status": status,
//     "is_specification": isSpecification,
//     "approve_by_admin": approveByAdmin,
//     "is_bundle_product": isBundleProductValues.reverse[isBundleProduct],
//     "bundle_products": bundleProducts,
//     "bundle_product_offer_type": bundleProductOfferTypeValues.reverse[bundleProductOfferType],
//     "bundle_product_offer": bundleProductOffer,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "averageRating": averageRating,
//     "totalSold": totalSold,
//     "category": category?.toJson(),
//     "brand": brand?.toJson(),
//     "active_variants": activeVariants == null ? [] : List<dynamic>.from(activeVariants!.map((x) => x)),
//     "avg_review": avgReview == null ? [] : List<dynamic>.from(avgReview!.map((x) => x)),
//   };
// }
//
// class Brand {
//   int? id;
//   String? name;
//   String? slug;
//   String? logo;
//   int? status;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String? icon;
//   String? image;
//
//   Brand({
//     this.id,
//     this.name,
//     this.slug,
//     this.logo,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.icon,
//     this.image,
//   });
//
//   factory Brand.fromJson(Map<String, dynamic> json) => Brand(
//     id: json["id"],
//     name: json["name"],
//     slug: json["slug"],
//     logo: json["logo"],
//     status: json["status"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     icon: json["icon"],
//     image: json["image"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "slug": slug,
//     "logo": logo,
//     "status": status,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "icon": icon,
//     "image": image,
//   };
// }
//
// enum BundleProductOfferType {
//   FIXED,
//   PERCENTAGE
// }
//
// final bundleProductOfferTypeValues = EnumValues({
//   "fixed": BundleProductOfferType.FIXED,
//   "percentage": BundleProductOfferType.PERCENTAGE
// });
//
// enum IsBundleProduct {
//   NO,
//   YES
// }
//
// final isBundleProductValues = EnumValues({
//   "no": IsBundleProduct.NO,
//   "yes": IsBundleProduct.YES
// });
//
// class RecaptchaSetting {
//   int? id;
//   String? siteKey;
//   String? secretKey;
//   int? status;
//   dynamic createdAt;
//   DateTime? updatedAt;
//
//   RecaptchaSetting({
//     this.id,
//     this.siteKey,
//     this.secretKey,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory RecaptchaSetting.fromJson(Map<String, dynamic> json) => RecaptchaSetting(
//     id: json["id"],
//     siteKey: json["site_key"],
//     secretKey: json["secret_key"],
//     status: json["status"],
//     createdAt: json["created_at"],
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "site_key": siteKey,
//     "secret_key": secretKey,
//     "status": status,
//     "created_at": createdAt,
//     "updated_at": updatedAt?.toIso8601String(),
//   };
// }
//
// class RelatedProduct {
//   int? id;
//   String? name;
//   String? shortName;
//   String? slug;
//   String? thumbImage;
//   int? vendorId;
//   int? categoryId;
//   int? subCategoryId;
//   int? childCategoryId;
//   int? brandId;
//   int? qty;
//   String? weight;
//   int? soldQty;
//   String? shortDescription;
//   String? longDescription;
//   dynamic videoLink;
//   String? sku;
//   String? seoTitle;
//   String? seoDescription;
//   double? price;
//   double? offerPrice;
//   dynamic tags;
//   int? showHomepage;
//   int? isUndefine;
//   int? isFeatured;
//   int? newProduct;
//   int? isTop;
//   int? isBest;
//   int? status;
//   int? isSpecification;
//   int? approveByAdmin;
//   IsBundleProduct? isBundleProduct;
//   String? bundleProducts;
//   BundleProductOfferType? bundleProductOfferType;
//   String? bundleProductOffer;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String? averageRating;
//   dynamic totalSold;
//   List<dynamic>? activeVariants;
//
//   RelatedProduct({
//     this.id,
//     this.name,
//     this.shortName,
//     this.slug,
//     this.thumbImage,
//     this.vendorId,
//     this.categoryId,
//     this.subCategoryId,
//     this.childCategoryId,
//     this.brandId,
//     this.qty,
//     this.weight,
//     this.soldQty,
//     this.shortDescription,
//     this.longDescription,
//     this.videoLink,
//     this.sku,
//     this.seoTitle,
//     this.seoDescription,
//     this.price,
//     this.offerPrice,
//     this.tags,
//     this.showHomepage,
//     this.isUndefine,
//     this.isFeatured,
//     this.newProduct,
//     this.isTop,
//     this.isBest,
//     this.status,
//     this.isSpecification,
//     this.approveByAdmin,
//     this.isBundleProduct,
//     this.bundleProducts,
//     this.bundleProductOfferType,
//     this.bundleProductOffer,
//     this.createdAt,
//     this.updatedAt,
//     this.averageRating,
//     this.totalSold,
//     this.activeVariants,
//   });
//
//   factory RelatedProduct.fromJson(Map<String, dynamic> json) => RelatedProduct(
//     id: json["id"],
//     name: json["name"],
//     shortName: json["short_name"],
//     slug: json["slug"],
//     thumbImage: json["thumb_image"],
//     vendorId: json["vendor_id"],
//     categoryId: json["category_id"],
//     subCategoryId: json["sub_category_id"],
//     childCategoryId: json["child_category_id"],
//     brandId: json["brand_id"],
//     qty: json["qty"],
//     weight: json["weight"],
//     soldQty: json["sold_qty"],
//     shortDescription: json["short_description"],
//     longDescription: json["long_description"],
//     videoLink: json["video_link"],
//     sku: json["sku"],
//     seoTitle: json["seo_title"],
//     seoDescription: json["seo_description"],
//     price: json["price"]?.toDouble(),
//     offerPrice: json["offer_price"]?.toDouble(),
//     tags: json["tags"],
//     showHomepage: json["show_homepage"],
//     isUndefine: json["is_undefine"],
//     isFeatured: json["is_featured"],
//     newProduct: json["new_product"],
//     isTop: json["is_top"],
//     isBest: json["is_best"],
//     status: json["status"],
//     isSpecification: json["is_specification"],
//     approveByAdmin: json["approve_by_admin"],
//     isBundleProduct: isBundleProductValues.map[json["is_bundle_product"]]!,
//     bundleProducts: json["bundle_products"],
//     bundleProductOfferType: bundleProductOfferTypeValues.map[json["bundle_product_offer_type"]]!,
//     bundleProductOffer: json["bundle_product_offer"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     averageRating: json["averageRating"],
//     totalSold: json["totalSold"],
//     activeVariants: json["active_variants"] == null ? [] : List<dynamic>.from(json["active_variants"]!.map((x) => x)),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "short_name": shortName,
//     "slug": slug,
//     "thumb_image": thumbImage,
//     "vendor_id": vendorId,
//     "category_id": categoryId,
//     "sub_category_id": subCategoryId,
//     "child_category_id": childCategoryId,
//     "brand_id": brandId,
//     "qty": qty,
//     "weight": weight,
//     "sold_qty": soldQty,
//     "short_description": shortDescription,
//     "long_description": longDescription,
//     "video_link": videoLink,
//     "sku": sku,
//     "seo_title": seoTitle,
//     "seo_description": seoDescription,
//     "price": price,
//     "offer_price": offerPrice,
//     "tags": tags,
//     "show_homepage": showHomepage,
//     "is_undefine": isUndefine,
//     "is_featured": isFeatured,
//     "new_product": newProduct,
//     "is_top": isTop,
//     "is_best": isBest,
//     "status": status,
//     "is_specification": isSpecification,
//     "approve_by_admin": approveByAdmin,
//     "is_bundle_product": isBundleProductValues.reverse[isBundleProduct],
//     "bundle_products": bundleProducts,
//     "bundle_product_offer_type": bundleProductOfferTypeValues.reverse[bundleProductOfferType],
//     "bundle_product_offer": bundleProductOffer,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//     "averageRating": averageRating,
//     "totalSold": totalSold,
//     "active_variants": activeVariants == null ? [] : List<dynamic>.from(activeVariants!.map((x) => x)),
//   };
// }
//
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
