import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_intern_task/models/article_model.dart';

void main() {
  test('ArticleModel should create an instance with given properties', () {
    // Create an instance of ArticleModel with some test data
    final article = ArticleModel(
      author: 'Ramila Kumari Shahi',
      title: 'Flutter Testing',
      description: 'A comprehensive guide to Flutter testing.',
      url: 'https://example.com/flutter-testing',
      urlToImage: 'https://example.com/image.png',
      content: 'This is the content of the article.',
    );

    // Verify that the properties are correctly set
    expect(article.author, 'Ramila Kumari Shahi');
    expect(article.title, 'Flutter Testing');
    expect(article.description, 'A comprehensive guide to Flutter testing.');
    expect(article.url, 'https://example.com/flutter-testing');
    expect(article.urlToImage, 'https://example.com/image.png');
    expect(article.content, 'This is the content of the article.');
  });

  test('ArticleModel should allow null properties', () {
    // Create an instance of ArticleModel with null properties
    final article = ArticleModel();

    // Verify that all properties are null
    expect(article.author, null);
    expect(article.title, null);
    expect(article.description, null);
    expect(article.url, null);
    expect(article.urlToImage, null);
    expect(article.content, null);
  });
}
