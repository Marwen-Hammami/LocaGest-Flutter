import '../models/Signalement.dart';

class WaitingTimeStats {
  Duration minTime = Duration(days: 365); // Set to a large value initially
  Duration maxTime = Duration(days: 0); // Set to zero initially
  Duration totalWaitingTime = Duration();
  int numberOfSignalements = 0;

  void updateStats(Duration waitingTime) {
    if (waitingTime < minTime) {
      minTime = waitingTime;
    }
    if (waitingTime > maxTime) {
      maxTime = waitingTime;
    }
    totalWaitingTime += waitingTime;
    numberOfSignalements++;
  }

  Duration get averageWaitingTime {
    if (numberOfSignalements == 0) {
      return Duration(); // Avoid division by zero
    }
    return totalWaitingTime ~/ numberOfSignalements;
  }
}

WaitingTimeStats calculateWaitingTimeStats(List<Signalement> signalements) {
  final stats = WaitingTimeStats();

  for (final signalement in signalements) {
    final waitingTime = signalement.updatedAt.difference(signalement.createdAt);
    stats.updateStats(waitingTime);
  }

  return stats;
}
