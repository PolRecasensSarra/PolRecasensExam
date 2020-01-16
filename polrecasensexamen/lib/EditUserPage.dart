import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditUserPage extends StatefulWidget {
  DocumentSnapshot doc;
  EditUserPage({@required this.doc});
  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  TextEditingController nameCTRL, usernameCTRL;
  String name = 'DefaultN', username = 'DefaulUserName';
  bool admin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[700],
        title: Text('Edit User'),
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
                hintText: widget.doc.data['name'],
              ),
              onChanged: (value) {
                setState(() {
                  widget.doc.data['name'] = value;
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
                hintText: widget.doc.data['username'],
              ),
              onChanged: (value) {
                setState(() {
                  widget.doc.data['username'] = value;
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
                  value: widget.doc.data['admin'],
                  onChanged: (bool valor) {
                    setState(() {
                      widget.doc.data['admin'] = valor;
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
    await Firestore.instance
        .collection('Users')
        .document(widget.doc.documentID)
        .setData({
      "name": widget.doc.data['name'],
      "username": widget.doc.data['username'],
      "admin": widget.doc.data['admin'],
    });
  }
}
