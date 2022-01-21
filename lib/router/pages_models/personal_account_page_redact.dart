import 'package:album/UI/icons/personal_account_icons_icons.dart';
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
                  child: const FaIcon(FontAwesomeIcons.solidBell)

                )
            ),
          ),

        ],
      ),
      body: Center(
        child: Column(
          children:  [
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Icon(
                PersonalAccountIcons.avatarPlaceholder,
                  size: 97

              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text('Maria_123', style: Theme.of(context).textTheme.headline5),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4, bottom: 12),
              child: Text('ptica777@gmail.com', style: Theme.of(context).textTheme.headline4),
            ),
            Expanded(
              child: Container(

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,

                ),
                child: Center(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Row(
                            children: const [

                            ],
                          )
                        ],
                      )
                    ],

                  ),
                ),


              ),
            )
          ],
        ),
      ),
    );
  }
}
