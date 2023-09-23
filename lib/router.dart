import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kcc_race_client/pages/chat.dart';
import 'package:kcc_race_client/pages/details.dart';
import 'package:kcc_race_client/pages/top.dart';

part 'router.g.dart';

@TypedGoRoute<TopRoute>(
  path: '/',
)
class TopRoute extends GoRouteData {
  const TopRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const Top();
}

@TypedGoRoute<DetailsRoute>(
  path: '/details/:id',
)
class DetailsRoute extends GoRouteData {
  const DetailsRoute({required this.id});

  final int id;

  @override
  Widget build(BuildContext context, GoRouterState state) => Details(id: id);
}

@TypedGoRoute<ChatRoute>(
  path: '/chat',
)
class ChatRoute extends GoRouteData {
  const ChatRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const Chat();
}

final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: $appRoutes,
);
