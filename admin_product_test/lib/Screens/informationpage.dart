import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ebutler/Shared/constants.dart';
import 'package:ebutler/providers/productdb.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:ebutler/providers/informations.dart' as info;
import '/Shared/appdrawer.dart';
import '/Services/auth.dart';
import '/Services/database.dart';
import '/Model/user.dart';

class InformationPage extends StatefulWidget {
  static const routeName = '/Informationpage';

  const InformationPage({Key key}) : super(key: key);

  @override
  State<InformationPage> createState() => _ProductsState();
}

class _ProductsState extends State<InformationPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String id = '';
    String title = '';
    String description = '';

    bool idCheck = true;

    final user = Provider.of<User>(context);
    final information = Provider.of<info.Informationlist>(context);

    final AuthService _auth = AuthService();

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Information'),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () async {
              await _auth.signOut();
            },
            label: const Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'title'),
                  onChanged: (val) {
                    title = val;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'id'),
                  onChanged: (val) {
                    for (int i = 0; i < information.informationsCount; i++) {
                      if (val ==
                          information.informations.values.toList()[i].id) {
                        idCheck = false;
                        break;
                      } else {
                        idCheck = true;
                      }
                    }
                    if (idCheck == true) {
                      id = val;
                    }
                  },
                  validator: (val) => val.isEmpty || idCheck == false
                      ? 'please enter id with unique id'
                      : null,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration:
                      textInputDecoration.copyWith(hintText: 'description'),
                  onChanged: (val) {
                    description = val;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  child: Text('Add'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Provider.of<info.Informationlist>(context, listen: false)
                          .addInfo(
                        id,
                        title,
                        description,
                      );
                      _formKey.currentState.reset();
                    }
                  },
                ),
                RaisedButton(
                  child: Text('Update'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Provider.of<info.Informationlist>(context, listen: false)
                          .addInfo(
                        id,
                        title,
                        description,
                      );
                      _formKey.currentState.reset();
                    }
                  },
                ),
                RaisedButton(
                    child: Text(
                      'Send',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.purple,
                    onPressed: () {
                      for (int i = 0; i < information.informationsCount; i++) {
                        DatabaseService(id: user.uid).updateInformationData(
                          i,
                          information.informations.values.toList()[i].id,
                          information.informations.values.toList()[i].title,
                          information.informations.values
                              .toList()[i]
                              .description,
                        );
                      }
                    }),
                RaisedButton(
                    child: Text('Set up'),
                    onPressed: () {
                      DatabaseService(id: user.uid).setDocument1();
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
