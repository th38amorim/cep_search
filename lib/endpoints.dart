class Endpoints{

  static String getAddressByCep(String cep) {
    return 'https://viacep.com.br/ws/$cep/json/';
  }

}