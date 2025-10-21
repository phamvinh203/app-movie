import 'package:app_movie/common/helper/navigation/app_navigation.dart';
import 'package:app_movie/domain/auth/usecases/signout.dart';
import 'package:app_movie/presentation/auth/pages/signin.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => {
              SignOutUseCase().call().then((_) {
                AppNavigator.pushAndRemove(context, const SigninPage());
              })
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Home Page!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            
          ],
        ),
      ),
    );
  }


}
