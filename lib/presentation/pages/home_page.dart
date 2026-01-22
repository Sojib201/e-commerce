import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/image_helper.dart';
import '../../data/models/home_data_model.dart';
import '../bloc/home/home_bloc.dart';
import '../bloc/home/home_event.dart';
import '../bloc/home/home_state.dart';
import '../widgets/product_card_data.dart';
import 'product_list_page.dart';
import 'product_details_page.dart';
import 'category_products_page.dart';
import 'package:cached_network_image/cached_network_image.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
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
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 12.h),
              child: Container(
                height: 52.h,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  //borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.black12, width: 0.5),
                ),
                child: TextField(
                  controller: _searchController,
                  textInputAction: TextInputAction.search,
                  onChanged: (value) {
                    context.read<HomeBloc>().add(SearchProducts(value));
                  },
                  decoration: InputDecoration(
                    hintText: 'Search products',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
                    prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20.sp),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeLoading) {
                    return const Center(child: CircularProgressIndicator());
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

                  if (state is HomeSearchLoaded) {
                    return _buildSearchResults(state.searchResults);
                  }

                  if (state is HomeLoaded) {
                    final categories = state.homeData.homepageCategories ?? [];
                    final newArrivals = state.homeData.newArrivalProducts ?? [];

                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          Container(
                            height: 165.h,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Categories',
                                        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black87),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductListPage()));
                                        },
                                        child: Text(
                                          'See all',
                                          style: TextStyle(fontSize: 14.sp, color: Colors.grey, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 15.h),

                                SizedBox(
                                  height: 100.h,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    padding: EdgeInsets.only(left: 16.w),
                                    itemCount: categories.length,
                                    itemBuilder: (context, index) {
                                      final category = categories[index];
                                      return Padding(
                                        padding: EdgeInsets.only(right: 20.w),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CategoryProductsPage(
                                                      categoryId: category.id!,
                                                      categoryName: category.name!,
                                                    ),
                                              ),
                                            );
                                          },
                                          child: Column(
                                            children: [
                                              // Container(
                                              //   padding: EdgeInsets.all(12.w),
                                              //   decoration: const BoxDecoration(color: Color(0xFFFDF7E7), shape: BoxShape.circle),
                                              //   child: Image.network(ImageHelper.getFullImageUrl(category.image), height: 35.h, width: 35.w),
                                              // ),
                                              Container(
                                                padding: EdgeInsets.all(20.r),
                                                decoration: BoxDecoration(
                                                  color: AppColors.lightYellow,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: category.image != null
                                                    ? CachedNetworkImage(
                                                  imageUrl: ImageHelper.getFullImageUrl(category.image),
                                                  height: 40.h,
                                                  width: 40.w,
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
                                              SizedBox(height: 5.h),
                                              Text(category.name ?? '', style: TextStyle(fontSize: 12.sp, color: Colors.grey[700])),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'New Arrivals',
                                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.black87),
                                ),
                                Icon(Icons.tune, size: 22.sp, color: Colors.black54),
                              ],
                            ),
                          ),

                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15.w,
                              mainAxisSpacing: 15.h,
                              childAspectRatio: 0.72,
                            ),
                            itemCount: newArrivals.length,
                            itemBuilder: (context, index) {
                              final product = newArrivals[index];
                              return ProductCard(
                                name: product.name,
                                shortName: product.shortName,
                                thumbImage: product.thumbImage,
                                price: product.price,
                                offerPrice: product.offerPrice,
                                slug: product.slug!,
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsPage(slug: product.slug!)));
                                },
                              );
                            },
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
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

  Widget _buildSearchResults(List<NewArrivalProduct> products) {
    if (products.isEmpty) {
      return Center(child: Padding(
        padding: EdgeInsets.only(top: 50.h),
        child: Text("No products found!"),
      ));
    }
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15.w,
        mainAxisSpacing: 15.h,
        childAspectRatio: 0.72,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(
          name: product.name,
          shortName: product.shortName,
          thumbImage: product.thumbImage,
          price: product.price,
          offerPrice: product.offerPrice,
          slug: product.slug!,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => ProductDetailsPage(slug: product.slug!)
            ));
          },
        );
      },
    );
  }

}

