import 'package:dartz/dartz.dart';
import 'package:dev_gallery/core/handlers/error-handler/error_handler.dart';
import 'package:dev_gallery/core/network/network_info.dart';
import 'package:dev_gallery/features/developers/data/models/developer_model.dart';
import 'package:dev_gallery/features/developers/domain/entities/developer_entity.dart';
import 'package:dev_gallery/features/developers/domain/repositories/developer_repo.dart';
import '../datasources/developer_local_data_source.dart';
import '../datasources/developer_remote_data_source.dart';

class DeveloperRepoImpl implements DeveloperRepo {
  final DeveloperRemoteDataSource _remoteDataSource;
  final DeveloperLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  DeveloperRepoImpl({
    required remoteDataSource,
    required localDataSource,
    required networkInfo,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource,
       _networkInfo = networkInfo;

  @override
  Future<Either<String, List<DeveloperEntity>>> getDevelopersList({
    int? since,
    int perPage = 15,
  }) async {
    final isConnected = await _networkInfo.isConnected;
    if (isConnected) {
      try {
        final remoteModels = await _remoteDataSource.getDevelopersList(
          since: since,
          perPage: perPage,
        );

        // Cache the result locally
        await _localDataSource.cacheDevelopers(remoteModels);

        final entities = remoteModels.map((m) => m.toEntity()).toList();
        return Right(entities);
      } catch (e, stackTrace) {
        final message = handleError(e, stackTrace);
        return Left(message);
      }
    } else {
      try {
        final cachedModels = await _localDataSource.getCachedDevelopers();
        if (cachedModels.isNotEmpty) {
          final entities = cachedModels.map((m) => m.toEntity()).toList();
          return Right(entities);
        } else {
          return Left(
            'No cached data available. Please connect to the internet.',
          );
        }
      } catch (e, stackTrace) {
        final message = handleError(e, stackTrace);
        return Left(message);
      }
    }
  }

  @override
  Future<Either<String, DeveloperEntity>> getDeveloperDetails(
    String username,
  ) async {
    try {
      final model = await _remoteDataSource.getDeveloperDetails(username);

      await _localDataSource.cacheDeveloperDetail(model);

      return Right(model.toEntity());
    } catch (e, stackTrace) {
      final message = handleError(e, stackTrace);
      return Left(message);
    }
  }

  @override
  Future<Either<String, Unit>> toggleFavorite(DeveloperEntity developer) async {
    try {
      await _localDataSource.toggleFavorite(
        DeveloperModel.fromEntity(developer),
      );
      return Right(unit);
    } catch (e, stackTrace) {
      final message = handleError(e, stackTrace);
      return Left(message);
    }
  }
}
