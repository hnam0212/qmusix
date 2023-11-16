import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:qmusix/widgets/next_video_list_widget.dart';
import 'package:qmusix/providers/theme_change_notifier.dart';
import 'package:qmusix/widgets/youtube_player_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qmusix'),
        centerTitle: false,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () => context.go("/register"),
                        child: Text(
                          "Register",
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                        ),
                      ),
                      const Text("|"),
                      TextButton(
                        onPressed: () => context.go("/login"),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SwitchListTile(
              title: const Text("Dark Mode"),
              value: Theme.of(context).brightness == Brightness.dark,
              onChanged: (value) => context
                  .read<ThemeChangeNotifier>()
                  .brightness = value ? Brightness.dark : Brightness.light,
            )
          ],
        ),
      ),
      body: LayoutBuilder(
        builder: (context, contraints) {
          if (contraints.maxWidth < 700) {
            return const VerticalView();
          } else {
            return const HorizontalView();
          }
        },
      ),
    );
  }
}

class HorizontalView extends StatelessWidget {
  const HorizontalView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.sizeOf(context).height * 10 / 100,
        horizontal: MediaQuery.sizeOf(context).height * 20 / 100,
      ),
      child: const Row(
        children: [
          Expanded(
            flex: 3,
            child: YoutubePlayerWidget(),
          ),
          Expanded(
            flex: 1,
            child: SizedBox.shrink(),
          ),
          Expanded(
            flex: 3,
            child: NextVideoListWidget(),
          ),
        ],
      ),
    );
  }
}

class VerticalView extends StatelessWidget {
  const VerticalView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        YoutubePlayerWidget(),
        Expanded(child: NextVideoListWidget()),
      ],
    );
  }
}
