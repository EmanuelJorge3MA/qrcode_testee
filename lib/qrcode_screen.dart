import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrcode_teste/payment_model.dart';
import 'package:uuid/uuid.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({Key? key}) : super(key: key);

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  final controller = TextEditingController();
  String ticket = '';
  String nameAccount = 'Emanuel Jorge';
  String idAccount = 'A244205';
  String uidPayment = '';
  int money = 0;

  Future<void> realQRCode() async {
    String code = await FlutterBarcodeScanner.scanBarcode(
      '#ffffff',
      'Cancelar',
      false,
      ScanMode.QR,
    );
    setState(() {
      ticket = code != '-1' ? code : 'Não validado';
      if (code != '-1') {
        updateTask(code);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: const BorderRadius.all(Radius.circular(30))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.check_circle_rounded,
                    size: 14,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    'Pago',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.green),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        );
      }
    });
  }

  Future<void> createPayment() async {
    PaymentModel paymentModel = PaymentModel(
      uidPayment: uidPayment,
      nameUser: nameAccount,
      idUser: idAccount,
      nameClient: '',
      status: 'pendente',
      money: money,
    );

    final taskData =
        FirebaseFirestore.instance.collection('payment').doc(uidPayment);

    await taskData.set(paymentModel.toMap());
  }

  Future updateTask(String uidPayQr) async {
    PaymentModel paymentModel = PaymentModel(
      // uidPayment: uidPayment,
      // nameUser: nameAccount,
      // idUser: idAccount,
      nameClient: nameAccount,
      status: 'Pago',
      // money: money,
    );

    final firebaseFirestore =
        FirebaseFirestore.instance.collection('payment').doc(uidPayQr);

    await firebaseFirestore.update(paymentModel.toMap());
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
                uidPayment = Uuid().v1();
                createPayment();
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
            data: uidPayment,
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
