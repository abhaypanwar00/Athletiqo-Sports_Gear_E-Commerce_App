class AddressModel {
  final String id;
  final String name;
  final String phone;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final bool isDefault;

  AddressModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.isDefault,
  });

  Map<String, dynamic> toMap() => {
        'name': name,
        'phone': phone,
        'street': street,
        'city': city,
        'state': state,
        'postalCode': postalCode,
        'isDefault': isDefault,
      };

  factory AddressModel.fromMap(String id, Map<String, dynamic> map) {
    return AddressModel(
      id: id,
      name: map['name'],
      phone: map['phone'],
      street: map['street'],
      city: map['city'],
      state: map['state'],
      postalCode: map['postalCode'],
      isDefault: map['isDefault'] ?? false,
    );
  }
}