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
    super.key,
    required this.slug,
  });

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
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          }

          if (state is ProductDetailsError) {
            return Center(child: Text(state.message));
          }

          if (state is ProductDetailsLoaded) {
            final product = state.productDetails.product;
            final gallery = state.productDetails.gellery ?? [];
            final allImages = [
              product?.thumbImage ?? '',
              ...gallery.map((g) => g.image ?? '')
            ];

            debugPrint('all image list:${allImages.length}');

            final displayPrice = product?.offerPrice ?? product?.price ?? 0;
            final oldPrice = product?.price;
            final hasDiscount = product?.offerPrice != null && product?.offerPrice != product?.price;

            return SafeArea(
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
                            backgroundColor: const Color(0xFFFFC107).withOpacity(0.7),
                            child: Icon(Icons.arrow_back_ios_new, size: 16.sp, color: Colors.black),
                          ),
                        ),
                        Text(
                          'Popular Sells',
                          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: Colors.black87),
                        ),
                        Icon(Icons.favorite, color: Colors.red, size: 28.sp),
                      ],
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              color: AppColors.lightYellow,
                              height: 250.h,
                              // decoration: BoxDecoration(
                              //   color: AppColors.lightYellow
                              // ),
                              margin: EdgeInsets.symmetric(vertical: 10.h),
                              child: CachedNetworkImage(
                                imageUrl: ImageHelper.getFullImageUrl(allImages[_selectedImageIndex]),
                                fit: BoxFit.contain,
                                errorWidget: (context, url, error) => const Icon(Icons.image_not_supported),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 60.h,
                            child: Center(
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: allImages.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () => setState(() => _selectedImageIndex = index),
                                    child: Container(
                                      width: 60.w,
                                      margin: EdgeInsets.symmetric(horizontal: 5.w),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4.r),
                                        border: Border.all(
                                          color: _selectedImageIndex == index ? AppColors.primary : Colors.grey.shade200,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: ImageHelper.getFullImageUrl(allImages[index]),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),


                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.r),
                                topRight: Radius.circular(30.r),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '\$${displayPrice.toStringAsFixed(2)}',
                                      style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: Colors.red),
                                    ),
                                    if (hasDiscount) ...[
                                      SizedBox(width: 10.w),
                                      Text(
                                        '\$${oldPrice?.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.grey,
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  product?.category?.name?.toUpperCase() ?? "N/A",
                                  style: TextStyle(fontSize: 12.sp, color: Colors.grey, letterSpacing: 1.1),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  product?.name ?? '',
                                  style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.black87),
                                ),
                                SizedBox(height: 8.h),
                                Row(
                                  children: [
                                    ...List.generate(5, (index) => Icon(Icons.star, color: Colors.orange, size: 18.sp)),
                                    SizedBox(width: 8.w),
                                    Text(
                                      '${state.productDetails.totalReview ?? 0} Reviews',
                                      style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15.h),
                                Text(
                                  product?.shortDescription ?? 'N/A',
                                  style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  'Introduction',
                                  style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  _stripHtml(product?.longDescription ?? ''),
                                  style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600, height: 1.4),
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  'Features :',
                                  style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10.h),
                                _buildFeatureItem("slim body with metal cover"),
                                _buildFeatureItem("latest Intel Core i5-1135G7 processor"),
                                _buildFeatureItem("8GB DDR4 RAM and fast 512GB PCIe SSD"),
                                _buildFeatureItem("NVIDIA GeForce MX350 2GB GDDR5 graphics card backlit keyboard..."),

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
      bottomNavigationBar: _buildBottomAction(),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: CircleAvatar(radius: 3.r, backgroundColor: Colors.black87),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade700),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAction() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade100)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(Icons.shopping_cart_outlined, size: 28.sp),
                Positioned(
                  top: -5,
                  right: -5,
                  child: CircleAvatar(
                    radius: 8.r,
                    backgroundColor: Colors.orange,
                    child: Text('3', style: TextStyle(color: Colors.white, fontSize: 10.sp)),
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: SizedBox(
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFC107),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
                ),
                child: Text(
                  'Add To Cart',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _stripHtml(String html) {
    return html.replaceAll(RegExp(r'<[^>]*>'), '').replaceAll('&nbsp;', ' ');
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import '../../core/constants/app_colors.dart';
// import '../../core/utils/image_helper.dart';
// import '../bloc/product_details/product_details_bloc.dart';
// import '../bloc/product_details/product_details_event.dart';
// import '../bloc/product_details/product_details_state.dart';
//
// class ProductDetailsPage extends StatefulWidget {
//   final String slug;
//   const ProductDetailsPage({super.key, required this.slug});
//
//   @override
//   State<ProductDetailsPage> createState() => _ProductDetailsPageState();
// }
//
// class _ProductDetailsPageState extends State<ProductDetailsPage> {
//   int _selectedImageIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     context.read<ProductDetailsBloc>().add(LoadProductDetails(widget.slug));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
//         builder: (context, state) {
//           if (state is ProductDetailsLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (state is ProductDetailsLoaded) {
//             final product = state.productDetails.product;
//             final gallery = state.productDetails.gellery ?? [];
//             final allImages = [product?.thumbImage ?? '', ...gallery.map((g) => g.image ?? '')];
//
//             return SafeArea(
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         IconButton(
//                           onPressed: () => Navigator.pop(context),
//                           icon: CircleAvatar(
//                             backgroundColor: const Color(0xFFFFC107).withOpacity(0.7),
//                             radius: 18.r,
//                             child: Icon(Icons.arrow_back_ios_new, size: 16.sp, color: Colors.black),
//                           ),
//                         ),
//                         Text(
//                           'Popular Sells',
//                           style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
//                         ),
//                         const Icon(Icons.favorite, color: Colors.red),
//                       ],
//                     ),
//                   ),
//
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             height: 300.h,
//                             width: double.infinity,
//                             color: AppColors.lightYellow,
//                             alignment: Alignment.center,
//                             child: CachedNetworkImage(
//                               imageUrl: ImageHelper.getFullImageUrl(allImages[_selectedImageIndex]),
//                               fit: BoxFit.contain,
//                               width: 250.w,
//                             ),
//                           ),
//
//                           SizedBox(height: 15.h),
//                           SizedBox(
//                             height: 60.h,
//                             child: ListView.builder(
//                               scrollDirection: Axis.horizontal,
//                               padding: EdgeInsets.symmetric(horizontal: 16.w),
//                               itemCount: allImages.length,
//                               itemBuilder: (context, index) {
//                                 return GestureDetector(
//                                   onTap: () => setState(() => _selectedImageIndex = index),
//                                   child: Container(
//                                     width: 60.w,
//                                     margin: EdgeInsets.only(right: 12.w),
//                                     decoration: BoxDecoration(
//                                       border: Border.all(
//                                         color: index == _selectedImageIndex ? Colors.orange : Colors.grey.shade200,
//                                       ),
//                                       borderRadius: BorderRadius.circular(4.r),
//                                     ),
//                                     child: CachedNetworkImage(imageUrl: ImageHelper.getFullImageUrl(allImages[index])),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//
//                           Padding(
//                             padding: EdgeInsets.all(16.w),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     Text(
//                                       '\$${product?.offerPrice ?? product?.price}',
//                                       style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: Colors.red),
//                                     ),
//                                     SizedBox(width: 8.w),
//                                     if (product?.offerPrice != null)
//                                       Text(
//                                         '\$${product?.price}',
//                                         style: TextStyle(fontSize: 16.sp, color: Colors.grey, decoration: TextDecoration.lineThrough),
//                                       ),
//                                   ],
//                                 ),
//                                 SizedBox(height: 5.h),
//                                 Text(
//                                   product?.category?.name?.toUpperCase() ?? 'N/A',
//                                   style: TextStyle(fontSize: 12.sp, color: Colors.grey, letterSpacing: 1),
//                                 ),
//                                 SizedBox(height: 10.h),
//                                 Text(
//                                   product?.name ?? '',
//                                   style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500, height: 1.3),
//                                 ),
//
//                                 SizedBox(height: 8.h),
//                                 Row(
//                                   children: [
//                                     ...List.generate(5, (i) => Icon(Icons.star, color: Colors.orange, size: 16.sp)),
//                                     SizedBox(width: 8.w),
//                                     Text('6 Reviews', style: TextStyle(fontSize: 13.sp, color: Colors.grey)),
//                                   ],
//                                 ),
//
//                                 SizedBox(height: 15.h),
//                                 Text(product?.shortDescription ?? 'N/A', style: TextStyle(color: Colors.grey, height: 1.4)),
//
//                                 SizedBox(height: 20.h),
//                                 Text('Introduction', style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold)),
//                                 SizedBox(height: 10.h),
//                                 Text(
//                                   _stripHtml(product?.longDescription ?? ''),
//                                   style: TextStyle(color: Colors.grey, height: 1.5),
//                                 ),
//                                 SizedBox(height: 20.h),
//                                 Text('Features :', style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold)),
//                                 SizedBox(height: 100.h),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }
//           return const SizedBox();
//         },
//       ),
//
//       // --- ৫. বটম নেভিগেশন (ইমেজের মতো) ---
//       bottomNavigationBar: Container(
//         padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//         color: Colors.white,
//         child: Row(
//           children: [
//             // শপিং কার্ট আইকন বক্স
//             Container(
//               padding: EdgeInsets.all(10.w),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFF3F3F3),
//                 borderRadius: BorderRadius.circular(4.r),
//               ),
//               child: Badge(
//                 label: const Text('3'),
//                 backgroundColor: Colors.orange,
//                 child: Icon(Icons.shopping_cart_outlined, size: 28.sp),
//               ),
//             ),
//             SizedBox(width: 15.w),
//             // এড টু কার্ট বাটন
//             Expanded(
//               child: SizedBox(
//                 height: 50.h,
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFFFFBC42), // ইমেজের সেই হলুদ রঙ
//                     foregroundColor: Colors.black,
//                     elevation: 0,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
//                   ),
//                   child: Text('Add To Cart', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   String _stripHtml(String html) {
//     return html.replaceAll(RegExp(r'<[^>]*>'), '').replaceAll('&nbsp;', ' ');
//   }
// }
//
