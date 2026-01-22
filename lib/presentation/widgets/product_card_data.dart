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
