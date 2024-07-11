import 'package:flutter/material.dart';
import 'package:prod_tracker/auth/provider/user_provider.dart';
import 'package:prod_tracker/provider/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:prod_tracker/auth/ui/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  LoginScreen(),
      ),
    );
  }
}
