class PostModel {
  String name;
  //String phone;
  String userId;
  String image;
  String dateTime;
  String text;
  String postImage;


  PostModel(
      {this.name,
      this.text,
      this.dateTime,
    //  this.phone,
      this.postImage,
      this.userId,
      this.image,

      });

  ///to receive data
  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  //  phone = json['phone'];
    userId = json['userId'];
    image = json['image'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];

  }

  ///to send data
  Map<String, dynamic> toMap() {
    return {
      'name': name,
    //  'phone': phone,
      'userId': userId,
      'image': image,
      'dateTime':dateTime,
      'text': text,
      'postImage':postImage,

    };
  }
}
