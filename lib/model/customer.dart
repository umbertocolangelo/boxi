class Customer {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  Customer(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.password});

  Map<String, dynamic> toJson() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": password
    };
  }

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        password: json['password']);
  }
}
