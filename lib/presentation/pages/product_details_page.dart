import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/image_helper.dart';
import '../bloc/product_details/product_details_bloc.dart';
import '../bloc/product_details/product_details_event.dart';
import '../bloc/product_details/product_details_state.dart';

class ProductDetailsPage extends StatefulWidget {
  final String slug;

  const ProductDetailsPage({
    Key? key,
    required this.slug,
  }) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int _selectedImageIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<ProductDetailsBloc>().add(LoadProductDetails(widget.slug));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            );
          }

          if (state is ProductDetailsError) {
            return Center(
              child: Text(state.message),
            );
          }

          if (state is ProductDetailsLoaded) {
            final product = state.productDetails.product;
            final gallery = state.productDetails.gellery ?? [];

            // Combine thumb image with gallery
            final allImages = [
              product?.thumbImage ?? '',
              ...gallery.map((g) => g.image ?? '')
            ];

            final displayPrice = product?.offerPrice ?? product?.price ?? 0;
            final hasDiscount = product?.offerPrice != null && product?.price != null;

            return SafeArea(
              child: Column(
                children: [
                  // App Bar
                  Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 40.w,
                            height: 40.h,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_back,
                              color: AppColors.white,
                              size: 20.sp,
                            ),
                          ),
                        ),
                        Text(
                          'Popular Sells',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.favorite,
                            color: AppColors.favoriteRed,
                            size: 20.sp,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Main Product Image
                          Container(
                            height: 280.h,
                            margin: EdgeInsets.symmetric(horizontal: 40.w),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: CachedNetworkImage(
                                imageUrl: ImageHelper.getFullImageUrl(allImages[_selectedImageIndex]),
                                fit: BoxFit.contain,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                                  ),
                                ),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                            ),
                          ),

                          SizedBox(height: 16.h),

                          // Thumbnail Images
                          if (allImages.length > 1)
                            SizedBox(
                              height: 70.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                itemCount: allImages.length,
                                itemBuilder: (context, index) {
                                  final isSelected = index == _selectedImageIndex;
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedImageIndex = index;
                                      });
                                    },
                                    child: Container(
                                      width: 60.w,
                                      height: 60.h,
                                      margin: EdgeInsets.only(right: 12.w),
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(8.r),
                                        border: Border.all(
                                          color: isSelected ? AppColors.primary : Colors.transparent,
                                          width: 2,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8.r),
                                        child: CachedNetworkImage(
                                          imageUrl: ImageHelper.getFullImageUrl(allImages[index]),
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => const Center(
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          ),
                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                          SizedBox(height: 20.h),

                          // Product Info
                          Container(
                            padding: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(24.r),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Price
                                Row(
                                  children: [
                                    Text(
                                      '\$${displayPrice.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.priceRed,
                                      ),
                                    ),
                                    if (hasDiscount) ...[
                                      SizedBox(width: 12.w),
                                      Text(
                                        '\$${product!.price!.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: AppColors.oldPriceGray,
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),

                                SizedBox(height: 8.h),

                                // Category
                                Text(
                                  product?.category?.name ?? 'MOBILE PHONES',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: AppColors.textSecondary,
                                    letterSpacing: 1.2,
                                  ),
                                ),

                                SizedBox(height: 12.h),

                                // Product Name
                                Text(
                                  product?.name ?? '',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),

                                SizedBox(height: 12.h),

                                // Rating
                                Row(
                                  children: [
                                    ...List.generate(5, (index) {
                                      return Icon(
                                        Icons.star,
                                        color: AppColors.star,
                                        size: 18.sp,
                                      );
                                    }),
                                    SizedBox(width: 8.w),
                                    Text(
                                      '${state.productDetails.totalReview} Reviews',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 20.h),

                                // Short Description
                                Text(
                                  product?.shortDescription ?? '',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColors.textSecondary,
                                    height: 1.5,
                                  ),
                                ),

                                SizedBox(height: 20.h),

                                // Introduction
                                Text(
                                  'Introduction',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),

                                SizedBox(height: 12.h),

                                Text(
                                  _stripHtml(product?.longDescription ?? ''),
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColors.textSecondary,
                                    height: 1.5,
                                  ),
                                  maxLines: 10,
                                  overflow: TextOverflow.ellipsis,
                                ),

                                SizedBox(height: 100.h),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.textSecondary.withOpacity(0.3)),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      size: 24.sp,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: Container(
                      width: 16.w,
                      height: 16.h,
                      decoration: const BoxDecoration(
                        color: AppColors.priceRed,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '3',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                ),
                child: Text(
                  'Add To Cart',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _stripHtml(String html) {
    return html.replaceAll(RegExp(r'<[^>]*>'), '').replaceAll('&nbsp;', ' ');
  }
}