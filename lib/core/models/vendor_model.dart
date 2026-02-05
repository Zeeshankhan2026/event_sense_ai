class VendorModel {
  String? companyName;
  String? serviceCategory;
  String? location;
  String? email;
  String? password;
  String? phone;
  String? profileImage;
  String? vendor_uid;

  VendorModel({
    required this.companyName,
    required this.serviceCategory,
    required this.location,
    required this.email,
    required this.password,
    required this.profileImage,
    required this.phone,
     this.vendor_uid,
  });

  factory VendorModel.FromJson(Map<String, dynamic> map) {
    return VendorModel(
      companyName: map["companyName"],
      serviceCategory: map["serviceCategory"],
      location: map["location"],
      email: map["email"],
      password: map["password"],
      profileImage: map["profileImage"],
      phone: map["phone"],
      vendor_uid: map["vendor_uid"] ?? map["uUid"],
    );
  }

  Map<String, dynamic> ToJson() {
    return {
      "companyName" : companyName,
      "serviceCategory" : serviceCategory,
      "location" : location,
      "email" : email,
      "password" : password,
      "profileImage" : profileImage,
      "phone" : phone,
      "vendor_uid" : vendor_uid,
    };
  }
}
