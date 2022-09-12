
class UserModel {
  final String? name, email, phone, uId, image, bio, cover;

  UserModel({
    this.bio,
    this.image,
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.cover,
  });

  factory UserModel.fromJson(Map<String, dynamic>? json) => UserModel(
        name: json?['name'],
        email: json?['email'],
        phone: json?['phone'],
        uId: json?['uId'],
        image: json?['image'],
        bio: json?['bio'],
        cover: json?['cover'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'uId': uId,
        'image': image,
        'bio': bio,
        'cover': cover,
      };
}
