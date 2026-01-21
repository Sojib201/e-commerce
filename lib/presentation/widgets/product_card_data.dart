
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/image_helper.dart';
import '../../data/models/home_data_model.dart';

class ProductCard extends Widget {
  final String? name;
  final String? shortName;
  final String? thumbImage;
  final double? price;
  final double? offerPrice;
  final String? averageRating;
  final String slug;
  final VoidCallback? onTap;

  const ProductCard({
    Key? key,
    this.name,
    this.shortName,
    this.thumbImage,
    this.price,
    this.offerPrice,
    this.averageRating,
    required this.slug,
    this.onTap,
  }) : super(key: key);

  @override
  Element createElement() => _ProductCardElement(this);
}

class _ProductCardElement extends ComponentElement {
  _ProductCardElement(ProductCard widget) : super(widget);

  @override
  ProductCard get widget => super.widget as ProductCard;

  @override
  Widget build() {
    final displayPrice = widget.offerPrice ?? widget.price ?? 0.0;
    final hasDiscount = widget.offerPrice != null && widget.price != null;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with favorite icon
            Stack(
              children: [
                Container(
                  height: 140.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
                    child: CachedNetworkImage(
                      imageUrl: ImageHelper.getFullImageUrl(widget.thumbImage),
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                          strokeWidth: 2.w,
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: Container(
                    width: 32.w,
                    height: 32.h,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite_border,
                      color: AppColors.textSecondary,
                      size: 18.sp,
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rating
                  Row(
                    children: [
                      ...List.generate(5, (index) {
                        return Icon(
                          Icons.star,
                          color: AppColors.star,
                          size: 14.sp,
                        );
                      }),
                    ],
                  ),

                  SizedBox(height: 6.h),

                  // Product name
                  Text(
                    widget.shortName ?? widget.name ?? '',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 8.h),

                  // Price
                  Row(
                    children: [
                      Text(
                        '\$${displayPrice.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.priceRed,
                        ),
                      ),
                      if (hasDiscount) ...[
                        SizedBox(width: 6.w),
                        Text(
                          '\$${widget.price!.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.oldPriceGray,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}