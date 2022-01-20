import 'package:album/router/app_router.gr.dart';
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';

class PersonalAccountPage extends StatelessWidget {
  const PersonalAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Account'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Личный кабинет'),
            ElevatedButton(
                onPressed: () => {
                  context.router.push(PersonalAccountRouteRedact())
                }, child: const Text("Редактировать профиль"))
          ],
        ),
      ),
    );
  }
}
