// ArticleModel class contains properties to store various details about an article such as
// the author's name, the article's title, description, URL, image URL, and content.

class ArticleModel {
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? content;

  // The parameters author, title, description, url, urlToImage, and content
  // can be provided to initialize the respective properties of the article.

  ArticleModel({
    this.author,
    this.content,
    this.description,
    this.title,
    this.url,
    this.urlToImage,
  });
}
