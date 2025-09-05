class AddressModel {
  String name;
  String phone;
  String city;
  String district;
  String ward;
  String street;
  String note;
  bool isDefault;
  bool isPickup;
  bool isReturn;
  String type;
  double? lat;
  double? lng;

  AddressModel({
    required this.name,
    required this.phone,
    required this.city,
    required this.district,
    required this.ward,
    required this.street,
    this.note = '',
    this.isDefault = false,
    this.isPickup = false,
    this.isReturn = false,
    this.type = 'Nhà riêng',
    this.lat,
    this.lng,
  });

  static AddressModel empty() => AddressModel(
    name: '',
    phone: '',
    city: '',
    district: '',
    ward: '',
    street: '',
    note: '',
    isDefault: false,
    isPickup: false,
    isReturn: false,
    type: 'Nhà riêng',
    lat: null,
    lng: null,
  );

  AddressModel copy() => AddressModel(
    name: name,
    phone: phone,
    city: city,
    district: district,
    ward: ward,
    street: street,
    note: note,
    isDefault: isDefault,
    isPickup: isPickup,
    isReturn: isReturn,
    type: type,
    lat: lat,
    lng: lng,
  );

  String get fullAddress => '$street, $ward, $district, $city';

  Map<String, dynamic> toJson() => {
    'name': name,
    'phone': phone,
    'city': city,
    'district': district,
    'ward': ward,
    'street': street,
    'note': note,
    'isDefault': isDefault,
    'isPickup': isPickup,
    'isReturn': isReturn,
    'type': type,
    'lat': lat,
    'lng': lng,
  };

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    name: json['name'],
    phone: json['phone'],
    city: json['city'],
    district: json['district'],
    ward: json['ward'],
    street: json['street'],
    note: json['note'],
    isDefault: json['isDefault'],
    isPickup: json['isPickup'],
    isReturn: json['isReturn'],
    type: json['type'],
    lat: json['lat'],
    lng: json['lng'],
  );
}
