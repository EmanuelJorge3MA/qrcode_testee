import 'package:flutter/material.dart';
import 'package:qrcode_teste/listview.dart';
import 'package:qrcode_teste/qrcode_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  final screens = [
    const QrCodeScreen(),
    const ListViewScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Code Generator"),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_rounded),
            label: 'QR Code',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payments_rounded),
            label: 'Payment',
          ),
        ],
      ),
    );
  }
}
