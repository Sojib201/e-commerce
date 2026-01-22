import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';
import '../bloc/product/product_bloc.dart';
import '../bloc/product/product_event.dart';
import '../bloc/product/product_state.dart';
import '../widgets/product_card_data.dart';
import 'product_details_page.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(const LoadProducts());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ProductBloc>().add(LoadMoreProducts());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Container(
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
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'ALL Product',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
            );
          }

          if (state is ProductError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    style: TextStyle(fontSize: 16.sp),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ProductBloc>().add(const LoadProducts());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is ProductLoaded || state is ProductLoadingMore) {
            final products = state is ProductLoaded
                ? state.allProducts
                : (state as ProductLoadingMore).currentProducts;

            final hasReachedMax = state is ProductLoaded
                ? state.hasReachedMax
                : false;

            final currentPage = state is ProductLoaded
                ? state.currentPage
                : 1;

            final totalPages = state is ProductLoaded
                ? (state.productData.products?.lastPage ?? 1)
                : 1;

            return Column(
              children: [
                // Search Bar
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Container(
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 16.w),
                        Icon(
                          Icons.search,
                          color: AppColors.textSecondary,
                          size: 20.sp,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search products',
                              hintStyle: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 14.sp,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Page Info
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Showing ${products.length} products',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        'Page $currentPage of $totalPages',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 12.h),

                Expanded(
                  child: GridView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: hasReachedMax
                        ? products.length
                        : products.length + 1,
                    itemBuilder: (context, index) {
                      if (index >= products.length) {
                        // Loading indicator at the bottom
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.w),
                            child: const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.primary,
                              ),
                            ),
                          ),
                        );
                      }

                      final product = products[index];
                      return ProductCard(
                        name: product.name,
                        shortName: product.shortName,
                        thumbImage: product.thumbImage,
                        price: product.price?.toDouble(),
                        offerPrice: product.offerPrice?.toDouble(),
                        //averageRating: product.averageRating,
                        slug: product.slug!,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsPage(
                                slug: product.slug!,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../core/constants/app_colors.dart';
// import '../bloc/product/product_bloc.dart';
// import '../bloc/product/product_event.dart';
// import '../bloc/product/product_state.dart';
// import '../widgets/product_card_data.dart';
// import 'product_details_page.dart';
//
// class ProductListPage extends StatefulWidget {
//   const ProductListPage({Key? key}) : super(key: key);
//
//   @override
//   State<ProductListPage> createState() => _ProductListPageState();
// }
//
// class _ProductListPageState extends State<ProductListPage> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<ProductBloc>().add(const LoadProducts());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: AppBar(
//         backgroundColor: AppColors.background,
//         elevation: 0,
//         leading: IconButton(
//           icon: Container(
//             width: 40.w,
//             height: 40.h,
//             decoration: const BoxDecoration(
//               color: AppColors.primary,
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               Icons.arrow_back,
//               color: AppColors.white,
//               size: 20.sp,
//             ),
//           ),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'ALL Product',
//           style: TextStyle(
//             color: AppColors.textPrimary,
//             fontSize: 18.sp,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: false,
//       ),
//       body: BlocBuilder<ProductBloc, ProductState>(
//         builder: (context, state) {
//           if (state is ProductLoading) {
//             return const Center(
//               child: CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
//               ),
//             );
//           }
//
//           if (state is ProductError) {
//             return Center(
//               child: Text(state.message),
//             );
//           }
//
//           if (state is ProductLoaded) {
//             final products = state.productData.products?.data ?? [];
//
//             return Column(
//               children: [
//                 // Search Bar
//                 Padding(
//                   padding: EdgeInsets.all(16.w),
//                   child: Container(
//                     height: 48.h,
//                     decoration: BoxDecoration(
//                       color: AppColors.white,
//                       borderRadius: BorderRadius.circular(24.r),
//                     ),
//                     child: Row(
//                       children: [
//                         SizedBox(width: 16.w),
//                         Icon(
//                           Icons.search,
//                           color: AppColors.textSecondary,
//                           size: 20.sp,
//                         ),
//                         SizedBox(width: 12.w),
//                         Expanded(
//                           child: TextField(
//                             decoration: InputDecoration(
//                               hintText: 'Search products',
//                               hintStyle: TextStyle(
//                                 color: AppColors.textSecondary,
//                                 fontSize: 14.sp,
//                               ),
//                               border: InputBorder.none,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 Expanded(
//                   child: GridView.builder(
//                     padding: EdgeInsets.symmetric(horizontal: 16.w),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 12.w,
//                       mainAxisSpacing: 12.h,
//                       childAspectRatio: 0.7,
//                     ),
//                     itemCount: products.length,
//                     itemBuilder: (context, index) {
//                       final product = products[index];
//                       return ProductCard(
//                         name: product.name,
//                         shortName: product.shortName,
//                         thumbImage: product.thumbImage,
//                         price: product.price?.toDouble(),
//                         offerPrice: product.offerPrice?.toDouble(),
//                         averageRating: product.averageRating,
//                         slug: product.slug!,
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => ProductDetailsPage(
//                                 slug: product.slug!,
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             );
//           }
//
//           return const SizedBox();
//         },
//       ),
//     );
//   }
// }