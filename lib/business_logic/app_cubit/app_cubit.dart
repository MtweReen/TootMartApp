import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html/parser.dart';
import 'package:meta/meta.dart';

import '../../core/constants/constants.dart';
import '../../core/network/end_points.dart';
import '../../data/model/intro_model.dart';
import 'package:http/http.dart' as http;

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(context) => BlocProvider.of(context);

  bool saudiCountry = false;
  bool kuwaitCountry = false;

  void seledctCountry({required bool saudi, required bool kuwait}) {
    kuwaitCountry = kuwait;
    saudiCountry = saudi;
    emit(CountrySelection());
  }

  bool arLanguage = false;
  bool enLanguage = false;

  void seledctLanguage({required bool en, required bool ar}) {
    arLanguage = ar;
    enLanguage = en;
    emit(LanguageSelection());
  }

  IntroModel? introModel;

  Future<IntroModel>? getIntro() async {
    emit(IntroLoadingState());
    try {
      Map<String, String> headers = {
        "Accept-Language": prefs.getString("lang") ?? "en",
      };
      var response =
          await http.get(Uri.parse(kBaseUrl + INTRO), headers: headers);
      var data = jsonDecode(response.body);
      if (data['status'] == true) {
        introModel = IntroModel.fromJson(data);
        print(response.body);
        emit(IntroSuccessState());
        return introModel!;
      }
    } catch (e) {
      print(e.toString());
      emit(IntroErrorState(e.toString()));
    }
    return introModel!;
  }
}
String parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body!.text).documentElement!.text;
  return parsedString;
}