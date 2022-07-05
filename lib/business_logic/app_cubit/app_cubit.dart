
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context)=>BlocProvider.of(context);

bool saudiCountry = false;
bool kuwaitCountry = false;
  void seledctCountry({required bool saudi, required bool kuwait}){
    kuwaitCountry = kuwait;
    saudiCountry = saudi;
    emit(CountrySelection());

  }

bool arLanguage = false;
bool enLanguage = false;
  void seledctLanguage({required bool en, required bool ar}){
    arLanguage = ar;
    enLanguage = en;
    emit(LanguageSelection());

  }

}
