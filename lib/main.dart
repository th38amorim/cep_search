import 'package:cep_search/dependencies.dart';
import 'package:cep_search/presentation/home/home_overview_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: buildRepositories(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Busca CEP',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const HomeOverviewPage(),
      ),
    );
  }
}