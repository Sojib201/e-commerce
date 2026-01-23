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
  const ProductDetailsPage({super.key, required this.slug});

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
      backgroundColor: AppColors.lightYellow,
      body: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsLoading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          }

          if (state is ProductDetailsLoaded) {
            final product = state.productDetails.product;
            final gallery = state.productDetails.gellery ?? [];
            final allImages = [
              product?.thumbImage ?? '',
              ...gallery.map((g) => g.image ?? '')
            ];

            debugPrint('all image:${allImages.toString()}');

            final displayPrice = product?.offerPrice ?? product?.price ?? 0;
            final oldPrice = product?.price;
            final hasDiscount = product?.offerPrice != null && product?.offerPrice != product?.price;

            return SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: CircleAvatar(
                              radius: 18.r,
                              backgroundColor: const Color(0xFFFFCC33),
                              child: Icon(Icons.arrow_back_ios_new, size: 14.sp, color: Colors.black),
                            ),
                          ),
                          Text(
                            'Popular Sells',
                            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: Colors.black87),
                          ),
                          Icon(Icons.favorite, color: Colors.red, size: 28.sp),
                        ],
                      ),
                    ),

                    Container(
                      height: 250.h,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: CachedNetworkImage(
                        imageUrl: ImageHelper.getFullImageUrl(allImages[_selectedImageIndex]),
                        fit: BoxFit.contain,
                        errorWidget: (context, url, error) => const Icon(Icons.image_not_supported),
                      ),
                    ),

                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 40.h),
                          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 40.h),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '\$${displayPrice.toStringAsFixed(2)}',
                                    style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold, color: Colors.red),
                                  ),
                                  if (hasDiscount) ...[
                                    SizedBox(width: 8.w),
                                    Text(
                                      '\$${oldPrice?.toStringAsFixed(2)}',
                                      style: TextStyle(fontSize: 16.sp, color: Colors.grey.shade400, decoration: TextDecoration.lineThrough),
                                    ),
                                  ],
                                ],
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                product?.category?.name?.toUpperCase() ?? "N/A",
                                style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade400, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                product?.name ?? 'N/A',
                                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600, color: Colors.black87, height: 1.2),
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  ...List.generate(5, (index) => Icon(Icons.star, color: const Color(0xFFFBC02D), size: 18.sp)),
                                  SizedBox(width: 8.w),
                                  Text('${state.productDetails.totalReview ?? 0} Reviews', style: const TextStyle(color: Colors.black87)),
                                ],
                              ),
                              SizedBox(height: 20.h),
                              Text(product?.shortDescription ?? 'N/A', style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600, height: 1.5),),
                              SizedBox(height: 20.h),
                              Text('Introduction', style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
                              SizedBox(height: 10.h),
                              Text(
                                _stripHtml(product?.longDescription ?? ''),
                                style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600, height: 1.5),
                              ),
                              SizedBox(height: 20.h),
                              Text('Features :', style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold)),
                              SizedBox(height: 10.h),
                              _buildFeatureItem("slim body with metal cover"),
                              _buildFeatureItem("latest Intel Core i5 processor"),
                              _buildFeatureItem("8GB DDR4 RAM and 512GB SSD"),
                              SizedBox(height: 100.h),
                            ],
                          ),
                        ),

                        Positioned(
                          top: 5.h,
                          left: 0,
                          right: 0,
                          child: SizedBox(
                            height: 65.h,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              child: Container(
                                constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(allImages.length, (index) {
                                    return GestureDetector(
                                      onTap: () => setState(() => _selectedImageIndex = index),
                                      child: Container(
                                        width: 65.w,
                                        height: 65.h,
                                        margin: EdgeInsets.symmetric(horizontal: 6.w),
                                        decoration: BoxDecoration(
                                          color: AppColors.white,
                                          borderRadius: BorderRadius.circular(8.r),
                                          border: Border.all(
                                            color: _selectedImageIndex == index
                                                ? const Color(0xFFFFCC33)
                                                : Colors.transparent,
                                            width: 2,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8.r),
                                          child: CachedNetworkImage(
                                            imageUrl: ImageHelper.getFullImageUrl(allImages[index]),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Positioned(
                        //   top: 5.h,
                        //   left: 0,
                        //   right: 0,
                        //   child: SizedBox(
                        //     height: 65.h,
                        //     child: SingleChildScrollView(
                        //       scrollDirection: Axis.horizontal,
                        //       physics: const BouncingScrollPhysics(),
                        //       child: Container(
                        //         width: MediaQuery.of(context).size.width,
                        //         padding: EdgeInsets.symmetric(horizontal: 20.w),
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           mainAxisSize: MainAxisSize.min,
                        //           children: List.generate(allImages.length, (index) {
                        //             return GestureDetector(
                        //               onTap: () => setState(() => _selectedImageIndex = index),
                        //               child: Container(
                        //                 width: 65.w,
                        //                 height: 65.h,
                        //                 margin: EdgeInsets.symmetric(horizontal: 6.w),
                        //                 decoration: BoxDecoration(
                        //                   color: Colors.white,
                        //                   borderRadius: BorderRadius.circular(8.r),
                        //                   boxShadow: [
                        //                     BoxShadow(
                        //                       color: Colors.black.withOpacity(0.05),
                        //                       blurRadius: 10,
                        //                       offset: const Offset(0, 5),
                        //                     )
                        //                   ],
                        //                   border: Border.all(
                        //                     color: _selectedImageIndex == index
                        //                         ? const Color(0xFFFFCC33)
                        //                         : Colors.transparent,
                        //                     width: 2,
                        //                   ),
                        //                 ),
                        //                 child: ClipRRect(
                        //                   borderRadius: BorderRadius.circular(8.r),
                        //                   child: CachedNetworkImage(
                        //                     imageUrl: ImageHelper.getFullImageUrl(allImages[index]),
                        //                     fit: BoxFit.contain,
                        //                   ),
                        //                 ),
                        //               ),
                        //             );
                        //           }),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: _buildBottomAction(),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 8.h),
            height: 6.h, width: 6.h,
            decoration: const BoxDecoration(color: Colors.black87, shape: BoxShape.circle),
          ),
          SizedBox(width: 12.w),
          Expanded(child: Text(text, style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600))),
        ],
      ),
    );
  }

  Widget _buildBottomAction() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        //borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(color: const Color(0xFFF3F5F7), ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(Icons.shopping_cart_outlined, size: 26.sp),
                Positioned(
                  top: -5, right: -5,
                  child: CircleAvatar(radius: 8.r, backgroundColor: const Color(0xFFFFCC33), child: Text('3', style: TextStyle(fontSize: 10.sp, color: Colors.black))),
                )
              ],
            ),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFCC33),
                padding: EdgeInsets.symmetric(vertical: 15.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.r)),
                elevation: 0,
              ),
              child: Text('Add To Cart', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.black)),
            ),
          ),
        ],
      ),
    );
  }

  String _stripHtml(String html) => html.replaceAll(RegExp(r'<[^>]*>'), '').replaceAll('&nbsp;', ' ');
}

