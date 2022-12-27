import 'package:app_greengrocer/src/constants/endpoints.dart';
import 'package:app_greengrocer/src/services/http_manager.dart';

class AuthRepository {
  final HttpManger _httpManger = HttpManger();

  Future signIn({
    required String email,
    required String password,
  }) async {
    final result = await _httpManger.restRequest(
      url: Endpoints.signin,
      method: HttpMethods.post,
      body: {
        "email": email,
        "password": password,
      }
    );

    if(result['result'] != null){
        print('Sign funcionou');
    }else {
        print('Sign não funcionou');
    }
  }
}
