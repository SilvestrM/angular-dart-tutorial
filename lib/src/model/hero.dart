class Hero {
  final int id;
  String name;
  bool top;

  Hero(this.id, this.name, this.top);

  factory Hero.fromJson(Map<String, dynamic> hero) =>
      Hero(_toInt(hero['id']), hero['name'], hero['top']);

  Map toJson() => {'id': id, 'name': name, 'top': top};
}

int _toInt(id) => id is int ? id : int.parse(id);
