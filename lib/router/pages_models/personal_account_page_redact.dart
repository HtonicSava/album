import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PersonalAccountPageRedact extends StatelessWidget {
  const PersonalAccountPageRedact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_arrow_left
          ,size: 36,
          ),
        ),
        title: const Text(
            'Personal Account Redact'
        ),
        actions: <Widget>[
          Center(
            child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: FaIcon(FontAwesomeIcons.solidBell)

                )
            ),
          ),

        ],
      ),
      body: const Center(
        child: Text(
            'Редактирование личного кабинета'
        ),
      ),
    );
  }
}
