// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:cep_search/infrastructure/get_address_repository.dart';
import 'package:geocoding/geocoding.dart';

class FindAddressState {
  FindAddressState({this.isLoading = false, this.latitude, this.longitude, this.message});

  final bool? isLoading;
  final double? latitude;
  final double? longitude;
  final String? message;

  FindAddressState copyWith({
    bool? isLoading,
    double? latitude,
    double? longitude,
    String? message,
  }) {
    return FindAddressState(
      isLoading: isLoading ?? this.isLoading,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      message: message ?? this.message,
    );
  }
}

class FindAddressCubit extends Cubit<FindAddressState> {
  FindAddressCubit(this.getAddressRepository) : super(FindAddressState());

  final GetAddressRepository getAddressRepository;

  Future<void> getAddressByCEP({String? cep}) async {
    emit(state.copyWith(isLoading: true));
    Map<String, dynamic> loadAddressByCEP = await getAddressRepository.getAddressByCEP(cep!);
    if (loadAddressByCEP['logradouro'] != null) {
      getCoordinates(street: loadAddressByCEP['logradouro']);
    } else {
      emit(state.copyWith(message: 'CEP não encontrado', isLoading: false));
    }
  }

  Future<void> getCoordinates({String? street}) async {
    List<Location> locations = await locationFromAddress(street!);
    emit(state.copyWith(latitude: locations[0].latitude, longitude: locations[0].longitude, isLoading: false));
  }
}