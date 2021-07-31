class ImageModel {
  String xtImage;
  String id;

  ImageModel({this.xtImage, this.id});

  ImageModel.fromJson(Map<String, dynamic> json) {
    xtImage = json['xt_image'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['xt_image'] = this.xtImage;
    data['id'] = this.id;
    return data;
  }
}