
import 'package:app_movie/core/usecase/usecase.dart';
import 'package:app_movie/domain/auth/repositories/auth.dart';
import 'package:app_movie/service_locator.dart';

class IsLoggedInUseCase extends UseCase<bool,dynamic> {
  
  @override
  Future<bool> call({params}) async {
    return await sl<AuthRepository>().isLoggedIn();
  }
  
}