import 'dart:async';
import 'dart:html';

import 'package:dnd/dnd.dart';
import 'package:angular/angular.dart';

@Directive(selector: '[sm-drag]')
class DraggableDirective implements OnInit, AfterChanges {
  Draggable draggable;
  Dropzone dropzone;
  Element el;
  bool dragEnabled = false;
  String pointer;

  DraggableDirective(this.el);

  @HostListener('pointerdown')
  void checkDevice(PointerEvent e) {
    pointer = e.pointerType;
    if (pointer == "mouse") {
      dragToggle(true);
    } else {
      dragToggle(false);
    }
    e.preventDefault();
  }

  @HostListener('onTouchHold')
  void activateDraggable(PointerEvent e) {
    dragToggle(true);

    draggable.onDragEnd.listen((DraggableEvent event) {
      if (pointer != "mouse") dragToggle(false);
    });
  }

  @override
  void ngOnInit() {
    //dragEnabled ??= true;
    el.style.willChange = 'touchAction';
    el.draggable = this.dragEnabled;

    this.dropzone = Dropzone(el);

    this.draggable = Draggable(
      el,
      avatarHandler: AvatarHandler.clone(),
      verticalOnly: true,
    );

    dropzone.onDragOver.listen((DropzoneEvent event) {
      swap(event.draggableElement, event.dropzoneElement);
    });

    draggable?.onDrag?.listen((DraggableEvent event) {
      if (!dragEnabled) {
        draggable.abort();
      }
    });

    dropzone.onDrop.listen((DropzoneEvent event) {
      //  if(dragEnabled) {
      //   swap(event.draggableElement, event.dropzoneElement);
      // }
    });
  }

  @override
  void ngAfterChanges() {
    print("changed  $dragEnabled");
  }

  dragToggle(bool state) {
    print("changed  $dragEnabled");
    dragEnabled = state;
    if (state == false) {
      el.style.touchAction = 'manipulation';
      this.draggable.abort();
    } else {
      el.style.touchAction = 'none';
    }
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
