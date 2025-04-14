import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infoware_assignment/blocs/audio/audio_bloc.dart';
import 'package:infoware_assignment/blocs/product/product_bloc.dart';
import 'package:infoware_assignment/blocs/product/product_event.dart';
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
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc()..add(FetchProducts()),
        ),
        BlocProvider<AudioBloc>(
          create: (context) => AudioBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'BLoC Structure App',
        theme: ThemeData(primarySwatch: Colors.green),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/home': (context) => const BottomNavBarScreen(),
        },
      ),
    );
  }
}
