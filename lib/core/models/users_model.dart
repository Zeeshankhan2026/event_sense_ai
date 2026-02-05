class UserModel {

  String? name;
  String? email;
  String? password;
  String? confirmPassword;
  String? profileImage;
  String? user_id;
  String? userLocations;
  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.profileImage,
    this.userLocations,
      this.user_id,
});

  factory UserModel.fromJson(Map<String,dynamic> map, ){
    return UserModel(
      user_id: map["user_id"] ?? "",
      userLocations: map["userLocations"] ?? "",
    confirmPassword:  map["confirmPassword"] ?? "",
    name: map["name"] ?? "",
    email: map["email"] ?? "",
      password: map["password"] ?? "",
      profileImage: map["profile_image"] ?? "",
    );
  }

  UserModel copyWith({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    String? profileImage,
    String? userLocations,
    String? user_id,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      profileImage: profileImage ?? this.profileImage,
      userLocations: userLocations ?? this.userLocations,
      user_id: user_id ?? this.user_id,
    );
  }

}