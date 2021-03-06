import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import '../model/hero.dart';
import '../services/hero_service.dart';
import '../router/route_paths.dart';

import 'hero_search_component.dart';

@Component(
  selector: 'dashboard',
  templateUrl: 'dashboard_component.html',
  styleUrls: ['../../styles/global.css', 'dashboard_component.css'],
  directives: [coreDirectives, HeroSearchComponent, routerDirectives],
)
class DashboardComponent implements OnInit {
  List<Hero> heroes;

  final HeroService _heroService;

  DashboardComponent(this._heroService);

  @override
  void ngOnInit() async {
    heroes = (await _heroService.getTop()).take(4).toList();
  }

  String heroUrl(int id) => RoutePaths.hero.toUrl(parameters: {idParam: '$id'});
}
