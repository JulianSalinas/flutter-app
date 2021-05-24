class Preview {
  
  final String url;
  final String title;
  final String thumbnail;
  final String description;

  Preview({
    required this.url,
    required this.title,
    required this.thumbnail,
    required this.description,
  });

  @override
  int get hashCode => url.hashCode;

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is Preview && url == other.url;
  }

  bool isImage() {
    final exp = r"(http(s?):)([/|.|\w|\s|-])*\.(?:jpg|gif|png)";
    final regex = new RegExp(exp);
    return regex.hasMatch(url);
  }

  @override
  String toString() {
    return 'Preview{ url: $url }';
  }

}