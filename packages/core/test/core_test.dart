import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AppConfig.development has correct values', () {
    const config = AppConfig.development;
    expect(config.environment, AppEnvironment.development);
    expect(config.isDevelopment, isTrue);
  });
}
