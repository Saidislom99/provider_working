import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_working/data_layer/repository/currency_repository.dart';
import 'package:provider_working/data_layer/repository/user_repository.dart';
import 'package:provider_working/data_layer/services/api_service.dart';
import 'package:provider_working/presentation/currencies_screen/currencies_screen.dart';
import 'package:provider_working/view_models/currencies_view_model.dart';
import 'package:provider_working/view_models/user_view_model.dart';

void  main(){
  ApiService apiService =ApiService();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
          create: (context)=> CurrencyViewModel(
              currencyRepository:
              CurrencyRepository(apiService: apiService))),
      ChangeNotifierProvider(create: (context)=> UserViewModel(
          userRepository:
          UserRepository(apiService: apiService)))
    ],
    child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CurrenciesScreen(),
    );
  }
}
