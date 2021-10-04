class UserModel
{
  String name;
  String phone;
  String email;
  String userId;
  String image;
  String coverImage;
  String bio;
  bool isEmailVerified;

  UserModel({this.name,this.coverImage,this.bio, this.phone, this.email, this.userId,this.isEmailVerified,this.image});

  ///to receive data
  UserModel.fromJson(Map<String,dynamic>json)
  {
    name=json['name'];
    phone=json['phone'];
    email=json['email'];
    userId=json['userId'];
    bio=json['bio'];
    isEmailVerified=json['isEmailVerified'];
    image=json['image'];
    coverImage=json['coverImage'];
  }


  ///to send data
  Map<String,dynamic> toMap()
  {
    return{
      'name':name,
      'phone':phone,
      'email':email,
      'userId':userId,
      'isEmailVerified':isEmailVerified,
      'image':image,
      'bio':bio,
      'coverImage':coverImage,
    };
  }
}
