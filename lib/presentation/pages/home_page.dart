import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';
import '../bloc/home/home_bloc.dart';
import '../bloc/home/home_event.dart';
import '../bloc/home/home_state.dart';
import '../widgets/category_item.dart';
import '../widgets/product_card_data.dart';
import 'product_list_page.dart';
import 'product_details_page.dart';
import 'category_products_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadHomeData());
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              );
            }

            if (state is HomeError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error: ${state.message}',
                      style: TextStyle(fontSize: 16.sp),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () {
                        context.read<HomeBloc>().add(LoadHomeData());
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

            if (state is HomeLoaded) {
              final categories = state.homeData.homepageCategories ?? [];
              final newArrivals = state.homeData.newArrivalProducts ?? [];

              debugPrint('new arrival list:${newArrivals.length}');

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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

                    // Categories Section
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Categories',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'See all',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 12.h),

                    SizedBox(
                      height: 110.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        itemCount: categories.length > 4 ? 4 : categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return Padding(
                            padding: EdgeInsets.only(right: 16.w),
                            child: CategoryItem(
                              name: category.name,
                              image: category.image,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CategoryProductsPage(
                                      categoryId: category.id!,
                                      categoryName: category.name!,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // New Arrivals Section
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'New Arrivals',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ProductListPage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'See all',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.tune,
                                size: 20.sp,
                                color: AppColors.textPrimary,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16.h),

                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 12.h,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: newArrivals.length > 6 ? 6 : newArrivals.length,
                      itemBuilder: (context, index) {
                        final product = newArrivals[index];
                        return ProductCard(
                          name: product.name,
                          shortName: product.shortName,
                          thumbImage: product.thumbImage,
                          price: product.price,
                          offerPrice: product.offerPrice,
                          averageRating: product.averageRating,
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

                    SizedBox(height: 100.h),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        selectedFontSize: 12.sp,
        unselectedFontSize: 12.sp,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 24.sp),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message, size: 24.sp),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag, size: 24.sp),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 24.sp),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../core/constants/app_colors.dart';
// import '../bloc/home/home_bloc.dart';
// import '../bloc/home/home_event.dart';
// import '../bloc/home/home_state.dart';
// import '../widgets/category_item.dart';
// import '../widgets/product_card_data.dart';
// import 'product_details_page.dart';
// import 'category_products_page.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   int _selectedIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     context.read<HomeBloc>().add(LoadHomeData());
//   }
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       body: SafeArea(
//         child: BlocBuilder<HomeBloc, HomeState>(
//           builder: (context, state) {
//             if (state is HomeLoading) {
//               return const Center(
//                 child: CircularProgressIndicator(
//                   valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
//                 ),
//               );
//             }
//
//             if (state is HomeError) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Error: ${state.message}',
//                       style: TextStyle(fontSize: 16.sp),
//                     ),
//                     SizedBox(height: 16.h),
//                     ElevatedButton(
//                       onPressed: () {
//                         context.read<HomeBloc>().add(LoadHomeData());
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.primary,
//                       ),
//                       child: const Text('Retry'),
//                     ),
//                   ],
//                 ),
//               );
//             }
//
//             if (state is HomeLoaded) {
//               final categories = state.homeData.homepageCategories ?? [];
//               final newArrivals = state.homeData.newArrivalProducts ?? [];
//
//               return SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Search Bar
//                     Padding(
//                       padding: EdgeInsets.all(16.w),
//                       child: Container(
//                         height: 48.h,
//                         decoration: BoxDecoration(
//                           color: AppColors.white,
//                           borderRadius: BorderRadius.circular(24.r),
//                         ),
//                         child: Row(
//                           children: [
//                             SizedBox(width: 16.w),
//                             Icon(
//                               Icons.search,
//                               color: AppColors.textSecondary,
//                               size: 20.sp,
//                             ),
//                             SizedBox(width: 12.w),
//                             Expanded(
//                               child: TextField(
//                                 decoration: InputDecoration(
//                                   hintText: 'Search products',
//                                   hintStyle: TextStyle(
//                                     color: AppColors.textSecondary,
//                                     fontSize: 14.sp,
//                                   ),
//                                   border: InputBorder.none,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//
//                     // Categories Section
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 16.w),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Categories',
//                             style: TextStyle(
//                               fontSize: 18.sp,
//                               fontWeight: FontWeight.bold,
//                               color: AppColors.textPrimary,
//                             ),
//                           ),
//                           TextButton(
//                             onPressed: () {},
//                             child: Text(
//                               'See all',
//                               style: TextStyle(
//                                 fontSize: 14.sp,
//                                 color: AppColors.primary,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     SizedBox(height: 12.h),
//
//                     SizedBox(
//                       height: 110.h,
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         padding: EdgeInsets.symmetric(horizontal: 16.w),
//                         itemCount: categories.length > 4 ? 4 : categories.length,
//                         itemBuilder: (context, index) {
//                           final category = categories[index];
//                           return Padding(
//                             padding: EdgeInsets.only(right: 16.w),
//                             child: CategoryItem(
//                               name: category.name,
//                               image: category.image,
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => CategoryProductsPage(
//                                       categoryId: category.id!,
//                                       categoryName: category.name!,
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//
//                     SizedBox(height: 24.h),
//
//                     // New Arrivals Section
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 16.w),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'New Arrivals',
//                             style: TextStyle(
//                               fontSize: 18.sp,
//                               fontWeight: FontWeight.bold,
//                               color: AppColors.textPrimary,
//                             ),
//                           ),
//                           Icon(
//                             Icons.tune,
//                             size: 20.sp,
//                             color: AppColors.textPrimary,
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     SizedBox(height: 16.h),
//
//                     GridView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       padding: EdgeInsets.symmetric(horizontal: 16.w),
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 12.w,
//                         mainAxisSpacing: 12.h,
//                         childAspectRatio: 0.7,
//                       ),
//                       itemCount: newArrivals.length,
//                       itemBuilder: (context, index) {
//                         final product = newArrivals[index];
//                         return ProductCard(
//                           name: product.name,
//                           shortName: product.shortName,
//                           thumbImage: product.thumbImage,
//                           price: product.price,
//                           offerPrice: product.offerPrice,
//                           averageRating: product.averageRating,
//                           slug: product.slug!,
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => ProductDetailsPage(
//                                   slug: product.slug!,
//                                 ),
//                               ),
//                             );
//                           },
//                         );
//                       },
//                     ),
//
//                     SizedBox(height: 100.h),
//                   ],
//                 ),
//               );
//             }
//
//             return const SizedBox();
//           },
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: AppColors.primary,
//         unselectedItemColor: AppColors.textSecondary,
//         selectedFontSize: 12.sp,
//         unselectedFontSize: 12.sp,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home, size: 24.sp),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.message, size: 24.sp),
//             label: 'Message',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.shopping_bag, size: 24.sp),
//             label: 'Order',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person, size: 24.sp),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }
// }