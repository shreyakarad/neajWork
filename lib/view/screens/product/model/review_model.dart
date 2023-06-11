class ReviewModel {
  int id;
  String dateCreated;
  String review;
  int rating;
  String name;
  String email;
  bool verified;

  ReviewModel(
      {this.id,
        this.dateCreated,
        this.review,
        this.rating,
        this.name,
        this.email,
        this.verified});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    review = json['review'];
    rating = json['rating'];
    name = json['name'];
    email = json['email'];
    verified = json['verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date_created'] = this.dateCreated;
    data['review'] = this.review;
    data['rating'] = this.rating;
    data['name'] = this.name;
    data['email'] = this.email;
    data['verified'] = this.verified;
    return data;
  }
}


class SubmitReviewModel {
  int productId;
  String review;
  String reviewer;
  String reviewerEmail;
  int rating;

  SubmitReviewModel(
      {this.productId,
        this.review,
        this.reviewer,
        this.reviewerEmail,
        this.rating});

  SubmitReviewModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    review = json['review'];
    reviewer = json['reviewer'];
    reviewerEmail = json['reviewer_email'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['review'] = this.review;
    data['reviewer'] = this.reviewer;
    data['reviewer_email'] = this.reviewerEmail;
    data['rating'] = this.rating;
    return data;
  }
}
