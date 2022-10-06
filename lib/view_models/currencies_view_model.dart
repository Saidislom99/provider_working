import 'package:flutter/material.dart';
import 'package:provider_working/data_layer/models/currency_item.dart';
import 'package:provider_working/data_layer/repository/currency_repository.dart';

class CurrencyViewModel extends ChangeNotifier{
CurrencyViewModel({required this.currencyRepository});

  final CurrencyRepository currencyRepository;
  List<CurrencyItem> currencyItems= [];
  bool isLoading=false;


  fetchCurrencyList()async{
    isLoading=true;
    notifyListeners();
    currencyItems=await currencyRepository.getAllCurrencies();
    isLoading=false;
    notifyListeners();
  }

}