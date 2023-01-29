import 'package:app_greengrocer/src/constants/endpoints.dart';
import 'package:app_greengrocer/src/pages/cart/components/user_model.dart';
import 'package:app_greengrocer/src/pages/sign/repository/sign_errors.dart'
    as error;
import 'package:app_greengrocer/src/pages/sign/result/sign_result.dart';
import 'package:app_greengrocer/src/services/http_manager.dart';

class AuthRepository {
  final HttpManger _httpManger = HttpManger();

  Future<SignResult> signIn({
    required String email,
    required String password,
  }) async {
    final result = await _httpManger
        .restRequest(url: Endpoints.signin, method: HttpMethods.post, body: {
      "email": email,
      "password": password,
    });

    if (result['result'] != null) {
      final user = UserModel.fromJson(result['result']);

      return SignResult.success(user);
    } else {
      return SignResult.error(error.signErrorsString(result['error']));
    }
  }
}
