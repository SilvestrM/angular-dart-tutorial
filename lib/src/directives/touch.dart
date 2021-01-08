import 'dart:async';
import 'dart:html';

import 'package:angular/angular.dart';

@Directive(selector: '[onDoubleTap]')
class OnDoubleTapDirective {
  /**
   * Trida implementujici dvojklik/dvojtap
   */

  Timer timer;
  Element el;

  final _onDoubleTapController = StreamController<dynamic>();

  @Output()
  Stream<dynamic> get onDoubleTap => _onDoubleTapController.stream;

  OnDoubleTapDirective(this.el);

  @HostListener('pointerdown')
  void onDoubleTapLis(e) {
    if (timer == null) {
      // Stes the timeframe for the next interaction
      timer = Timer(Duration(milliseconds: 300), () {
        timer = null;
      });
    } else {
      timer?.cancel();
      timer = null;
      _onDoubleTapController.add(e);
    }

    //e.preventDefault();
  }
}
