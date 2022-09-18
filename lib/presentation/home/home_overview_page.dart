import 'package:cep_search/application/controllers/get_address_cubit.dart';
import 'package:cep_search/infrastructure/get_address_repository.dart';
import 'package:cep_search/presentation/home/widgets/cep_field_widget.dart';
import 'package:cep_search/presentation/map/initial_map.dart';
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
      create: (_) => FindAddressCubit(context.read<GetAddressRepository>()),
      child: BlocConsumer<FindAddressCubit, FindAddressState>(
        listener: (context, state) {
          if (state.latitude != null && state.longitude != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => MapTestWidget(latitude: state.latitude!, longitude: state.longitude!),
              ),
            );
          }
          if (state.message != null) {
            showDialog(
              context: context, 
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)
                  ),
                  actions: [
                    IconButton(onPressed: () {
                      Navigator.of(context).pop();
                    }, icon: const Icon(Icons.close))
                  ],
                  content: const Text(
                    'CEP não encontrado',
                    textAlign: TextAlign.center,
                  ), 
                );
              },
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Busca CEP'),
              centerTitle: true,
            ),
            body: state.isLoading! ? const Center(child: CircularProgressIndicator()) : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: Icon(Icons.map_outlined, size: 150, color: Colors.green),
                    ),
                    CepFieldWidget(),
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