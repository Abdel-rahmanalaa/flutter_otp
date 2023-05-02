import 'package:flutter_otp/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_otp/core/usecases/usecase.dart';
import 'package:flutter_otp/domain/repositories/lang_repository.dart';

class ChangeLangUseCase implements UseCase<bool, String> {
  final LangRepository langRepository;

  ChangeLangUseCase({required this.langRepository});

  @override
  Future<Either<Failure, bool>> call(String langCode) async =>
      await langRepository.changeLang(langCode: langCode);
}
