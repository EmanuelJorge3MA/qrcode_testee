import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = TextEditingController();
  String ticket = '';

  Future<void> realQRCode() async {
    String code = await FlutterBarcodeScanner.scanBarcode(
      '#ffffff',
      'Cancelar',
      false,
      ScanMode.QR,
    );
    setState(() => ticket = code != '-1' ? code : 'Não validado');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Code Generator"),
      ),
      body: SingleChildScrollView(
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
                  children: const [
                    Text(
                      'Name account:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Luís Bragança',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'ID account:',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'A232205',
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
              onSubmitted: (value) => setState(() {}),
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
              data: 'ID Account: A244205, Money: ${controller.text} Kz',
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
      ),
    );
  }
}
