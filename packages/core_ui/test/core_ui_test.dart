import 'package:flutter_test/flutter_test.dart';

import 'package:core_ui/core_ui.dart';

void main() {
  test('AppColors primary is defined', () {
    expect(AppColors.primary.toARGB32(), 0xFFD32F2F);
  });

  test('AppColors spaceGradient has 3 colors', () {
    expect(AppColors.spaceGradient.length, 3);
  });
}
