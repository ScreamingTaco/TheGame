import 'package:flutter/material.dart';
import "dart:math";

final _random = new Random();

class ColorDuo{
  Color color1;
  Color color2;

  List<Color> toList() { //helper function for use with gradients
    return [color1, color2]..shuffle();
  }

  ColorDuo(color1, color2) {
    this.color1 = color1;
    this.color2 = color2;
  }

}

List<ColorDuo> colorDuos = [
  ColorDuo(Colors.blue, Colors.green),
  ColorDuo(Colors.blue, Colors.lime),
  ColorDuo(Colors.blue, Colors.pink),
  ColorDuo(Colors.deepPurple, Colors.orange),
  ColorDuo(Colors.deepPurple, Colors.red),
  ColorDuo(Colors.deepPurple, Colors.cyan),
  ColorDuo(Colors.pink, Colors.purple),
  ColorDuo(Colors.pink, Colors.yellow),
];

List<Color> randomColor() {
  return colorDuos[_random.nextInt(colorDuos.length)].toList(); 
}