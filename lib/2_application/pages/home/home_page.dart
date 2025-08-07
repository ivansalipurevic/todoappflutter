import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/1_domain/repositories/todo_repository.dart';
import 'package:todo_app/1_domain/use_cases/load_todo_entry_ids_for_collection.dart';
import 'package:todo_app/2_application/core/page_config.dart';
import 'package:todo_app/2_application/pages/create_todo_collection/create_todo_collection_page.dart';
import 'package:todo_app/2_application/pages/dashboard/dashboard_page.dart';
import 'package:todo_app/2_application/pages/detail/todo_detail_page.dart';
import 'package:todo_app/2_application/pages/home/bloc/navigation_todo_cubit.dart';
import 'package:todo_app/2_application/pages/home/component/login_button.dart';
import 'package:todo_app/2_application/pages/overview/overview_page.dart';
import 'package:todo_app/2_application/pages/settings/settings_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, required String tab})
      : index = tabs.indexWhere((element) => element.name == tab);

  static const PageConfig pageConfig = PageConfig(
    icon: Icons.home_rounded,
    name: 'home',
  );

  final int index;

  static final tabs = [
    PageConfig(
      icon: DashboardPage.pageConfig.icon,
      name: DashboardPage.pageConfig.name,
      child: DashboardPage(),
    ),
    PageConfig(
      icon: OverviewPage.pageConfig.icon,
      name: OverviewPage.pageConfig.name,
      child: OverviewPageProvider(),
    ),
  ];

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final List<NavigationDestination> destinations = HomePage.tabs
      .map((page) => NavigationDestination(icon: Icon(page.icon), label: page.name))
      .toList();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      floatingActionButton: Breakpoints.small.isActive(context)
          ? FloatingActionButton(
              onPressed: () async {
                final result = await context.pushNamed(
                  CreateTodoCollectionPage.pageConfig.name,
                );
                if (result == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Collection created successfully')),
                  );
                }
              },
              child: Icon(CreateTodoCollectionPage.pageConfig.icon),
              tooltip: 'Add collection',
            )
          : null,
      body: SafeArea(
        child: BlocListener<NavigationTodoCubit, NavigationTodoCubitState>(
          listenWhen: (previous, current) =>
              previous.isSecondBodyDisplayed != current.isSecondBodyDisplayed,
          listener: (context, state) {
            if (context.canPop() && (state.isSecondBodyDisplayed ?? false)) {
              context.pop();
            }
          },
          child: AdaptiveLayout(
            topNavigation: SlotLayout(
              config: <Breakpoint, SlotLayoutConfig>{
                Breakpoints.small: SlotLayout.from(
                  key: const Key('top-navigation-small'),
                  builder: (context) => const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [LoginButton()],
                  ),
                ),
              },
            ),
            primaryNavigation: SlotLayout(
              config: <Breakpoint, SlotLayoutConfig>{
                Breakpoints.mediumAndUp: SlotLayout.from(
                  key: const Key('primary-navigation-medium'),
                  builder: (context) => AdaptiveScaffold.standardNavigationRail(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          key: const Key('create-todo-collection'),
                          onPressed: () async {
                            final result = await context.pushNamed(
                              CreateTodoCollectionPage.pageConfig.name,
                            );
                            if (result == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Collection created successfully')),
                              );
                            }
                          },
                          icon: Icon(CreateTodoCollectionPage.pageConfig.icon),
                          tooltip: 'Add collection',
                        ),
                        const LoginButton(),
                      ],
                    ),
                    trailing: IconButton(
                      onPressed: () => context.pushNamed(SettingsPage.pageConfig.name),
                      icon: Icon(SettingsPage.pageConfig.icon),
                      tooltip: 'Settings',
                    ),
                    selectedLabelTextStyle: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                    selectedIconTheme: IconThemeData(
                      color: theme.colorScheme.primary,
                    ),
                    unselectedIconTheme: IconThemeData(
                      color: theme.colorScheme.onSurface.withAlpha(127),
                    ),
                    onDestinationSelected: (index) =>
                        _tapOnNavigationDestination(context, index),
                    selectedIndex: widget.index,
                    destinations: destinations
                        .map((e) => AdaptiveScaffold.toRailDestination(e))
                        .toList(),
                  ),
                ),
              },
            ),
            bottomNavigation: SlotLayout(
              config: <Breakpoint, SlotLayoutConfig>{
                Breakpoints.small: SlotLayout.from(
                  key: const Key('bottom-navigation-small'),
                  builder: (context) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const LoginButton(),
                      AdaptiveScaffold.standardBottomNavigationBar(
                        destinations: destinations,
                        currentIndex: widget.index,
                        onDestinationSelected: (index) =>
                            _tapOnNavigationDestination(context, index),
                      ),
                    ],
                  ),
                ),
              },
            ),
            body: SlotLayout(
              config: <Breakpoint, SlotLayoutConfig>{
                Breakpoints.smallAndUp: SlotLayout.from(
                  key: const Key('primary-body'),
                  builder: (_) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          HomePage.tabs[widget.index].name.toUpperCase(),
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      Expanded(child: HomePage.tabs[widget.index].child),
                    ],
                  ),
                ),
              },
            ),
            secondaryBody: SlotLayout(
              config: <Breakpoint, SlotLayoutConfig>{
                Breakpoints.mediumAndUp: SlotLayout.from(
                  key: const Key('secondary-body'),
                  builder: widget.index != 1
                      ? null
                      : (_) => BlocBuilder<NavigationTodoCubit, NavigationTodoCubitState>(
                            builder: (context, state) {
                              final selectedId = state.selectedCollectionId;
                              if (selectedId == null) {
                                return Center(
                                  child: Text(
                                    'Select a collection to view details',
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                );
                              }
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Text(
                                      'Details for: ${selectedId.value}',
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                  ),
                                  Expanded(
                                    child: TodoDetailPage(
                                      key: Key(selectedId.value),
                                      collectionId: selectedId,
                                      loadTodoEntryIdsForCollection: LoadTodoEntryIdsForCollection(
                                        todoRepository: RepositoryProvider.of<TodoRepository>(context),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                ),
              },
            ),
          ),
        ),
      ),
    );
  }

  void _tapOnNavigationDestination(BuildContext context, int index) {
    context.goNamed(
      HomePage.pageConfig.name,
      pathParameters: {'tab': HomePage.tabs[index].name},
    );
  }
}
