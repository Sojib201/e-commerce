import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/home_data_model.dart';
import '../../../domain/usecases/get_home_data.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeData getHomeData;
  HomeDataModel? _fullHomeData;

  HomeBloc({required this.getHomeData}) : super(HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<SearchProducts>(_onSearchProducts);
  }

  // Future<void> _onLoadHomeData(LoadHomeData event, Emitter<HomeState> emit,) async {
  //   emit(HomeLoading());
  //   final result = await getHomeData();
  //   if (result.failure != null) {
  //     emit(HomeError(result.failure!.message));
  //   } else if (result.data != null) {
  //     emit(HomeLoaded(result.data!));
  //   }
  // }

  Future<void> _onLoadHomeData(LoadHomeData event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    final result = await getHomeData();
    if (result.data != null) {
      _fullHomeData = result.data;
      emit(HomeLoaded(result.data!));
    } else {
      emit(HomeError(result.failure?.message ?? "Error"));
    }
  }

  void _onSearchProducts(SearchProducts event, Emitter<HomeState> emit) {
    if (_fullHomeData == null) return;

    if (event.query.isEmpty) {
      emit(HomeLoaded(_fullHomeData!));
    } else {
      final filteredList = _fullHomeData!.newArrivalProducts?.where((product) {
        final name = product.name?.toLowerCase() ?? "";
        final query = event.query.toLowerCase();
        return name.contains(query);
      }).toList();

      emit(HomeSearchLoaded(filteredList ?? []));
    }
  }

}