import 'package:chat_client/feature/auth/domain/auth_repository.dart';
import 'package:chat_client/feature/auth/domain/entities/user_entity/user_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
@test
class MockAuthRepository implements AuthRepository {
  @override
  Future getProfile() {
    // TODO: implement getProfile
    throw UnimplementedError();
  }

  @override
  Future passwordUpdate(
      {required String oldPassword, required String newPassword}) {
    // TODO: implement passwordUpdate
    throw UnimplementedError();
  }

  @override
  Future refreshToken({String? refreshToken}) {
    // TODO: implement refreshToken
    throw UnimplementedError();
  }

  @override
  Future signIn({required String password, required String username}) {
    return Future.delayed(const Duration(seconds: 2), () {
      return UserEntity(
        username: username,
        email: "testEmail",
        id: "-1",
      );
    });
  }

  @override
  Future signUp({
    required String password,
    required String username,
    required String email,
  }) {
    return Future.delayed(const Duration(seconds: 2), () {
      return UserEntity(
        username: username,
        email: email,
        id: "-1",
      );
    });
  }

  @override
  Future userUpdate({String? username, String? email}) {
    // TODO: implement userUpdate
    throw UnimplementedError();
  }
}
