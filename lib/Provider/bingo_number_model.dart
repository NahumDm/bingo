class BingoCard {
  final int id;
  final List<int> b;
  final List<int> i;
  final List<int> n;
  final List<int> g;
  final List<int> o;

  BingoCard({
    required this.id,
    required this.b,
    required this.i,
    required this.n,
    required this.g,
    required this.o,
  });

  factory BingoCard.fromJson(Map<String, dynamic> json) {
    return BingoCard(
      id: json['id'],
      b: List<int>.from(json['B']),
      i: List<int>.from(json['I']),
      n: List<int>.from(json['N']),
      g: List<int>.from(json['G']),
      o: List<int>.from(json['O']),
    );
  }
}
