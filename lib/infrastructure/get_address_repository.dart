import 'dart:convert';
import 'dart:io';

import 'package:cep_search/endpoints.dart';
import 'package:http/http.dart' as http;

class GetAddressRepository {
  Future<dynamic> getAddressByCEP(String cep) async {
    final Uri url = Uri.parse(Endpoints.getAddressByCep(cep));
    final client = http.Client();
    final response = await client.get(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    );
    
    final body = json.decode(response.body);

    return body;
  }

}