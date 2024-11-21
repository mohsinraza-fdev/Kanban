// test/services/preference_service_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_app/services/preference_service.dart';
import 'package:mockito/mockito.dart';

import '../test_helpers.mocks.dart';

void main() {
  late PreferenceService preferenceService;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    preferenceService = PreferenceService();
    preferenceService.instance = mockSharedPreferences;
  });

  group('PreferenceService -', () {
    group('activeProjectId -', () {
      test('should return null when no project ID is set', () {
        when(mockSharedPreferences.getString(PreferenceKeys.activeProjectId)).thenReturn(null);

        final result = preferenceService.activeProjectId;

        expect(result, isNull);
        verify(mockSharedPreferences.getString(PreferenceKeys.activeProjectId)).called(1);
      });

      test('should return project ID when one is set', () {
        const expectedId = 'test-project-id';
        when(mockSharedPreferences.getString(PreferenceKeys.activeProjectId)).thenReturn(expectedId);

        final result = preferenceService.activeProjectId;

        expect(result, equals(expectedId));
        verify(mockSharedPreferences.getString(PreferenceKeys.activeProjectId)).called(1);
      });
    });

    group('setActiveProjectId -', () {
      test('should store project ID successfully', () async {
        const projectId = 'test-project-id';
        when(mockSharedPreferences.setString(
          PreferenceKeys.activeProjectId,
          projectId,
        )).thenAnswer((_) async => true);

        final result = await preferenceService.setActiveProjectId(projectId);

        expect(result, isTrue);
        verify(mockSharedPreferences.setString(
          PreferenceKeys.activeProjectId,
          projectId,
        )).called(1);
      });

      test('should handle storage failure gracefully', () async {
        const projectId = 'test-project-id';
        when(mockSharedPreferences.setString(
          PreferenceKeys.activeProjectId,
          projectId,
        )).thenAnswer((_) async => false);

        final result = await preferenceService.setActiveProjectId(projectId);

        expect(result, isFalse);
        verify(mockSharedPreferences.setString(
          PreferenceKeys.activeProjectId,
          projectId,
        )).called(1);
      });
    });

    group('clear -', () {
      test('should clear all preferences successfully', () async {
        when(mockSharedPreferences.clear()).thenAnswer((_) async => true);

        final result = await preferenceService.clear();

        expect(result, isTrue);
        verify(mockSharedPreferences.clear()).called(1);
      });

      test('should handle clear failure gracefully', () async {
        when(mockSharedPreferences.clear()).thenAnswer((_) async => false);

        final result = await preferenceService.clear();

        expect(result, isFalse);
        verify(mockSharedPreferences.clear()).called(1);
      });
    });

    group('PreferenceKeys -', () {
      test('should have correct key for activeProjectId', () {
        expect(PreferenceKeys.activeProjectId, equals('active-project-id-key'));
      });
    });
  });
}
