import 'package:cep_search/presentation/home/widgets/cep_field_widget.dart';
import 'package:cep_search/presentation/map/initial_map.dart';
import 'package:flutter/material.dart';

class HomeOverviewPage extends StatefulWidget {
  const HomeOverviewPage({Key? key}) : super(key: key);

  @override
  State<HomeOverviewPage> createState() => _HomeOverviewPageState();
}

class _HomeOverviewPageState extends State<HomeOverviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Busca CEP'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const MapTestWidget(),
            ),
          );
        },
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Icon(Icons.map_outlined, size: 150, color: Colors.green),
              ),
              CepFieldWidget(),
            ],
          ),
        ),
      ),
    );
  }
}