import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FireBase"),
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('Tareas').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<DocumentSnapshot> docs = snapshot.data.documents;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> data = docs[index].data;
              return ListTile(
                leading: Checkbox(
                  value: data['done'],
                  onChanged: (bool valor) {
                    setState(() {
                      setInfoDB(valor, docs[index].documentID, data);
                    });
                  },
                ),
                title: Text(data['what']),
              );
            },
          );
        },
      ),
    );
  }

  void setInfoDB(bool valor, String id, Map<String, dynamic> data) async {
    await Firestore.instance
        .collection('Tareas')
        .document(id)
        .setData({'done': valor, 'what': data['what']});
  }
}
