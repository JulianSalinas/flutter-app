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

  @override
  String toString() {
    return 'Preview{ url: $url }';
  }

}