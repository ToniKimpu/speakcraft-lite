/// One user voice recording for a listening sentence, as stored in Supabase
/// (`public.listening_recordings`). The audio bytes live in the private
/// `user-recordings` Storage bucket at [audioPath]; playback uses a short-lived
/// signed URL fetched on demand (the bucket is not public).
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

  /// Storage object path within the `user-recordings` bucket.
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
