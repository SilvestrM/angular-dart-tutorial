import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_app/app_component.template.dart' as ng;

import 'main.template.dart' as self;

@GenerateInjector(
  routerProvidersHash,
)
final InjectorFactory rootInjector = self.rootInjector$Injector;
void main() {
  runApp(ng.AppComponentNgFactory, createInjector: rootInjector);
}
