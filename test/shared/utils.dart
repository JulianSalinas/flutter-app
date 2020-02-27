import 'package:flutter_test/flutter_test.dart';
import 'package:letsattend/shared/colors.dart';
import 'package:letsattend/shared/utils.dart';

void main() {

  group('Testing getInitials(text)', () {

    test('Empty string', () {
      expect(SharedUtils.getInitialsFrom(''), '#');
    });

    test('Null string', () {
      expect(SharedUtils.getInitialsFrom(null), '#');
    });

    test('String with just spaces', (){
      expect(SharedUtils.getInitialsFrom('  '), '#');
    });

    test('Single word string', (){
      expect(SharedUtils.getInitialsFrom('Julian'), 'J');
      expect(SharedUtils.getInitialsFrom('aquiles'), 'A');
    });

    test('Two words string', (){
      expect(SharedUtils.getInitialsFrom('Julian Salinas'), 'JS');
      expect(SharedUtils.getInitialsFrom('aquiles von stengel'), 'AV');
    });

  });

  group('Testing getColorFor(text, ui.colors)', () {

    var colors = [
      SharedColors.emerald,
      SharedColors.peterRiver,
      SharedColors.alizarin,
    ];

    test('Empty string', () {
      expect(SharedUtils.getColorFor('', colors), SharedColors.peterRiver);
    });

    test('Null string', () {
      print(SharedUtils.getColorFor(null, colors));
      expect(SharedUtils.getColorFor(null, colors), SharedColors.peterRiver);
    });

    test('Whatever string', () {
      expect(SharedUtils.getColorFor('Aquiles', colors), SharedColors.alizarin);
    });

  });

  group('Testing containsWord(word, content)', () {

    var content = 'Julian Salinas del Instituto Tecnológico';

    test('Empty string', () {
      expect(SharedUtils.containsFilter('', content), false);
    });

    test('Null string', () {
      expect(SharedUtils.containsFilter(null, content), false);
    });

    test('Whatever string', () {
      expect(SharedUtils.containsFilter('salinas', content), true);
    });

    test('Two searched strings', () {
      expect(SharedUtils.containsFilter('rojas  julian', content), true);
    });

    test('Not contained string', () {
      expect(SharedUtils.containsFilter('steven', content), false);
    });

  });

}