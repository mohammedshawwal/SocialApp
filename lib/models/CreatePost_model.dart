class CreatePostModel {
  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? postImage;
  String? Text;



  CreatePostModel({
    this.name,
    this.Text,
    this.uId,
    this.dateTime,
    this.image,
    this.postImage,
  });

  CreatePostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    Text = json['Text'];
    uId = json['uId'];
    dateTime = json['dateTime'];
    image = json['image'];
    postImage=json['postImage'];

  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dateTime': dateTime,
      'uId': uId,
      'Text': Text,
      'image': image,

      'postImage': postImage,
    };
  }
}
