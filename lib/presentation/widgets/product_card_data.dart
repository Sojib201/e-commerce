import '../../core/constants/app_colors.dart';
import '../../core/utils/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductCard extends StatelessWidget {
  final String? name;
  final String? shortName;
  final String? thumbImage;
  final double? price;
  final double? offerPrice;
  final String slug;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    this.name,
    this.shortName,
    this.thumbImage,
    this.price,
    this.offerPrice,
    required this.slug,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          //borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Expanded(
            //   child: Stack(
            //     children: [
            //       Container(
            //         height: 140.h,
            //         width: double.infinity,
            //         decoration: BoxDecoration(
            //           color: AppColors.white,
            //           borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            //         ),
            //         child: ClipRRect(
            //           borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            //           child: CachedNetworkImage(
            //             imageUrl: ImageHelper.getFullImageUrl(thumbImage),
            //             fit: BoxFit.cover,
            //             placeholder: (context, url) => Center(
            //               child: CircularProgressIndicator(
            //                 valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
            //                 strokeWidth: 2.w,
            //               ),
            //             ),
            //             errorWidget: (context, url, error) => const Icon(Icons.error),
            //           ),
            //         ),
            //       ),
            //       Positioned(
            //         top: 8.h,
            //         right: 8.w,
            //         child: Icon(Icons.favorite, size: 20.sp, color: Colors.grey.shade300),
            //       ),
            //     ],
            //   ),
            // ),

            Expanded(
              flex: 12,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      // borderRadius: BorderRadius.vertical(top: Radius.circular(4.r)),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: ImageHelper.getFullImageUrl(thumbImage),
                      fit: BoxFit.contain,
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                  Positioned(
                    top: 6.h,
                    right: 6.w,
                    child: Icon(
                      Icons.favorite,
                      size: 18.sp,
                      color: const Color(0xFFD9D9D9),
                    ),
                  ),
                ],
              ),
            ),

            // Flexible(
            //   flex: 0,
            //   child: Padding(
            //     padding: EdgeInsets.all(10.w),
            //     child: Column(
            //       mainAxisSize: MainAxisSize.min,
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Row(
            //           children: List.generate(5, (index) =>
            //               Icon(Icons.star, color: Colors.amber, size: 14.sp)
            //           ),
            //         ),
            //         SizedBox(height: 6.h),
            //
            //         Text(
            //           shortName ?? name ?? '',
            //           style: TextStyle(
            //             fontSize: 13.sp,
            //             fontWeight: FontWeight.w500,
            //             color: Colors.black87,
            //           ),
            //           maxLines: 2,
            //           overflow: TextOverflow.ellipsis,
            //         ),
            //         SizedBox(height: 8.h),
            //
            //         Row(
            //           children: [
            //             Text(
            //               '\$${offerPrice ?? price}',
            //               style: TextStyle(
            //                 fontSize: 16.sp,
            //                 fontWeight: FontWeight.bold,
            //                 color: const Color(0xFFE94560),
            //               ),
            //             ),
            //             if (offerPrice != null) ...[
            //               SizedBox(width: 6.w),
            //               Text(
            //                 '\$$price',
            //                 style: TextStyle(
            //                   fontSize: 12.sp,
            //                   color: Colors.grey,
            //                   decoration: TextDecoration.lineThrough,
            //                 ),
            //               ),
            //             ],
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            Flexible(
              flex: 11,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: List.generate(5, (index) =>
                          Padding(
                            padding: EdgeInsets.only(right: 1.w),
                            child: Icon(Icons.star, color: Colors.orange, size: 14.sp),
                          )
                      ),
                    ),

                    Text(
                      shortName ?? name ?? '',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF222222),
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          '\$${offerPrice?.toStringAsFixed(0) ?? price?.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFEF262C),
                          ),
                        ),
                        if (offerPrice != null && offerPrice! < price!) ...[
                          SizedBox(width: 6.w),
                          Text(
                            '\$${price?.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: const Color(0xFFADADAD),
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}



//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import '../../core/constants/app_colors.dart';
// import '../../core/utils/image_helper.dart';
// import '../../data/models/home_data_model.dart';
//
// class ProductCard extends Widget {
//   final String? name;
//   final String? shortName;
//   final String? thumbImage;
//   final double? price;
//   final double? offerPrice;
//   final String? averageRating;
//   final String slug;
//   final VoidCallback? onTap;
//
//   const ProductCard({
//     super.key,
//     this.name,
//     this.shortName,
//     this.thumbImage,
//     this.price,
//     this.offerPrice,
//     this.averageRating,
//     required this.slug,
//     this.onTap,
//   });
//
//   @override
//   Element createElement() => _ProductCardElement(this);
// }
//
// class _ProductCardElement extends ComponentElement {
//   _ProductCardElement(ProductCard super.widget);
//
//   @override
//   ProductCard get widget => super.widget as ProductCard;
//
//   @override
//   Widget build() {
//     final displayPrice = widget.offerPrice ?? widget.price ?? 0.0;
//     final hasDiscount = widget.offerPrice != null && widget.price != null;
//
//     return GestureDetector(
//       onTap: widget.onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: AppColors.cardBackground,
//           borderRadius: BorderRadius.circular(12.r),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 10,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Image with favorite icon
//             Stack(
//               children: [
//                 Container(
//                   height: 140.h,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: AppColors.background,
//                     borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
//                     child: CachedNetworkImage(
//                       imageUrl: ImageHelper.getFullImageUrl(widget.thumbImage),
//                       fit: BoxFit.cover,
//                       placeholder: (context, url) => Center(
//                         child: CircularProgressIndicator(
//                           valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
//                           strokeWidth: 2.w,
//                         ),
//                       ),
//                       errorWidget: (context, url, error) => const Icon(Icons.error),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 8.h,
//                   right: 8.w,
//                   child: Container(
//                     width: 32.w,
//                     height: 32.h,
//                     decoration: const BoxDecoration(
//                       color: AppColors.white,
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(
//                       Icons.favorite_border,
//                       color: AppColors.textSecondary,
//                       size: 18.sp,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//
//             Padding(
//               padding: EdgeInsets.all(12.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Rating
//                   Row(
//                     children: [
//                       ...List.generate(5, (index) {
//                         return Icon(
//                           Icons.star,
//                           color: AppColors.star,
//                           size: 14.sp,
//                         );
//                       }),
//                     ],
//                   ),
//
//                   SizedBox(height: 6.h),
//
//                   // Product name
//                   Text(
//                     widget.shortName ?? widget.name ?? '',
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.w500,
//                       color: AppColors.textPrimary,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//
//                   SizedBox(height: 8.h),
//
//                   // Price
//                   Row(
//                     children: [
//                       Text(
//                         '\$${displayPrice.toStringAsFixed(0)}',
//                         style: TextStyle(
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.priceRed,
//                         ),
//                       ),
//                       if (hasDiscount) ...[
//                         SizedBox(width: 6.w),
//                         Text(
//                           '\$${widget.price!.toStringAsFixed(0)}',
//                           style: TextStyle(
//                             fontSize: 12.sp,
//                             color: AppColors.oldPriceGray,
//                             decoration: TextDecoration.lineThrough,
//                           ),
//                         ),
//                       ],
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }