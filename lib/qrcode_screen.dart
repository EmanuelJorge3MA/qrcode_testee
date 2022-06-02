import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({Key? key}) : super(key: key);

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  final controller = TextEditingController();
  String ticket = '';
  String nameAccount = 'Luís Bragança';
  String idAccount = 'A232205';
  int money = 0;

  Future<void> realQRCode() async {
    String code = await FlutterBarcodeScanner.scanBarcode(
      '#ffffff',
      'Cancelar',
      false,
      ScanMode.QR,
    );
    setState(() => ticket = code != '-1' ? code : 'Não validado');
  }

  Future<void> createPayment() async {
    final taskData = FirebaseFirestore.instance.collection('payment').doc();
  }

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        //   appBar: AppBar(
        //     title: const Text("QR Code Generator"),
        //   ),
        //   body:
        SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Name account:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    nameAccount,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    'ID account:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    idAccount,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
          TextField(
            controller: controller,
            key: const Key('signUpForm_emailInput_textField'),

            keyboardType: TextInputType.number,
            //onChanged: (value) => setState(() {}),
            onSubmitted: (value) {
              setState(() {
                money = int.parse(value);
              });
            },
            decoration: const InputDecoration(
              icon: Icon(
                Icons.monetization_on_rounded,
              ),
              labelText: 'Money',
              helperText: '''How much you want pay ? e.g. 1000Kz''',
              helperMaxLines: 2,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          QrImage(
            data: 'ID Account: $idAccount, Money: $money Kz',
            size: 200,
            backgroundColor: Colors.white,
          ),
          const SizedBox(
            height: 100,
          ),
          ElevatedButton(
            key: const Key('signUpForm_continue_raisedButton'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              primary: Colors.blue,
            ),
            onPressed: realQRCode,
            child: const Text(
              'Ler QR Code',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(ticket),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            key: const Key('limpar'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              primary: Colors.red,
            ),
            onPressed: () {
              setState(() {
                ticket = '';
              });
            },
            child: const Text(
              'Limpar',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
    // );
  }
}
