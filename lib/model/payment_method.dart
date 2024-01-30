abstract class PaymentMethod {
  Map<String, dynamic> toMap() {
    return {};
  }
}

class CreditCard extends PaymentMethod {
  String cardNumber;
  String cardHolderName;
  String expirationDate;
  String cvv;

  CreditCard({
    required this.cardNumber,
    required this.cardHolderName,
    required this.expirationDate,
    required this.cvv,
  });
}

class PayPal extends PaymentMethod {
  String email;
  String password;

  PayPal({
    required this.email,
    required this.password,
  });
}
