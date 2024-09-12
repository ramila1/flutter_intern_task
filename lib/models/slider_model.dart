// sliderModel class contains properties to store various details about a slider item,
/// such as the author's name, the item's title, description, URL, image URL, and content.
class sliderModel {
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? content;

  // The parameters author, title, description, url, urlToImage, and content
  // can be provided to initialize the respective properties of the slider item.
  sliderModel({
    this.author,
    this.content,
    this.description,
    this.title,
    this.url,
    this.urlToImage,
  });
}
