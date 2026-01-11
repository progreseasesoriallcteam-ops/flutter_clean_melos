import 'package:flutter_test/flutter_test.dart';

import 'package:api_client/api_client.dart';

void main() {
  test('ApiClient client getter throws if not initialized', () {
    expect(() => ApiClient.client, throwsA(isA<AssertionError>())); // Or similar error from Supabase if not init
  });
}
