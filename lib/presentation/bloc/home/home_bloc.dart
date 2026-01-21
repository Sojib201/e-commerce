import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_home_data.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeData getHomeData;

  HomeBloc({required this.getHomeData}) : super(HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
  }

  Future<void> _onLoadHomeData(
      LoadHomeData event,
      Emitter<HomeState> emit,
      ) async {
    emit(HomeLoading());

    final result = await getHomeData();

    if (result.failure != null) {
      emit(HomeError(result.failure!.message));
    } else if (result.data != null) {
      emit(HomeLoaded(result.data!));
    }
  }
}