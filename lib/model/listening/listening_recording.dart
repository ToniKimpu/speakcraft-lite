/// One user voice recording for a listening sentence. Stored locally now
/// (Drift + phone files via [ListeningRecordingRepository]): [audioPath] is the
/// on-device file path, played back directly. The `fromJson` factory is legacy
/// from the old Supabase backing and is no longer used.
class ListeningRecording {
  const ListeningRecording({
    required this.id,
    required this.listeningId,
    required this.sentenceId,
    required this.audioPath,
    this.createdAt,
  });

  final int id;
  final int listeningId;
  final String sentenceId;

  /// On-device file path to the recorded `.m4a`.
  final String audioPath;
  final DateTime? createdAt;

  factory ListeningRecording.fromJson(Map<String, dynamic> json) =>
      ListeningRecording(
        id: json['id'] as int,
        listeningId: json['listening_id'] as int,
        sentenceId: json['sentence_id'] as String,
        audioPath: json['audio_path'] as String,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.tryParse(json['created_at'] as String),
      );
}
