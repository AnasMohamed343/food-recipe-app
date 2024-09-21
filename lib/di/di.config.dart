// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/api_manager/api_manager.dart' as _i3;
import '../data/datasource_contract/popular_recipe_datasource.dart' as _i4;
import '../data/datasource_impl/popular_recipe_ds_impl.dart' as _i5;
import '../data/repository_contract/popular_recipe_repository.dart' as _i6;
import '../data/repository_impl/popular_recipe_repo_impl.dart' as _i7;
import '../Features/home/presentation/view_models/popular_recipe_vm.dart'
    as _i8;

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
    gh.singleton<_i3.ApiManager>(() => _i3.ApiManager());
    gh.factory<_i4.PopularRecipeDatasource>(() =>
        _i5.PopularRecipeDatasourceImpl(apiManager: gh<_i3.ApiManager>()));
    gh.factory<_i6.PopularRecipeRepository>(() => _i7.PopularRecipeRepoImpl(
        popularRecipeDatasource: gh<_i4.PopularRecipeDatasource>()));
    gh.factory<_i8.PopularRecipeViewModel>(() => _i8.PopularRecipeViewModel(
        popularRecipeRepository: gh<_i6.PopularRecipeRepository>()));
    return this;
  }
}
