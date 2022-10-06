import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_working/data_layer/db/cached_users.dart';

import '../../view_models/user_view_model.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  void initState() {

    _init();
    super.initState();
  }


  void _init() async {
    await Future.delayed(Duration.zero, () {
      Provider.of<UserViewModel>(context).getCachedUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
        actions: [
          IconButton(
            onPressed: () {
              context.read<UserViewModel>().getUserSave();
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              context.read<UserViewModel>().deleteUserAll();

            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Column(
        children: [
          Consumer<UserViewModel>(
            builder: (context, userViewModel, child) {
              return userViewModel.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: ListView(
                        children: List.generate(
                            userViewModel.cachedUser.length, (index) {
                          CachedUser currency =
                              userViewModel.cachedUser[index];
                          return Container(
                            margin: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.amberAccent,
                            ),
                            width: 200,
                            height: MediaQuery.of(context).size.height/7,

                            child: Column(
                              children: [
                                Text(currency.name),
                                Text(currency.count.toString()),
                                Text(currency.age.toString())
                              ],
                            ),
                          );
                        }),
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
