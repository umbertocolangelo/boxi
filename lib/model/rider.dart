class Rider {
  String id;
  String firstName;
  String lastName;

  Rider({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "firstName": firstName,
      "lastName": lastName,
    };
  }

  factory Rider.fromJson(Map<String, dynamic> json) {
    return Rider(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName']);
  }
}
