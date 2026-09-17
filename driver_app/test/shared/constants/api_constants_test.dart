import 'package:driver_app/shared/constants/api_constants.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('uses the configured API base URL', () {
    const expected = String.fromEnvironment(
      'EXPECTED_API_BASE_URL',
      defaultValue: 'http://localhost:8000',
    );
    expect(ApiConstants.baseUrl, expected);
  });
}
