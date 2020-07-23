import 'dart:html';

import 'package:dnd/dnd.dart';
import 'package:angular/angular.dart';

@Directive(selector: '[sm-drag]')
class DraggableDirective implements OnInit {
  Draggable draggable;
  Dropzone dropzone;
  Element el;
  DraggableDirective(this.el) {
    this.draggable = Draggable(
      el,
      avatarHandler: AvatarHandler.clone(),
      verticalOnly: true,
    );
    this.dropzone = Dropzone(el);
  }

  @override
  void ngOnInit() {
    dropzone.onDragOver.listen((DropzoneEvent event) {
      swap(event.draggableElement, event.dropzoneElement);
    });
    // dropzone.onDrop.listen((DropzoneEvent event) {
    //   swap(event.draggableElement, event.dropzoneElement);
    // });
  }

  void swap(Element elm1, Element elm2) {
    var parent1 = elm1.parent;
    var next1 = elm1.nextElementSibling;
    var parent2 = elm2.parent;
    var next2 = elm2.nextElementSibling;

    parent1.insertBefore(elm2, next1);
    parent2.insertBefore(elm1, next2);
  }
}
