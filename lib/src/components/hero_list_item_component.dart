import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:dnd/dnd.dart';

import '../model/hero.dart';

import '../services/hero_service.dart';

@Component(
  selector: 'hero-item',
  templateUrl: 'hero_list_item_component.html',
  directives: [coreDirectives, formDirectives],
  styleUrls: ['../../styles/global.css', 'hero_list_component.css'],
  providers: [ClassProvider(HeroService)],
  pipes: [commonPipes],
)
class HeroListItemComponent {
  @Input()
  Hero hero;

  bool selected = false;
  int editMode = null;

  //services
  final HeroService _heroService;

  HeroListItemComponent(this._heroService);

  Future<void> save(Hero hero, dynamic newName, dynamic isTop) async {
    print(isTop);
    editMode = null;
    hero.name = newName;
    hero.top = isTop;

    await _heroService.update(hero);
  }

  Future<void> add(String name) async {
    name = name.trim();
    if (name.isEmpty) return null;
    selected = null;
  }

  Future<void> delete(Hero hero) async {
    await _heroService.delete(hero.id);
    if (selected == hero) selected = null;
  }
}
