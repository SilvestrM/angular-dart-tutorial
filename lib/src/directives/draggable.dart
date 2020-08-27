import 'dart:async';
import 'dart:html';

import 'package:dnd/dnd.dart';
import 'package:angular/angular.dart';

@Directive(selector: '[sm-drag]')
class DraggableDirective implements OnInit {
  Draggable draggable;
  Dropzone dropzone;
  Element el;
  bool dragEnabled;
  String pointer;

  DraggableDirective(this.el);

  @HostListener('pointerover')
  void checkDevice(PointerEvent e) {
    pointer = e.pointerType;
    if(pointer == "mouse") {
      dragEnabled ??= true;
    } else {
      dragEnabled ??= false;
    }
    e.preventDefault();
  }

  @HostListener('onTouchHold') 
  void activateDraggable(PointerEvent e) {
    dragEnabled = true;

    draggable.onDragEnd.listen((DraggableEvent event) {
      if(pointer != "mouse")
        dragEnabled = false;
    });
  }

  @override
  void ngOnInit() {
    dragEnabled ??= false;
    this.draggable = Draggable(
      el,
      avatarHandler: AvatarHandler.clone(),
      verticalOnly: true,
    );
  
    this.dropzone = Dropzone(el);
 
    dropzone.onDragOver.listen((DropzoneEvent event) {
        swap(event.draggableElement, event.dropzoneElement);
    });

    draggable.onDrag.listen((DraggableEvent event) {
       if(!dragEnabled) {
         draggable.abort();
       }    
    });

    
    dropzone.onDrop.listen((DropzoneEvent event) {
       if(dragEnabled) {
        swap(event.draggableElement, event.dropzoneElement);
      }
    });
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
