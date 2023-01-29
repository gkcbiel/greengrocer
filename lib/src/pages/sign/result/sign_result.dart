import 'package:app_greengrocer/src/pages/cart/components/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_result.freezed.dart';

@freezed
class SignResult with _$SignResult{
    factory SignResult.success(UserModel user) = Success;
    factory SignResult.error(String message) = Error;


}