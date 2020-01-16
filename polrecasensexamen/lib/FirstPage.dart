import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:polrecasensexamen/AddUserPage.dart';
import 'package:polrecasensexamen/EditUserPage.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  setupStatus() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[700],
        title: Row(
          children: <Widget>[
            Text("Users List"),
            Spacer(),
            IconButton(
              icon: Icon(
                Icons.group_add,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddUserPage(),
                ));
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('Users').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<DocumentSnapshot> docs = snapshot.data.documents;
          return ListView.separated(
            itemCount: docs.length,
            separatorBuilder: (context, index) => Divider(
              height: 1,
              indent: 20,
            ),
            itemBuilder: (context, index) {
              Map<String, dynamic> data = docs[index].data;
              return ListTile(
                title: Text(
                  data['username'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  data['name'],
                ),
                trailing: Text(
                  (data['admin']) ? 'Admin' : 'No Admin',
                ),
                onLongPress: () {
                  deleteFromUser(docs[index].reference);
                },
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EditUserPage(
                      doc: docs[index],
                    ),
                  ));
                },
              );
            },
          );
        },
      ),
    );
  }

  void setInfoDB(bool valor, String id, Map<String, dynamic> data) async {
    await Firestore.instance
        .collection('Users')
        .document(id)
        .setData({'admin': valor, 'name': data['name']});
  }

  void deleteFromUser(DocumentReference id) async {
    await Firestore.instance.runTransaction((Transaction myTransaction) async {
      await myTransaction.delete(id);
    });

    // Refresh data
    await setupStatus();
  }
}
