import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'core/constants/app_colors.dart';
import 'data/datasource/product_remote_data_source.dart';
import 'data/repositories/product_repository_impl.dart';
import 'domain/usecases/get_home_data.dart';
import 'domain/usecases/get_products.dart';
import 'domain/usecases/get_product_details.dart';
import 'domain/usecases/get_products_by_category.dart';
import 'presentation/bloc/home/home_bloc.dart';
import 'presentation/bloc/product/product_bloc.dart';
import 'presentation/bloc/product_details/product_details_bloc.dart';
import 'presentation/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize dependencies
    final httpClient = http.Client();
    final remoteDataSource = ProductRemoteDataSourceImpl(client: httpClient);
    final repository = ProductRepositoryImpl(remoteDataSource: remoteDataSource);

    final getHomeData = GetHomeData(repository);
    final getProducts = GetProducts(repository);
    final getProductDetails = GetProductDetails(repository);
    final getProductsByCategory = GetProductsByCategory(repository);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => HomeBloc(getHomeData: getHomeData),
            ),
            BlocProvider(
              create: (context) => ProductBloc(
                getProducts: getProducts,
                getProductsByCategory: getProductsByCategory,
              ),
            ),
            BlocProvider(
              create: (context) => ProductDetailsBloc(
                getProductDetails: getProductDetails,
              ),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'E-commerce App',
            theme: ThemeData(
              primaryColor: AppColors.primary,
              scaffoldBackgroundColor: AppColors.background,
              fontFamily: 'Inter',
            ),
            home: child,
          ),
        );
      },
      child: const HomePage(),
    );
  }
}