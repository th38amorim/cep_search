import 'package:cep_search/domain/core/cep_validator.dart';
import 'package:cep_search/presentation/home/widgets/cep_consult_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CepFieldWidget extends StatefulWidget {
  const CepFieldWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<CepFieldWidget> createState() => _CepFieldWidgetState();
}

class _CepFieldWidgetState extends State<CepFieldWidget> {
  MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
    mask: '#####-###', 
    filter: { "#": RegExp(r'[0-9]') },
  );

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
            key: _formKey,
            child: TextFormField(
              validator: (input) => ValueValidators.validateCep(input!),
              textAlign: TextAlign.center,
              scrollPadding: const EdgeInsets.only(bottom: 200),
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.green,
                  ), 
                ),
                hintText: 'Insira o CEP',
              ),
              inputFormatters: [maskFormatter],
              keyboardType: TextInputType.number,
            ),
          ),
        ),
        CepConsultButtonWidget(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              print('validado');
            }
          },
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}