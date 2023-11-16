import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qmusix/pages/homepage.dart';
import 'package:qmusix/pages/login_page.dart';
import 'package:qmusix/pages/register_page.dart';

class AppRouter {
  static const homePath = '/home';
  static const loginPath = '/login';
  static const registerPath = '/register';
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static get router {
    return GoRouter(
      navigatorKey: navigatorKey,
      routes: [
        GoRoute(
          path: "/",
          redirect: (context, state) => homePath,
        ),
        GoRoute(
          path: homePath,
          pageBuilder: (context, state) => WebPage(
            pageKey: state.pageKey,
            page: const HomePage(),
          ),
        ),
        GoRoute(
          path: loginPath,
          pageBuilder: (context, state) => WebPage(
            pageKey: state.pageKey,
            page: const LoginPage(),
          ),
        ),
        GoRoute(
          path: registerPath,
          pageBuilder: (context, state) => WebPage(
            pageKey: state.pageKey,
            page: const RegisterPage(),
          ),
        ),
      ],
    );
  }
}

class WebPage extends CustomTransitionPage {
  final Widget page;
  final LocalKey pageKey;

  WebPage({
    required this.pageKey,
    required this.page,
  }) : super(
          key: pageKey,
          child: page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
}
