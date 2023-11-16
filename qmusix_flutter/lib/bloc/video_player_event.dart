part of 'video_player_bloc.dart';

sealed class VideoPlayerEvent {}

class PlayVideo extends VideoPlayerEvent {}

class UpdateDuration extends VideoPlayerEvent {
  final double duration;

  UpdateDuration(this.duration);
}
