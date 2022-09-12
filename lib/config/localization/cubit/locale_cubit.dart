import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utiles/app_strings.dart';
import '../data/locale_repository.dart';
part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit({required this.localeRepository})
      : super(const LocaleInitial(locale: Locale(AppStrings.englishCode)));


  final LocaleRepository localeRepository;

  String currentCode = AppStrings.englishCode;

  Future<void> saveLocale({required String codeLange}) async {
    final response = await localeRepository.saveLocale(codeLang: codeLange);
    response.fold((failure) => debugPrint(AppStrings.cacheFailure), (value) {
      currentCode = codeLange;
      emit(LocaleInitial(locale: _locale(currentCode)));
    });
  }

  Future<void> getSavedLocale() async {
    final getSaved = await localeRepository.getSaveLocale();
    getSaved.fold((failure) => debugPrint(AppStrings.cacheFailure), (value) {
      currentCode = value;
      emit(LocaleInitial(locale: _locale(currentCode)));
    });
  }

  Locale _locale(String codeLang) {
    switch (codeLang) {
      case AppStrings.englishCode:
        return const Locale(AppStrings.englishCode);

      case AppStrings.arabicCode:
        return const Locale(AppStrings.arabicCode);

      default:
        return const Locale(AppStrings.englishCode);
    }
  }
}
