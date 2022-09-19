import 'package:cep_search/application/controllers/get_address_cubit.dart';
import 'package:cep_search/infrastructure/get_address_repository.dart';
import 'package:cep_search/presentation/home/widgets/address_card_widget.dart';
import 'package:cep_search/presentation/home/widgets/cep_field_widget.dart';
import 'package:cep_search/presentation/map/map_overview_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeOverviewPage extends StatefulWidget {
  const HomeOverviewPage({Key? key}) : super(key: key);

  @override
  State<HomeOverviewPage> createState() => _HomeOverviewPageState();
}

class _HomeOverviewPageState extends State<HomeOverviewPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetAddressCubit(context.read<GetAddressRepository>())..loadAddressesHistory(),
      child: BlocConsumer<GetAddressCubit, GetAddressState>(
        listener: (context, state) {
          if (state.latitude != 0 && state.longitude != 0) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => OverviewMapPage(cep: state.cep, latitude: state.latitude, longitude: state.longitude),
              ),
            ).then((value) => context.read<GetAddressCubit>().clearCoordinates());
          }
          if (state.message.isNotEmpty) {
            showDialog(
              context: context, 
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      }, 
                      child: const Text('Fechar'),
                    )
                  ],
                  content: const Text(
                    'CEP não encontrado',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ), 
                );
              },
            ).then((value) => context.read<GetAddressCubit>().clearMessage());
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Busca CEP'),
              centerTitle: true,
            ),
            body: state.isLoading ? const Center(child: CircularProgressIndicator()) : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Image.asset('location_map.png', color: Colors.green, height: 200),
                    ),
                    CepFieldWidget(),
                    const SizedBox(height: 25),
                    state.addresses != null
                    ? AddressCardWidget(state: state, blocContext: context)
                    : Container(),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}