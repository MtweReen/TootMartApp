import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'home_cubit_state.dart';

class HomeCubitCubit extends Cubit<HomeCubitState> {
  HomeCubitCubit() : super(HomeCubitInitial());

  static HomeCubitCubit get(context)=> BlocProvider.of(context);
}
