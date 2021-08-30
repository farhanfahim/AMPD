
class Reviews {
  int id;
  int userId;
  double rating;
  String name;
  String review;
  String image;

  Reviews({this.id, this.userId, this.rating,this.name,this.review,this.image});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    rating = json['rating'];
    name = json['name'];
    review = json['review'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['rating'] = this.rating;
    data['name'] = this.name;
    data['review'] = this.review;
    data['image'] = this.image;
    return data;
  }
}