import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:split_smart_app/app/router/app_routes.dart';
import 'package:split_smart_app/app/util/stream_to_listenable.dart';
import 'package:split_smart_app/auth/bloc/auth_bloc.dart';
import 'package:split_smart_app/home/view/home_page.dart';
import 'package:split_smart_app/sign_in/view/sign_in_page.dart';
import 'package:split_smart_app/splash/splash.dart';

class AppRouter {
  /// Creates a GoRouter instance with the given auth bloc.
  static GoRouter createRouter(AuthBloc authBloc) => GoRouter(
        initialLocation: SplashPage.routePath,
        routes: appRoutes,
        //  Connect the auth bloc state changes to the router
        refreshListenable: StreamToListenable([authBloc.stream]),
        redirect: (context, state) => _onRedirect(context, state, authBloc),
      );

  /// Redirects the user to the appropriate page based on their authentication status.
  static String? _onRedirect(
    BuildContext context,
    GoRouterState state,
    AuthBloc authBloc,
  ) {
    final isAuthenticated = authBloc.state is AuthAuthenticated;
    final isUnAuthenticated = authBloc.state is AuthUnauthenticated;

    if (isUnAuthenticated &&
        !state.matchedLocation.contains(SignInPage.routePath)) {
      return SignInPage.routePath;
    } else if (isAuthenticated) {
      return HomePage.routePath;
    }
    return null;
  }
}
