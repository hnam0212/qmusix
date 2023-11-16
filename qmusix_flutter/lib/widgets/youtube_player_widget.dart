import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qmusix/bloc/video_player_bloc.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubePlayerWidget extends StatefulWidget {
  const YoutubePlayerWidget({super.key});

  @override
  State<YoutubePlayerWidget> createState() => _YoutubePlayerWidgetState();
}

class _YoutubePlayerWidgetState extends State<YoutubePlayerWidget> {
  static final controller = YoutubePlayerController.fromVideoId(
    videoId: "FA1ZSkBeRSw",
    autoPlay: true,
    startSeconds: 50,
    params: const YoutubePlayerParams(
      showControls: false,
      pointerEvents: PointerEvents.none,
    ),
  );

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    controller.currentTime.then(
        (value) => context.read<VideoPlayerBloc>().add(UpdateDuration(value)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        YoutubePlayer(
          controller: controller,
          aspectRatio: 16 / 9,
        ),
        IconButton(
          icon: const Icon(Icons.volume_mute),
          onPressed: () async {
            await controller.isMuted.then((isMuted) {
              if (isMuted) {
                controller.unMute();
              } else {
                controller.mute();
              }
            });
          },
        ),
      ],
    );
  }
}
