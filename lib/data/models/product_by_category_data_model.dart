// To parse this JSON data, do
//
//     final productByCategoryDataModel = productByCategoryDataModelFromJson(jsonString);

import 'dart:convert';

ProductByCategoryDataModel productByCategoryDataModelFromJson(String str) => ProductByCategoryDataModel.fromJson(json.decode(str));

String productByCategoryDataModelToJson(ProductByCategoryDataModel data) => json.encode(data.toJson());

class ProductByCategoryDataModel {
  Category? category;
  List<Product>? products;

  ProductByCategoryDataModel({
    this.category,
    this.products,
  });

  factory ProductByCategoryDataModel.fromJson(Map<String, dynamic> json) => ProductByCategoryDataModel(
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category": category?.toJson(),
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class Category {
  int? id;
  String? name;
  String? slug;
  String? icon;
  int? status;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;

  Category({
    this.id,
    this.name,
    this.slug,
    this.icon,
    this.status,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    icon: json["icon"],
    status: json["status"],
    image: json["image"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "icon": icon,
    "status": status,
    "image": image,
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
  List<dynamic>? activeVariants;

  Product({
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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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



// // To parse this JSON data, do
// //
// //     final productByCategoryDataModel = productByCategoryDataModelFromJson(jsonString);
//
// import 'dart:convert';
//
// ProductByCategoryDataModel productByCategoryDataModelFromJson(String str) => ProductByCategoryDataModel.fromJson(json.decode(str));
//
// String productByCategoryDataModelToJson(ProductByCategoryDataModel data) => json.encode(data.toJson());
//
// class ProductByCategoryDataModel {
//   Category? category;
//   List<Product>? products;
//
//   ProductByCategoryDataModel({
//     this.category,
//     this.products,
//   });
//
//   factory ProductByCategoryDataModel.fromJson(Map<String, dynamic> json) => ProductByCategoryDataModel(
//     category: json["category"] == null ? null : Category.fromJson(json["category"]),
//     products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "category": category?.toJson(),
//     "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
//   };
// }
//
// class Category {
//   int? id;
//   String? name;
//   String? slug;
//   String? icon;
//   int? status;
//   String? image;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//
//   Category({
//     this.id,
//     this.name,
//     this.slug,
//     this.icon,
//     this.status,
//     this.image,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//     id: json["id"],
//     name: json["name"],
//     slug: json["slug"],
//     icon: json["icon"],
//     status: json["status"],
//     image: json["image"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "slug": slug,
//     "icon": icon,
//     "status": status,
//     "image": image,
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
//   int? qty;
//   int? soldQty;
//   double? price;
//   double? offerPrice;
//   int? isUndefine;
//   int? isFeatured;
//   int? newProduct;
//   int? isTop;
//   int? isBest;
//   int? categoryId;
//   int? subCategoryId;
//   int? childCategoryId;
//   int? brandId;
//   String? averageRating;
//   String? totalSold;
//   List<ActiveVariant>? activeVariants;
//
//   Product({
//     this.id,
//     this.name,
//     this.shortName,
//     this.slug,
//     this.thumbImage,
//     this.qty,
//     this.soldQty,
//     this.price,
//     this.offerPrice,
//     this.isUndefine,
//     this.isFeatured,
//     this.newProduct,
//     this.isTop,
//     this.isBest,
//     this.categoryId,
//     this.subCategoryId,
//     this.childCategoryId,
//     this.brandId,
//     this.averageRating,
//     this.totalSold,
//     this.activeVariants,
//   });
//
//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//     id: json["id"],
//     name: json["name"],
//     shortName: json["short_name"],
//     slug: json["slug"],
//     thumbImage: json["thumb_image"],
//     qty: json["qty"],
//     soldQty: json["sold_qty"],
//     price: json["price"]?.toDouble(),
//     offerPrice: json["offer_price"]?.toDouble(),
//     isUndefine: json["is_undefine"],
//     isFeatured: json["is_featured"],
//     newProduct: json["new_product"],
//     isTop: json["is_top"],
//     isBest: json["is_best"],
//     categoryId: json["category_id"],
//     subCategoryId: json["sub_category_id"],
//     childCategoryId: json["child_category_id"],
//     brandId: json["brand_id"],
//     averageRating: json["averageRating"],
//     totalSold: json["totalSold"],
//     activeVariants: json["active_variants"] == null ? [] : List<ActiveVariant>.from(json["active_variants"]!.map((x) => ActiveVariant.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "short_name": shortName,
//     "slug": slug,
//     "thumb_image": thumbImage,
//     "qty": qty,
//     "sold_qty": soldQty,
//     "price": price,
//     "offer_price": offerPrice,
//     "is_undefine": isUndefine,
//     "is_featured": isFeatured,
//     "new_product": newProduct,
//     "is_top": isTop,
//     "is_best": isBest,
//     "category_id": categoryId,
//     "sub_category_id": subCategoryId,
//     "child_category_id": childCategoryId,
//     "brand_id": brandId,
//     "averageRating": averageRating,
//     "totalSold": totalSold,
//     "active_variants": activeVariants == null ? [] : List<dynamic>.from(activeVariants!.map((x) => x.toJson())),
//   };
// }
//
// class ActiveVariant {
//   int? id;
//   String? name;
//   int? productId;
//   List<ActiveVariantItem>? activeVariantItems;
//
//   ActiveVariant({
//     this.id,
//     this.name,
//     this.productId,
//     this.activeVariantItems,
//   });
//
//   factory ActiveVariant.fromJson(Map<String, dynamic> json) => ActiveVariant(
//     id: json["id"],
//     name: json["name"],
//     productId: json["product_id"],
//     activeVariantItems: json["active_variant_items"] == null ? [] : List<ActiveVariantItem>.from(json["active_variant_items"]!.map((x) => ActiveVariantItem.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "product_id": productId,
//     "active_variant_items": activeVariantItems == null ? [] : List<dynamic>.from(activeVariantItems!.map((x) => x.toJson())),
//   };
// }
//
// class ActiveVariantItem {
//   int? productVariantId;
//   String? name;
//   int? price;
//   int? id;
//
//   ActiveVariantItem({
//     this.productVariantId,
//     this.name,
//     this.price,
//     this.id,
//   });
//
//   factory ActiveVariantItem.fromJson(Map<String, dynamic> json) => ActiveVariantItem(
//     productVariantId: json["product_variant_id"],
//     name: json["name"],
//     price: json["price"],
//     id: json["id"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "product_variant_id": productVariantId,
//     "name": name,
//     "price": price,
//     "id": id,
//   };
// }
//
//
//
//
// // // To parse this JSON data, do
// // //
// // //     final productByCategoryDataModel = productByCategoryDataModelFromJson(jsonString);
// //
// // import 'dart:convert';
// //
// // ProductByCategoryDataModel productByCategoryDataModelFromJson(String str) => ProductByCategoryDataModel.fromJson(json.decode(str));
// //
// // String productByCategoryDataModelToJson(ProductByCategoryDataModel data) => json.encode(data.toJson());
// //
// // class ProductByCategoryDataModel {
// //   Category? category;
// //   List<Product>? products;
// //
// //   ProductByCategoryDataModel({
// //     this.category,
// //     this.products,
// //   });
// //
// //   factory ProductByCategoryDataModel.fromJson(Map<String, dynamic> json) => ProductByCategoryDataModel(
// //     category: json["category"] == null ? null : Category.fromJson(json["category"]),
// //     products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     "category": category?.toJson(),
// //     "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
// //   };
// // }
// //
// // class Category {
// //   int? id;
// //   String? name;
// //   String? slug;
// //   String? icon;
// //   int? status;
// //   String? image;
// //   DateTime? createdAt;
// //   DateTime? updatedAt;
// //
// //   Category({
// //     this.id,
// //     this.name,
// //     this.slug,
// //     this.icon,
// //     this.status,
// //     this.image,
// //     this.createdAt,
// //     this.updatedAt,
// //   });
// //
// //   factory Category.fromJson(Map<String, dynamic> json) => Category(
// //     id: json["id"],
// //     name: json["name"],
// //     slug: json["slug"],
// //     icon: json["icon"],
// //     status: json["status"],
// //     image: json["image"],
// //     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
// //     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     "id": id,
// //     "name": name,
// //     "slug": slug,
// //     "icon": icon,
// //     "status": status,
// //     "image": image,
// //     "created_at": createdAt?.toIso8601String(),
// //     "updated_at": updatedAt?.toIso8601String(),
// //   };
// // }
// //
// // class Product {
// //   int? id;
// //   String? name;
// //   String? shortName;
// //   String? slug;
// //   String? thumbImage;
// //   int? qty;
// //   int? soldQty;
// //   int? price;
// //   double? offerPrice;
// //   int? isUndefine;
// //   int? isFeatured;
// //   int? newProduct;
// //   int? isTop;
// //   int? isBest;
// //   int? categoryId;
// //   int? subCategoryId;
// //   int? childCategoryId;
// //   int? brandId;
// //   String? averageRating;
// //   dynamic totalSold;
// //   List<ActiveVariant>? activeVariants;
// //
// //   Product({
// //     this.id,
// //     this.name,
// //     this.shortName,
// //     this.slug,
// //     this.thumbImage,
// //     this.qty,
// //     this.soldQty,
// //     this.price,
// //     this.offerPrice,
// //     this.isUndefine,
// //     this.isFeatured,
// //     this.newProduct,
// //     this.isTop,
// //     this.isBest,
// //     this.categoryId,
// //     this.subCategoryId,
// //     this.childCategoryId,
// //     this.brandId,
// //     this.averageRating,
// //     this.totalSold,
// //     this.activeVariants,
// //   });
// //
// //   factory Product.fromJson(Map<String, dynamic> json) => Product(
// //     id: json["id"],
// //     name: json["name"],
// //     shortName: json["short_name"],
// //     slug: json["slug"],
// //     thumbImage: json["thumb_image"],
// //     qty: json["qty"],
// //     soldQty: json["sold_qty"],
// //     price: json["price"],
// //     offerPrice: json["offer_price"]?.toDouble(),
// //     isUndefine: json["is_undefine"],
// //     isFeatured: json["is_featured"],
// //     newProduct: json["new_product"],
// //     isTop: json["is_top"],
// //     isBest: json["is_best"],
// //     categoryId: json["category_id"],
// //     subCategoryId: json["sub_category_id"],
// //     childCategoryId: json["child_category_id"],
// //     brandId: json["brand_id"],
// //     averageRating: json["averageRating"],
// //     totalSold: json["totalSold"],
// //     activeVariants: json["active_variants"] == null ? [] : List<ActiveVariant>.from(json["active_variants"]!.map((x) => ActiveVariant.fromJson(x))),
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     "id": id,
// //     "name": name,
// //     "short_name": shortName,
// //     "slug": slug,
// //     "thumb_image": thumbImage,
// //     "qty": qty,
// //     "sold_qty": soldQty,
// //     "price": price,
// //     "offer_price": offerPrice,
// //     "is_undefine": isUndefine,
// //     "is_featured": isFeatured,
// //     "new_product": newProduct,
// //     "is_top": isTop,
// //     "is_best": isBest,
// //     "category_id": categoryId,
// //     "sub_category_id": subCategoryId,
// //     "child_category_id": childCategoryId,
// //     "brand_id": brandId,
// //     "averageRating": averageRating,
// //     "totalSold": totalSold,
// //     "active_variants": activeVariants == null ? [] : List<dynamic>.from(activeVariants!.map((x) => x.toJson())),
// //   };
// // }
// //
// // class ActiveVariant {
// //   int? id;
// //   String? name;
// //   int? productId;
// //   List<ActiveVariantItem>? activeVariantItems;
// //
// //   ActiveVariant({
// //     this.id,
// //     this.name,
// //     this.productId,
// //     this.activeVariantItems,
// //   });
// //
// //   factory ActiveVariant.fromJson(Map<String, dynamic> json) => ActiveVariant(
// //     id: json["id"],
// //     name: json["name"],
// //     productId: json["product_id"],
// //     activeVariantItems: json["active_variant_items"] == null ? [] : List<ActiveVariantItem>.from(json["active_variant_items"]!.map((x) => ActiveVariantItem.fromJson(x))),
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     "id": id,
// //     "name": name,
// //     "product_id": productId,
// //     "active_variant_items": activeVariantItems == null ? [] : List<dynamic>.from(activeVariantItems!.map((x) => x.toJson())),
// //   };
// // }
// //
// // class ActiveVariantItem {
// //   int? productVariantId;
// //   String? name;
// //   int? price;
// //   int? id;
// //
// //   ActiveVariantItem({
// //     this.productVariantId,
// //     this.name,
// //     this.price,
// //     this.id,
// //   });
// //
// //   factory ActiveVariantItem.fromJson(Map<String, dynamic> json) => ActiveVariantItem(
// //     productVariantId: json["product_variant_id"],
// //     name: json["name"],
// //     price: json["price"],
// //     id: json["id"],
// //   );
// //
// //   Map<String, dynamic> toJson() => {
// //     "product_variant_id": productVariantId,
// //     "name": name,
// //     "price": price,
// //     "id": id,
// //   };
// // }
