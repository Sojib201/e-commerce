import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/image_helper.dart';

class CategoryItem extends StatelessWidget {
  final String? name;
  final String? image;
  final VoidCallback? onTap;

  const CategoryItem({
    Key? key,
    this.name,
    this.image,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 70.w,
            height: 70.h,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: image != null
                  ? CachedNetworkImage(
                imageUrl: ImageHelper.getFullImageUrl(image),
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                    strokeWidth: 2.w,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.category,
                  size: 32.sp,
                  color: AppColors.textSecondary,
                ),
              )
                  : Icon(
                Icons.category,
                size: 32.sp,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          SizedBox(
            width: 70.w,
            child: Text(
              name ?? '',
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}