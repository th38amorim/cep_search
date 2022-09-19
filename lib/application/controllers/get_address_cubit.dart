import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cep_search/infrastructure/get_address_repository.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetAddressState {
  GetAddressState({this.isLoading = false, this.cep = '', this.latitude = 0, this.longitude = 0, this.message = '', this.addresses});

  final bool isLoading;
  final String cep;
  final double latitude;
  final double longitude;
  final List<dynamic>? addresses;
  final String message;

  factory GetAddressState.initial() {
    return GetAddressState(
      addresses: []
    );
  }

  GetAddressState copyWith({
    bool? isLoading,
    String? cep,
    double? latitude,
    double? longitude,
    List<dynamic>? addresses,
    String? message,
  }) {
    return GetAddressState(
      isLoading: isLoading ?? this.isLoading,
      cep: cep ?? this.cep,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      addresses: addresses ?? this.addresses,
      message: message ?? this.message,
    );
  }
}

class GetAddressCubit extends Cubit<GetAddressState> {
  GetAddressCubit(this.getAddressRepository) : super(GetAddressState.initial());

  final GetAddressRepository getAddressRepository;

  Future<void> getAddressByCEP({String? cep}) async {
    emit(state.copyWith(isLoading: true));
    Map<String, dynamic> loadAddressByCEP = await getAddressRepository.getAddressByCEP(cep!);
    if (loadAddressByCEP['logradouro'] != null) {
      List<dynamic>? allAddresses = [];
      allAddresses = state.addresses;
      allAddresses?.add(loadAddressByCEP);
      emit(state.copyWith(addresses: allAddresses, cep: cep));
      saveSearchHistory();
      getCoordinates(street: loadAddressByCEP['logradouro'], neighborhood: loadAddressByCEP['bairro']);
    } else {
      emit(state.copyWith(message: 'CEP não encontrado', isLoading: false));
    }
  }

  Future<void> getCoordinates({String? street, String? neighborhood}) async {
    List<Location> locations = await locationFromAddress(street! + neighborhood!);
    emit(state.copyWith(latitude: locations[0].latitude, longitude: locations[0].longitude, isLoading: false));
  }

  Future<void> loadAddressesHistory() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('enderecos') != null) {
      String? addressesString = prefs.getString('enderecos');  
      emit(state.copyWith(addresses: jsonDecode(addressesString!)));
    }
  }

  void saveSearchHistory() async {
  final prefs = await SharedPreferences.getInstance();
  String addressString = jsonEncode(state.addresses);
  await prefs.setString('enderecos', addressString);
  }

  void clearCoordinates() {
    emit(state.copyWith(latitude: 0, longitude: 0));
  }

  void clearMessage() {
    emit(state.copyWith(message: ''));
  }
}