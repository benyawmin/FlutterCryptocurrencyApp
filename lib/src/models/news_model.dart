import 'dart:convert';

class NewsModel {
  late List<News> news;
  late List<News> dbNews;

  NewsModel({required this.news});

  NewsModel.fromJson(Map<String, dynamic> json) {
    if (json['news'] != null) {
      news = [];
      json['news'].forEach((v) {
        news.add(new News.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.news != null) {
      data['news'] = this.news.map((v) => v.toJson()).toList();
    }
    return data;
  }

  NewsModel.fromDb(List<Map<String, dynamic>> dbToJson) {
    // PROBLEM WITH DATABASE IS HERE
    // print(dbToJson);
    if (dbToJson != null) {
      // print(dbToJson);
      dbNews = [];
      dbToJson.forEach((v) {
        dbNews.add(new News.fromDb(v));
      });
    }
    // print(dbNews);
  }
}

class News {
  late String id;
  late String title;
  late String description;
  late String url;
  late String author;
  late String image;
  late String language;
  late List<String> category;
  late String published;

  News(
      {required this.id,
      required this.title,
      required this.description,
      required this.url,
      required this.author,
      required this.image,
      required this.language,
      required this.category,
      required this.published});

  News.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    url = json['url'];
    author = json['author'];
    image = json['image'];
    language = json['language'];
    category = json['category'].cast<String>();
    published = json['published'];
  }

  News.fromDb(Map<String, dynamic> dbToJson) {
    id = dbToJson['id'];
    title = dbToJson['title'];
    description = dbToJson['description'];
    url = dbToJson['url'];
    author = dbToJson['author'];
    image = dbToJson['image'];
    language = dbToJson['language'];
    category = jsonDecode(dbToJson['category']).cast<String>();
    published = dbToJson['published'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['url'] = this.url;
    data['author'] = this.author;
    data['image'] = this.image;
    data['language'] = this.language;
    data['category'] = jsonEncode(this.category);
    data['published'] = this.published;
    return data;
  }
}