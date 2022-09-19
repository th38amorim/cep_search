import 'package:cep_search/application/controllers/get_address_cubit.dart';
import 'package:cep_search/domain/core/cep_validator.dart';
import 'package:cep_search/presentation/home/widgets/cep_consult_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CepFieldWidget extends StatelessWidget {
  CepFieldWidget({
    Key? key,
  }) : super(key: key);

  MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
    mask: '#####-###', 
    filter: { "#": RegExp(r'[0-9]') },
  );

  final _formKey = GlobalKey<FormState>();
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetAddressCubit, GetAddressState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: textEditingController,
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
                  context.read<GetAddressCubit>().getAddressByCEP(cep: textEditingController.text);
                }
              },
            ),
            const SizedBox(height: 25),
          ],
        );
      }
    );
  }
}