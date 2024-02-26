class UserModel {
  final String fullName;
  final String email;
  final String password;
  final String uid;

  const UserModel({
    required this.fullName,
    required this.email,
    required this.password,
    required this.uid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "fullName": fullName,
      "email": email,
      "password": password,
      "uid": uid,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      fullName: map["fullName"] as String,
      email: map["email"] as String,
      password: map["password"] as String,
      uid: map["uid"] as String,
    );
  }
}
