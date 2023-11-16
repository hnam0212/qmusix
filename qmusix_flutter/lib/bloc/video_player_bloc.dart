import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

part 'video_player_event.dart';
part 'video_player_state.dart';

class VideoPlayerBloc extends Bloc<VideoPlayerEvent, VideoPlayerState> {
  VideoPlayerBloc() : super(VideoPlayerInitial()) {
    on<VideoPlayerEvent>((event, emit) {});
    on<PlayVideo>((event, emit) async {});
    on<UpdateDuration>((event, emit) async {
      duration = event.duration;
    });
  }

  double duration = 0;
}
