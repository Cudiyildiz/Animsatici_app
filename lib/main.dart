import 'package:flutter/material.dart';
import 'package:animsatici_app/ui/cubit/anasayfacubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animsatici_app/ui/cubit/detaysayfacubit.dart';
import 'package:animsatici_app/ui/cubit/kayitsayfacubit.dart';
import 'package:animsatici_app/ui/views/anasayfa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AnasayfaCubit()),
        BlocProvider(create: (context) => DetaySayfaCubit()),
        BlocProvider(create: (context) => KayitSayfaCubit()),
      ],
      child: MaterialApp(
        title: 'Animsatici',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Anasayfa(),
      ),
    );
  }
}
