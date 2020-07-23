import 'dart:html';

import 'package:angular/angular.dart';

@Directive(selector: 'sm-draggable')
class DraggableDirective {
  Element el;
  DraggableDirective(Element el) {}
}
