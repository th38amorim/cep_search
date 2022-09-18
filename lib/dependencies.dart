import 'package:cep_search/infrastructure/get_address_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<RepositoryProvider> buildRepositories() {
  return [
    RepositoryProvider<GetAddressRepository>(create: (context) => GetAddressRepository()),
  ];
}
