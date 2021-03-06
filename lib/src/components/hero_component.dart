import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';

import '../model/hero.dart';

import '../services/hero_service.dart';
import '../router/route_paths.dart';

@Component(
  selector: 'my-hero',
  templateUrl: 'hero_component.html',
  styleUrls: ['../../styles/global.css', 'hero_component.css'],
  directives: [coreDirectives, formDirectives],
)
class HeroComponent implements OnActivate {
  Hero hero;
  List<Hero> topHeroes;

  final HeroService _heroService;
  final Location _location;
  HeroComponent(this._heroService, this._location);

  @override
  void onActivate(_, RouterState current) async {
    final id = getId(current.parameters);
    if (id != null) hero = await _heroService.get(id);
    topHeroes = await _heroService.getTop();
  }

  int getId(Map<String, String> parameters) {
    final id = parameters[idParam];
    return id == null ? null : int.tryParse(id);
  }

  void goBack() => _location.back();

  Future<void> save() async {
    await _heroService.update(hero);
    goBack();
  }
}
