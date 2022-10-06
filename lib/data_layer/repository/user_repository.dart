
import 'package:provider_working/data_layer/db/local_database.dart';
import 'package:provider_working/data_layer/models/user_data.dart';
import 'package:provider_working/data_layer/services/api_service.dart';

import '../db/cached_users.dart';

class UserRepository {
  UserRepository({required this.apiService});

  final ApiService apiService;

  Future<UserData> getUserData() => apiService.getUserData();
  Future<List<CachedUser>> getCachedUser()=> LocalDatabase.getAllCachedUser();
  Future<CachedUser>insertUserFromApi({required UserData userData})=> LocalDatabase.insertCachedUserFromApi(userData);
  Future<int> deleteAllUser()=>LocalDatabase.deleteAllCachedUsers();

}