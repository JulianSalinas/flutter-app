import 'package:flutter_test/flutter_test.dart';
import 'package:letsattend/shared/colors.dart';
import 'package:letsattend/shared/utils.dart';

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

    var colors = [SharedColors.emerald, SharedColors.peterRiver, SharedColors.alizarin];

    test('Empty string', () {
      expect(getColorFor('', colors), SharedColors.peterRiver);
    });

    test('Null string', () {
      print(getColorFor(null, colors));
      expect(getColorFor(null, colors), SharedColors.peterRiver);
    });

    test('Whatever string', () {
      expect(getColorFor('Aquiles', colors), SharedColors.alizarin);
    });

  });

  group('Testing containsWord(word, content)', () {

    var content = 'Julian Salinas del Instituto Tecnológico';

    test('Empty string', () {
      expect(containsFilter('', content), false);
    });

    test('Null string', () {
      expect(containsFilter(null, content), false);
    });

    test('Whatever string', () {
      expect(containsFilter('salinas', content), true);
    });

    test('Two searched strings', () {
      expect(containsFilter('rojas  julian', content), true);
    });

    test('Not contained string', () {
      expect(containsFilter('steven', content), false);
    });

  });

}