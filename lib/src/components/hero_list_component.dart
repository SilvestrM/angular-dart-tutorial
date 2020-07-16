import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import '../model/hero.dart';

import '../router/route_paths.dart';
import '../services/hero_service.dart';

@Component(
  selector: 'hero-list',
  templateUrl: 'hero_list_component.html',
  directives: [coreDirectives],
  styleUrls: ['../../styles/global.css', 'hero_list_component.css'],
  providers: [ClassProvider(HeroService)],
  pipes: [commonPipes],
)
class HeroListComponent implements OnInit {
  Hero selected;
  final Router _router;

  List<Hero> heroes;

  //services
  final HeroService _heroService;

  HeroListComponent(this._heroService, this._router);

  void onSelect(Hero hero) => selected = hero;

  String _heroUrl(int id) =>
      RoutePaths.hero.toUrl(parameters: {idParam: '$id'});

  Future<NavigationResult> gotoDetail() =>
      _router.navigate(_heroUrl(selected.id));

  void _getHeroes() async {
    heroes = await _heroService.getAll();
  }

  @override
  void ngOnInit() {
    _getHeroes();
  }
}
