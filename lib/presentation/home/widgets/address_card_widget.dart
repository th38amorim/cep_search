import 'package:cep_search/application/controllers/get_address_cubit.dart';
import 'package:cep_search/presentation/home/widgets/row_address_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressCardWidget extends StatelessWidget {
  const AddressCardWidget({
    Key? key, required this.state, required this.blocContext,
  }) : super(key: key);

  final GetAddressState state;
  final BuildContext blocContext;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      reverse: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.addresses?.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GestureDetector(
            onTap: () {
              blocContext.read<GetAddressCubit>().getCoordinates(street: state.addresses?[index]['logradouro'], neighborhood: state.addresses?[index]['bairro']);
            },
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: Column(
                  children: [
                    RowAddressWidget(
                      keyValue: 'CEP:',
                      value: state.addresses?[index]['cep'],
                    ),
                    RowAddressWidget(
                      keyValue: 'Logradouro:',
                      value: state.addresses?[index]['logradouro'],
                    ),
                    RowAddressWidget(
                      keyValue: 'Bairro:',
                      value: state.addresses?[index]['bairro'],
                    ),
                    RowAddressWidget(
                      keyValue: 'Cidade:',
                      value: state.addresses?[index]['localidade'],
                    ),
                    RowAddressWidget(
                      keyValue: 'Estado:',
                      value: state.addresses?[index]['uf'],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}