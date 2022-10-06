import 'package:provider_working/data_layer/models/currency_item.dart';
import 'package:provider_working/data_layer/services/api_service.dart';


class CurrencyRepository{
  CurrencyRepository({required ApiService apiService}){
    _apiService= apiService;
  }
  late ApiService _apiService;


  Future<List<CurrencyItem>>getAllCurrencies(){
    return _apiService.getCurrencyList();
  }
}