class Preview {
  
  final String url;
  final String title;
  final String thumbnail;
  final String description;

  Preview({
    this.url,
    this.title,
    this.thumbnail,
    this.description,
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
    return url != null && regex.hasMatch(url);
  }

  @override
  String toString() {
    return 'Preview{ url: $url }';
  }

}