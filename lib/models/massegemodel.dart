class MassageModel {
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? Text;



  MassageModel({
    this.senderId,
    this.receiverId,
    this.dateTime,
    this.Text,

  });

  MassageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    Text = json['Text'];

  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,
      'Text': Text,

    };
  }
}
