import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';

@Directive(selector: '[onTouchHold]')
class OnTouchHoldDirective implements OnInit {
  /**
   * Trida implementujici dvojklik/dvojtap
   */

  Timer timer;
  Element el;
  List<Element> siblings;

  final _onTouchHoldController = StreamController<dynamic>();

  @Output()
  Stream<dynamic> get onTouchHold => _onTouchHoldController.stream;

  OnTouchHoldDirective(this.el) {
    el.style.userSelect = 'none';
  }

  @HostListener('pointerdown')
  void onTouchHoldLis(PointerEvent e) {
    if (e.pointerType == "touch") {
      if (timer == null) {
        // Stes the timeframe for the next interaction
        timer = Timer(Duration(milliseconds: 500), () {
          // Disables select and double tap zoom on the target element
          _onTouchHoldController.add(e);
          //el.style.touchAction = 'none';
          el.style.transform = 'scale(1.1,1.1)';
          el.style.transform = 'rotate(30deg)';
          timer = null;
        });
      }
      e.preventDefault();
    } else {
      cancelTimer();
    }
  }

  @HostListener('pointerup')
  void pointerUp() {
    cancelTimer();
  }

  @HostListener('pointerleave')
  void pointerLeave() {
    cancelTimer();
  }

  @HostListener('pointercancel')
  void pointerCancel() {
    cancelTimer();
  }

  @HostListener('pointerout')
  void pointerOut() {
    cancelTimer();
  }

  cancelTimer() {
    el.style.transform = 'scale(1,1)';
    timer?.cancel();
    timer = null;
  }

  @override
  void ngOnInit() {}
}
