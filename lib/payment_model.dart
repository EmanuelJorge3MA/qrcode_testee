class PaymentModel {
  String? uidPayment;
  String? nameUser;
  String? idUser;
  String? nameClient;
  String? status;
  int? money;

  PaymentModel({
    this.uidPayment,
    this.nameUser,
    this.idUser,
    this.nameClient,
    this.status,
    this.money,
  });

  // factory PaymentModel.fromMap(map) {
  //   return PaymentModel(
  //     uidPayment: map['uid_payment'],
  //     nameUser: map['name_user'],
  //     idUser: map['id_user'],
  //     money: map['money'],
  //   );
  // }

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      uidPayment: map['uidPayment'],
      nameUser: map['nameUser'],
      idUser: map['idUser'],
      nameClient: map['nameClient'],
      status: map['status'],
      money: map['money']?.toInt(),
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (uidPayment != null) {
      result.addAll({'uidPayment': uidPayment});
    }
    if (nameUser != null) {
      result.addAll({'nameUser': nameUser});
    }
    if (idUser != null) {
      result.addAll({'idUser': idUser});
    }
    if (nameClient != null) {
      result.addAll({'nameClient': nameClient});
    }
    if (status != null) {
      result.addAll({'status': status});
    }
    if (money != null) {
      result.addAll({'money': money});
    }

    return result;
  }
}
