import '../model/hero.dart';
import '../mock_heroes.dart';

class HeroService {
  Future<List<Hero>> getAll() async => mockHeroes;
  Future<Hero> get(int id) async {
    return (await getAll()).firstWhere((hero) => hero.id == id);
  }

  Future<List<Hero>> getAllSlowly() {
    return Future.delayed(Duration(seconds: 2), getAll);
  }
}
