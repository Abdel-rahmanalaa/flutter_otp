import 'package:flutter_otp/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_otp/core/usecases/usecase.dart';
import 'package:flutter_otp/domain/repositories/lang_repository.dart';

class GetSavedLangUseCase implements UseCase<String, NoParams> {
  final LangRepository langRepository;

  GetSavedLangUseCase({required this.langRepository});

  @override
  Future<Either<Failure, String>> call(NoParams noParams) async =>
      await langRepository.getSavedLang();
}
