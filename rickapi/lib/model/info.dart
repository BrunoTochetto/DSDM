class Info {
  int count;
  int pages;
  String? next;
  String? prev;

  Info({
    required this.count,
    required this.pages,
    this.next,
    this.prev
  });

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      count: json['count'],
      pages: json['pages'],
      next: json['next'],
      prev: json['prev'],
      );
  }
}