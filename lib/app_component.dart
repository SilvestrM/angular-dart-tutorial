import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'src/services/hero_service.dart';
import 'src/components/hero_list_component.dart';

import 'src/router/routes.dart';

@Component(
    selector: 'my-app',
    templateUrl: 'app_component.html',
    directives: [coreDirectives, routerDirectives, HeroListComponent],
    styleUrls: ['./styles/global.css', 'app_component.css'],
    providers: [ClassProvider(HeroService)],
    exports: [RoutePaths, Routes])
class AppComponent {
  final title = 'Tour of Heroes';

  //services

}
