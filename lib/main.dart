import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infoware_assignment/blocs/audio/audio_bloc.dart';
import 'package:infoware_assignment/blocs/product/product_bloc.dart';
import 'package:infoware_assignment/blocs/product/product_event.dart';
import 'package:infoware_assignment/blocs/form/form_bloc.dart'; // Importing the FormBloc
import 'package:infoware_assignment/screens/Bottomnavbar.dart';
import 'screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Providing ProductBloc
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc()..add(FetchProducts()),
        ),
        
        // Providing AudioBloc
        BlocProvider<AudioBloc>(
          create: (context) => AudioBloc(),
        ),
        
        // Providing FormBloc
        BlocProvider<FormBloc>(
          create: (context) => FormBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BLoC Structure App',
        theme: ThemeData(primarySwatch: Colors.green),
        initialRoute: '/', // Initial route set to SplashScreen
        routes: {
          '/': (context) => const SplashScreen(), // Splash screen
          '/home': (context) => const BottomNavBarScreen(), // Bottom nav bar screen
        },
      ),
    );
  }
}
