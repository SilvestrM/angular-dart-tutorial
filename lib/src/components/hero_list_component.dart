import 'dart:html';

import 'package:angular/angular.dart';
import 'package:angular_forms/angular_forms.dart';
import 'package:angular_router/angular_router.dart';
import 'package:dnd/dnd.dart';

import '../model/hero.dart';

import '../router/route_paths.dart';
import '../services/hero_service.dart';

@Component(
  selector: 'hero-list',
  templateUrl: 'hero_list_component.html',
  directives: [
    coreDirectives,
    formDirectives,
  ],
  styleUrls: ['../../styles/global.css', 'hero_list_component.css'],
  providers: [ClassProvider(HeroService)],
  pipes: [commonPipes],
)
class HeroListComponent implements OnInit, AfterViewInit {
  Hero selected;
  int editMode = null;

  @ViewChildren('draggableItem')
  List<Element> draggables;

  List<Hero> heroes;
  List<Hero> topHeroes;

  //services
  final Router _router;
  final HeroService _heroService;

  HeroListComponent(this._heroService, this._router);

  //DnD

  @override
  void ngOnInit() {
    _getHeroes();
  }

  @override
  void ngAfterViewInit() {
    print(draggables);
    Draggable draggable =
        Draggable(draggables, avatarHandler: AvatarHandler.original());
    Dropzone dropzone = Dropzone(draggables);
    draggable.onDragStart.listen((event) {
      print('start');
    });
    dropzone.onDrop.listen((DropzoneEvent event) {
      swap(event.draggableElement, event.dropzoneElement);
    });
  }

  void swap(Element elm1, Element elm2) {
    print('test');
    var parent1 = elm1.parent;
    var next1 = elm1.nextElementSibling;
    var parent2 = elm2.parent;
    var next2 = elm2.nextElementSibling;

    parent1.insertBefore(elm2, next1);
    parent2.insertBefore(elm1, next2);
  }

  void onSelect(Hero hero) {
    selected = hero;
    editMode = null;
  }

  String _heroUrl(int id) =>
      RoutePaths.hero.toUrl(parameters: {idParam: '$id'});

  Future<NavigationResult> gotoDetail() =>
      _router.navigate(_heroUrl(selected.id));

  void _getHeroes() async {
    heroes = await _heroService.getAll();
    topHeroes = await _heroService.getTop();
  }

  Future<void> save(Hero hero, dynamic newName, dynamic isTop) async {
    editMode = null;
    hero.name = newName;
    hero.top = isTop;

    await _heroService.update(hero);
    _getHeroes();
  }

  Future<void> add(String name) async {
    name = name.trim();
    if (name.isEmpty) return null;
    heroes.add(await _heroService.create(name));
    selected = null;
  }

  Future<void> delete(Hero hero) async {
    await _heroService.delete(hero.id);
    heroes.remove(hero);
    if (selected == hero) selected = null;
  }
}
