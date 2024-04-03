import 'package:myproject/src/core/utils/injections.dart';
import 'package:myproject/src/features/court/data/repositories/court_repository_impl.dart';
import 'package:myproject/src/features/court/domain/repositories/court_repository.dart';
import 'package:myproject/src/features/court/domain/usecases/court_usecase.dart';

initCourtInjections() {
  sl.registerSingleton<CourtRepository>(CourtRepositoryImpl());
  sl.registerSingleton<CourtUseCase>(CourtUseCase(sl()));
}
