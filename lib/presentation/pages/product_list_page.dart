import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_colors.dart';
import '../../data/models/product_list_data_model.dart';
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
  final TextEditingController _searchController = TextEditingController();
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
    _searchController.dispose();
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
      //backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CircleAvatar(
            radius: 18.r,
            backgroundColor: const Color(0xFFFFCC33),
            child: Icon(Icons.arrow_back_ios_new, size: 14.sp, color: Colors.black),
          ),
        ),
        title: Text(
          'ALL Product',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
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
                  context.read<ProductBloc>().add(SearchProducts(value));
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

          SizedBox(height: 10.h),

          Expanded(
            child: BlocBuilder<ProductBloc, ProductState>(
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

                if (state is ProductSearchLoaded) {
                  return _buildProductGrid(state.searchResults, true);
                }
                else if (state is ProductLoaded || state is ProductLoadingMore)
                {
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

                  return GridView.builder(
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
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid(List<ProductData> products, bool isSearch) {
    if (products.isEmpty && isSearch) {
      return const Center(child: Text("No products found!"));
    }

    return GridView.builder(
      controller: isSearch ? null : _scrollController,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 0.7,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ProductCard(
          name: product.name,
          shortName: product.shortName,
          thumbImage: product.thumbImage,
          price: product.price?.toDouble(),
          offerPrice: product.offerPrice?.toDouble(),
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
