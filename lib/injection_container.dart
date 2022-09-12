import 'features/chat/presentation/cubit/chat_cubit.dart';

import 'injection_exports.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  /// FEATURES
  // BLOC
  sl.registerFactory(() => ThemeCubit(sharedPreferences: sl()));
  sl.registerFactory(() => LocaleCubit(localeRepository: sl()));
  sl.registerFactory(() => ChatCubit(chatRepository: sl())..getMessage());
  sl.registerFactory(() => LayoutCubit());
  sl.registerFactory(() => AuthCubit(authRepository: sl()));
  sl.registerFactory(() => UserCubit(userRepository: sl())
    ..getUser()
    ..getAllUsers());
  sl.registerFactory(() => PostCubit(newPostRepository: sl())
    ..getNewPost()
  );

  // REPOSITORY
  sl.registerLazySingleton<LocaleRepository>(
      () => LocaleRepositoryImpl(networkInfo: sl(), localeDataSource: sl()));
  sl.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(networkInfo: sl(), userRemoteDataSource: sl()));
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(networkInfo: sl(), authRemoteDataSource: sl()));
  sl.registerLazySingleton<PostRepository>(
      () => PostRepositoryImpl(networkInfo: sl(), postRemoteDataSource: sl()));
  sl.registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImpl(networkInfo: sl(), chatRemoteDataSource: sl()));
  // DATA SOURCE
// LOCAL DATA SOURCE
  sl.registerLazySingleton<LocaleDataSource>(
      () => LocaleDataSourceImpl(sharedPreferences: sl()));

// REMOTE DATA SOURCE
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl());
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl());
  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl());
  sl.registerLazySingleton<ChatRemoteDataSource>(
      () => ChatRemoteDataSourceImpl());

  /// CORE
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker: sl()));

  /// EXTERNAL
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
