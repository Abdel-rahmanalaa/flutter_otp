import 'package:flutter_otp/core/error/expcetions.dart';
import 'package:flutter_otp/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_otp/data/data_source/lang_local_data_source.dart';
import 'package:flutter_otp/domain/repositories/lang_repository.dart';

class LangReapositoryImpl implements LangRepository {
  LangLocalDataSource langLocalDataSource;
  LangReapositoryImpl({required this.langLocalDataSource});

  @override
  Future<Either<Failure, bool>> changeLang({required String langCode}) async {
    try {
      final langIsChanged =
          await langLocalDataSource.changeLang(langCode: langCode);
      return Right(langIsChanged);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getSavedLang() async {
    try {
      final langCode = await langLocalDataSource.getSavedLang();
      return Right(langCode);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
