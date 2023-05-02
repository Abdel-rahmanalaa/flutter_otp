import 'package:flutter_otp/data/data_source/lang_local_data_source.dart';
import 'package:flutter_otp/data/repository/lang_repository_impl.dart';
import 'package:flutter_otp/domain/repositories/lang_repository.dart';
import 'package:flutter_otp/domain/usecases/change_lang.dart';
import 'package:flutter_otp/domain/usecases/get_saved_lang.dart';
import 'package:flutter_otp/presentation/controller/locale/cubit/locale_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

void initGetIt() async {
  //Blocs
  getIt.registerFactory<LocaleCubit>(() =>
      LocaleCubit(getSavedLangUseCase: getIt(), changeLangUseCase: getIt()));

  //Use Cases
  getIt.registerLazySingleton<GetSavedLangUseCase>(
      () => GetSavedLangUseCase(langRepository: getIt()));
  getIt.registerLazySingleton<ChangeLangUseCase>(
      () => ChangeLangUseCase(langRepository: getIt()));

  // Repositories
  getIt.registerLazySingleton<LangRepository>(
      () => LangReapositoryImpl(langLocalDataSource: getIt()));

  //Data Sources
  getIt.registerLazySingleton<LangLocalDataSource>(
      () => LangLocalDataSourceImpl(sharedPreferences: getIt()));

  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
}
