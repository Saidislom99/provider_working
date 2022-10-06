import 'package:flutter/foundation.dart';
import 'package:provider_working/data_layer/models/user_data.dart';
import 'package:provider_working/data_layer/repository/user_repository.dart';

import '../data_layer/db/cached_users.dart';

class UserViewModel extends ChangeNotifier {
  UserViewModel({required this.userRepository});

  final UserRepository userRepository;
  List<CachedUser> cachedUser= [];
  UserData? userData;
  bool isLoading=false;

  getCachedUsers()async{
    isLoading =true;
    notifyListeners();
    cachedUser= await userRepository.getCachedUser();
    isLoading=false;
    notifyListeners();
  }

  getUserSave()async{
    isLoading=true;
    notifyListeners();
    userData= await userRepository.getUserData();
  await  userRepository.insertUserFromApi(userData: userData!);
    cachedUser= await userRepository.getCachedUser();
    isLoading=false;
    notifyListeners();
  }

  deleteUserAll() async{
    isLoading=true;
    notifyListeners();
    await userRepository.deleteAllUser();
    cachedUser= await userRepository.getCachedUser();
    isLoading=false;
    notifyListeners();

  }

}