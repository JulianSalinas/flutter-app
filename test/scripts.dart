import 'package:flutter_test/flutter_test.dart';
import 'package:letsattend/core/models/speaker.dart';
import 'package:letsattend/ui/colors.dart';
import 'package:letsattend/core/scripts.dart';

void main() {

  group('Testing getInitials(text)', () {

    test('Empty string', () {
      expect(getInitialsFrom(''), '#');
    });

    test('Null string', () {
      expect(getInitialsFrom(null), '#');
    });

    test('String with just spaces', (){
      expect(getInitialsFrom('  '), '#');
    });

    test('Single word string', (){
      expect(getInitialsFrom('Julian'), 'J');
      expect(getInitialsFrom('aquiles'), 'A');
    });

    test('Two words string', (){
      expect(getInitialsFrom('Julian Salinas'), 'JS');
      expect(getInitialsFrom('aquiles von stengel'), 'AV');
    });

  });

  group('Testing getColorFor(text, ui.colors)', () {

    var colors = [FlatUI.emerald, FlatUI.peterRiver, FlatUI.alizarin];

    test('Empty string', () {
      expect(getColorFor('', colors), FlatUI.peterRiver);
    });

    test('Null string', () {
      print(getColorFor(null, colors));
      expect(getColorFor(null, colors), FlatUI.peterRiver);
    });

    test('Whatever string', () {
      expect(getColorFor('Aquiles', colors), FlatUI.alizarin);
    });

  });

}