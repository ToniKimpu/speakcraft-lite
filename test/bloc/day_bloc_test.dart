import 'dart:async';
import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pmp_english/bloc/day/day_bloc.dart';
import 'package:pmp_english/model/day/day.dart';
import 'package:pmp_english/repositories/day/day_repository.dart';

class MockDayRepository extends Mock implements DayRepository {}

void main() {
  late MockDayRepository mockRepo;
  late DayBloc bloc;

  setUp(() {
    mockRepo = MockDayRepository();
    bloc = DayBloc(repository: mockRepo);
  });

  tearDown(() => bloc.close());

  group('DayBloc', () {
    group('loadDays', () {
      final fakeDays = [
        Day(
          id: 1,
          orderNumber: 1,
          createdAt: DateTime(2024),
          lessons: [],
          exercises: [],
          isComplete: false,
        ),
      ];

      blocTest<DayBloc, DayState>(
        'emits [loading, loaded] on success',
        build: () => bloc,
        setUp: () => when(() => mockRepo.loadDays())
            .thenAnswer((_) async => fakeDays),
        act: (b) => b.add(const DayEvent.loadDays()),
        expect: () => [
          const DayState.loading(),
          DayState.loaded(null, fakeDays),
        ],
      );

      blocTest<DayBloc, DayState>(
        'emits [loading, socketError] on SocketException',
        build: () => bloc,
        setUp: () => when(() => mockRepo.loadDays())
            .thenThrow(const SocketException('no connection')),
        act: (b) => b.add(const DayEvent.loadDays()),
        expect: () => [
          const DayState.loading(),
          const DayState.socketError(
              'Please check your internet connection and try again.'),
        ],
      );

      blocTest<DayBloc, DayState>(
        'emits [loading, socketError] on TimeoutException',
        build: () => bloc,
        setUp: () => when(() => mockRepo.loadDays())
            .thenThrow(TimeoutException('timeout')),
        act: (b) => b.add(const DayEvent.loadDays()),
        expect: () => [
          const DayState.loading(),
          const DayState.socketError(
              'Please check your internet connection and try again.'),
        ],
      );

      blocTest<DayBloc, DayState>(
        'emits [loading, error] on generic exception',
        build: () => bloc,
        setUp: () => when(() => mockRepo.loadDays())
            .thenThrow(Exception('something went wrong')),
        act: (b) => b.add(const DayEvent.loadDays()),
        expect: () => [
          const DayState.loading(),
          const DayState.error('Exception: something went wrong'),
        ],
      );
    });
  });
}
