import 'dart:math';

class SizeUtil {
  double _width, _height;
  static const double wmul = 0.001, hmul = 0.00075;
  double factor;

  SizeUtil(this._height, this._width) {
    factor = min<double>(_width * wmul, _height * hmul);
  }

  double size(double s) {
    return s * factor;
  }

  double widthPercent(double percent) {
    return _width * percent / 100;
  }

  double heightPercent(double percent) {
    return _height * percent / 100;
  }
}
