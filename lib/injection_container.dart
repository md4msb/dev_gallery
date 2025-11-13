import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'core/network/dio_client.dart';
import 'core/network/network_info.dart';
import 'features/developers/data/datasources/developer_remote_data_source.dart';
import 'features/developers/data/datasources/developer_local_data_source.dart';
import 'features/developers/data/repository_impl/developer_repo_impl.dart';
import 'features/developers/domain/repositories/developer_repo.dart';
import 'features/developers/domain/usecases/get_developers_list.dart';
import 'features/developers/domain/usecases/get_developer_details.dart';
import 'features/developers/domain/usecases/toggle_favorite.dart';
import 'features/developers/presentation/bloc/developers_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Dio Client
  sl.registerLazySingleton(() => DioClient());
  sl.registerLazySingleton<Dio>(() => sl<DioClient>().dio);

  // Network Info
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(Connectivity()));

  //? Features - Developers
  // Data Sources
  sl.registerLazySingleton<DeveloperRemoteDataSource>(
    () => DeveloperRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<DeveloperLocalDataSource>(
    () => DeveloperLocalDataSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<DeveloperRepo>(
    () => DeveloperRepoImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetDevelopersList(sl()));
  sl.registerLazySingleton(() => GetDeveloperDetails(sl()));
  sl.registerLazySingleton(() => ToggleFavorite(sl()));

  //Bloc
  sl.registerFactory(() => DevelopersBloc(getDevelopersList: sl()));
}
