import 'package:flutter_test/flutter_test.dart';
import 'package:unit_converter_app/providers/converter_provider.dart';

void main() {
  test('25 meters is 0.025 kilometers', () {
    final converter = ConverterProvider();
    expect(converter.result, closeTo(0.025, 0.000001));
    expect(converter.resultText, '0.025 km');
  });

  test('10 kilometers is 10000 meters', () {
    final converter = ConverterProvider();
    converter.changeInput('10');
    converter.swapUnits();
    expect(converter.resultText, '10000 m');
  });

  test('Gram and kilogram conversion works both ways', () {
    final converter = ConverterProvider();
    converter.changeCategory('Weight');
    converter.changeInput('500');
    expect(converter.resultText, '0.5 kg');
    converter.changeInput('2');
    converter.swapUnits();
    expect(converter.resultText, '2000 g');
  });

  test('Celsius and Fahrenheit conversion works both ways', () {
    final converter = ConverterProvider();
    converter.changeCategory('Temperature');
    converter.changeInput('100');
    expect(converter.resultText, '212 °F');
    converter.changeInput('32');
    converter.swapUnits();
    expect(converter.resultText, '0 °C');
  });

  test('Negative temperature and same-unit conversion work', () {
    final converter = ConverterProvider();
    converter.changeCategory('Temperature');
    converter.changeInput('-40');
    expect(converter.resultText, '-40 °F');
    converter.changeToUnit('Celsius');
    expect(converter.resultText, '-40 °C');
  });

  test('Empty and invalid input show a dash', () {
    final converter = ConverterProvider();
    converter.changeInput('');
    expect(converter.resultText, '—');
    converter.changeInput('hello');
    expect(converter.resultText, '—');
  });
}
