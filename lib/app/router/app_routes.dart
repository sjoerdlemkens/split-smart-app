import 'package:go_router/go_router.dart';
import 'package:split_smart_app/home/view/home_page.dart';
import 'package:split_smart_app/sign_in/view/sign_in_page.dart';
import 'package:split_smart_app/splash/view/splash_page.dart';

get appRoutes => [
      GoRoute(
        path: SplashPage.routePath,
        name: SplashPage.routeName,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: SignInPage.routePath,
        name: SignInPage.routeName,
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        path: HomePage.routePath,
        name: HomePage.routeName,
        builder: (context, state) => const HomePage(),
      ),
    ];
