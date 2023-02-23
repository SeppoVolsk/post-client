// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:chat_client/app/data/dio_app_api.dart' as _i8;
import 'package:chat_client/app/data/main_app_config.dart' as _i4;
import 'package:chat_client/app/domain/app_api.dart' as _i7;
import 'package:chat_client/app/domain/app_config.dart' as _i3;
import 'package:chat_client/feature/auth/data/mock_auth_repository.dart' as _i6;
import 'package:chat_client/feature/auth/data/network_auth_repository.dart'
    as _i9;
import 'package:chat_client/feature/auth/domain/auth_repository.dart' as _i5;
import 'package:chat_client/feature/auth/domain/auth_state/auth_cubit.dart'
    as _i12;
import 'package:chat_client/feature/posts/data/net_post_repo.dart' as _i11;
import 'package:chat_client/feature/posts/domain/post_repo.dart' as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

const String _prod = 'prod';
const String _dev = 'dev';
const String _test = 'test';

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.AppConfig>(
      _i4.ProdAppConfig(),
      registerFor: {_prod},
    );
    gh.singleton<_i3.AppConfig>(
      _i4.DevAppConfig(),
      registerFor: {_dev},
    );
    gh.singleton<_i3.AppConfig>(
      _i4.TestAppConfig(),
      registerFor: {_test},
    );
    gh.factory<_i5.AuthRepository>(
      () => _i6.MockAuthRepository(),
      registerFor: {_test},
    );
    gh.singleton<_i7.AppApi>(_i8.DioAppApi(gh<_i3.AppConfig>()));
    gh.factory<_i5.AuthRepository>(
      () => _i9.NetworkAuthRepository(gh<_i7.AppApi>()),
      registerFor: {_prod},
    );
    gh.factory<_i10.PostRepo>(() => _i11.NetPostRepo(gh<_i7.AppApi>()));
    gh.singleton<_i12.AuthCubit>(_i12.AuthCubit(gh<_i5.AuthRepository>()));
    return this;
  }
}
