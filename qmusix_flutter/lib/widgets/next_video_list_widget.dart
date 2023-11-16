import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qmusix/models/youtube_model.dart';
import 'package:qmusix/repositories/app_repository.dart';

class NextVideoListWidget extends StatefulWidget {
  const NextVideoListWidget({
    super.key,
  });

  @override
  State<NextVideoListWidget> createState() => _NextVideoListWidgetState();
}

class _NextVideoListWidgetState extends State<NextVideoListWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.watch<AppRepository>().getYoutbeSearch("mck"),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.length ?? 0,
            itemBuilder: (context, index) {
              return NextVideoItem(youtubeModel: snapshot.data?[index]);
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }
}

class NextVideoItem extends StatelessWidget {
  final YoutubeModel? youtubeModel;
  const NextVideoItem({
    super.key,
    required this.youtubeModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Image.network(
            youtubeModel?.thumbnail ?? "",
          ),
          title: Text(youtubeModel?.title ?? "Title"),
          subtitle: Text(youtubeModel?.channelTitle ?? "Channel Title"),
        ),
        Row(
          children: [
            TextButton(
              onPressed: () {},
              child: const Text("Upvote"),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("Downvote"),
            ),
          ],
        )
      ],
    );
  }
}
