import 'package:get_it/get_it.dart';
import 'package:myproject/src/features/court/court_injections.dart';

final sl = GetIt.instance;

Future<void> initInjections() async {
  await initCourtInjections();
}
