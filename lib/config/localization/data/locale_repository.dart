import 'package:dartz/dartz.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../../core/network/network_info.dart';
import 'locale_data_source.dart';
import '../../../../core/error/failures.dart';

abstract class LocaleRepository {
  Future<Either<Failure, bool>> saveLocale({required String codeLang});

  Future<Either<Failure, String>> getSaveLocale();
}

class LocaleRepositoryImpl implements LocaleRepository {
  final LocaleDataSource localeDataSource;
  final NetworkInfo networkInfo;

  LocaleRepositoryImpl(
      {required this.networkInfo, required this.localeDataSource});

  @override
  Future<Either<Failure, String>> getSaveLocale() async {
    if (await networkInfo.isConnected) {
      try {
        final getSavedLocal = await localeDataSource.getSaveLocale();
        return Right(getSavedLocal);
      } on CacheException {
        return Left(CacheFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> saveLocale({required String codeLang}) async {
    if (await networkInfo.isConnected) {
      try {
        final saveLocal =
            await localeDataSource.saveLocale(codeLang: codeLang);
        return Right(saveLocal);
      } on CacheException {
        return Left(CacheFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
