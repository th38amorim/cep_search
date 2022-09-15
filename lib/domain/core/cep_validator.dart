class ValueValidators {
  static String? validateStringEmpty(String input) {
    if (input.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  static String? validateCep(String input) {
    if(input.length != 9 && input.isNotEmpty) {
      return "CEP inválido";
    }
    return validateStringEmpty(input);
  }

}
