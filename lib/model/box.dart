class Box {
  final String id;
  String lockerId;
  final String size;
  String isAvailable;
  String isOffer;

  Box(
      {required this.id,
      required this.lockerId,
      required this.size,
      required this.isAvailable,
      required this.isOffer});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "lockerId": lockerId,
      "size": size,
      "isAvailable": isAvailable,
      "isOffer": isOffer
    };
  }

  factory Box.fromJson(Map<String, dynamic> json) {
    return Box(
        id: json['id'],
        lockerId: json['lockerId'],
        size: json['size'],
        isAvailable: json['isAvailable'],
        isOffer: json['isOffer']);
  }
  
}
