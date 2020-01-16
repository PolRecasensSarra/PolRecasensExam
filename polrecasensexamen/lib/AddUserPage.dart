import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddUserPage extends StatefulWidget {
  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  TextEditingController nameCTRL, usernameCTRL;
  String name = 'DefaultName', username = 'DefaulUserName';
  bool admin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[700],
        title: Text('Add User'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(right: 32, left: 32, top: 12, bottom: 12),
            child: TextField(
              controller: nameCTRL,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Name',
              ),
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 32, left: 32, top: 12, bottom: 12),
            child: TextField(
              controller: nameCTRL,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'UserName',
              ),
              onChanged: (value) {
                setState(() {
                  username = value;
                });
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(right: 32, left: 32, top: 12, bottom: 12),
            child: Row(
              children: <Widget>[
                Checkbox(
                  value: admin,
                  onChanged: (bool valor) {
                    setState(() {
                      admin = valor;
                    });
                  },
                ),
                Text('Admin'),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 32),
            child: RaisedButton(
              child: Text(
                'SAVE',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.teal[500],
              onPressed: () {
                setInfoDB();
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    );
  }

  void setInfoDB() async {
    await Firestore.instance.collection('Users').add({
      "name": name,
      "username": username,
      "admin": admin,
    });
  }
}
