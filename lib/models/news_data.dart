class NewsData {
  String? id;
  String? url;
  String? title;
  String? text;
  String? publisher;
  String? author;
  String? image;
  String? date;

  NewsData(
      {this.id,
      this.url,
      this.title,
      this.text,
      this.publisher,
      this.author,
      this.image,
      this.date});

  NewsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    title = json['title'];
    text = json['text'];
    publisher = json['publisher'];
    author = json['author'];
    image = json['image'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['title'] = title;
    data['text'] = text;
    data['publisher'] = publisher;
    data['author'] = author;
    data['image'] = image;
    data['date'] = date;
    return data;
  }
}