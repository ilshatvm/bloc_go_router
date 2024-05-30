import 'package:bloc_go_router/app/app.dart';
import 'package:bloc_go_router/router/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  final _defaultNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'default');

  AppRouter({required this.bloc});

  final AppBloc bloc;

  GoRouter get router => _router;

  late final GoRouter _router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppPAGES.home.path,
    restorationScopeId: 'router',
    refreshListenable: GoRouterRefreshStream(bloc.stream),
    redirect: (context, state) {
      final bool loggedIn = bloc.state == const AppState.authenticated();
      final bool loggingIn = state.matchedLocation == AppPAGES.login.path;

      if (!loggedIn) {
        return AppPAGES.login.path;
      }
      if (loggingIn) {
        return AppPAGES.home.path;
      }

      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: AppPAGES.login.path,
        name: AppPAGES.login.name,
        pageBuilder: (BuildContext context, GoRouterState state) =>
            MaterialPage<void>(
          restorationId: 'screenLogin',
          child: AppPAGES.login.page,
        ),
      ),
      StatefulShellRoute.indexedStack(
        restorationScopeId: 'shell1',
        pageBuilder: (context, state, navigationShell) {
          return MaterialPage<void>(
            restorationId: 'shellWidget1',
            child: ScaffoldWithNavBar(navigationShell: navigationShell),
          );
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            navigatorKey: _defaultNavigatorKey,
            restorationScopeId: 'branchHome',
            routes: <RouteBase>[
              GoRoute(
                path: AppPAGES.home.path,
                name: AppPAGES.home.name,
                pageBuilder: (BuildContext context, GoRouterState state) =>
                    MaterialPage<void>(
                  restorationId: 'screenHome',
                  child: AppPAGES.home.page,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            restorationScopeId: 'branchSettings',
            routes: <RouteBase>[
              GoRoute(
                path: AppPAGES.settings.path,
                name: AppPAGES.settings.name,
                pageBuilder: (BuildContext context, GoRouterState state) =>
                    MaterialPage<void>(
                  restorationId: 'screenSettings',
                  child: AppPAGES.settings.page,
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

class RootScreen extends StatelessWidget {
  const RootScreen({
    required this.label,
    required this.detailsPath,
    super.key,
  });

  /// The label
  final String label;

  /// The path to the detail page
  final String detailsPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Root of section $label'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Screen $label',
                style: Theme.of(context).textTheme.titleLarge),
            const Padding(padding: EdgeInsets.all(4)),
            TextButton(
              onPressed: () {
                GoRouter.of(context).go(detailsPath);
              },
              child: const Text('View details'),
            ),
          ],
        ),
      ),
    );
  }
}

/// The details screen for either the A or B screen.
class DetailsScreen extends StatefulWidget {
  /// Constructs a [DetailsScreen].
  const DetailsScreen({
    required this.label,
    super.key,
  });

  /// The label to display in the center of the screen.
  final String label;

  @override
  State<StatefulWidget> createState() => DetailsScreenState();
}

/// The state for DetailsScreen
class DetailsScreenState extends State<DetailsScreen> with RestorationMixin {
  final RestorableInt _counter = RestorableInt(0);

  @override
  String? get restorationId => 'DetailsScreen-${widget.label}';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_counter, 'counter');
  }

  @override
  void dispose() {
    super.dispose();
    _counter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Screen - ${widget.label}'),
      ),
      body: _build(context),
    );
  }

  Widget _build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Details for ${widget.label} - Counter: ${_counter.value}',
              style: Theme.of(context).textTheme.titleLarge),
          const Padding(padding: EdgeInsets.all(4)),
          TextButton(
            onPressed: () {
              setState(() {
                _counter.value++;
              });
            },
            child: const Text('Increment counter'),
          ),
          const Padding(padding: EdgeInsets.all(8)),
        ],
      ),
    );
  }
}
