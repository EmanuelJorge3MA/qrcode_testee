import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qrcode_teste/payment_model.dart';

class ListViewScreen extends StatefulWidget {
  const ListViewScreen({Key? key}) : super(key: key);

  @override
  State<ListViewScreen> createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  Stream<List<PaymentModel>> readTask() {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    return FirebaseFirestore.instance.collection('payment').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => PaymentModel.fromMap(doc.data()))
            .toList());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PaymentModel>>(
      stream: readTask(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return const Text('Something Went Wrong Try later');
            }
            if (snapshot.data!.isEmpty) {
              return const Center(child: Text('No Payment'));
            } else {
              final tasks = snapshot.data;

              //Provider.of<TaskManager>(context, listen: false).setTask(tasks!);

              return ListView.separated(
                itemCount: tasks!.length,
                itemBuilder: (context, index) {
                  final item = tasks[index];
                  return ListTile(
                    title: Text(item.nameUser!),
                    subtitle: Text(item.money!.toString() + ' kz'),
                    leading: Text(
                      item.status!,
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(item.nameClient!),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 16.0);
                },
              );
            }
        }
      },
    );
  }
}
