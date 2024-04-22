import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:kurs_oop/services/services.dart';

import 'package:kurs_oop/utils/utils.dart';
import 'package:kurs_oop/core/constants.dart';
import 'package:kurs_oop/config/router/main_navigation.dart';
import 'package:kurs_oop/views/categories_screen/categories_screen.dart';

import 'package:get_it/get_it.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final _categoriesBloc = CategoriesScreenBloc();
  bool isDeletingMode = false;
  bool isDeletingChoose = false;
  List<int> selectedCategories = [];

  @override
  void initState() {
    _categoriesBloc.add(LoadCategoriesScreen());
    GetIt.I<AppRouter>().addListener(_routerListener);
    NotificationService().init(initScheduled: true);
    listenNotifications();

    super.initState();
  }

  void listenNotifications() => NotificationService()
      .onNotifications
      .stream
      .listen(onClickedNotifiactions);

  void onClickedNotifiactions(NotificationResponse payload) {
    Logger().debug(payload);
  }

  @override
  void dispose() {
    GetIt.I<AppRouter>().removeListener(_routerListener);
    super.dispose();
  }

  void _routerListener() {
    var route = GetIt.I<AppRouter>().current;
    if (route.name == 'CategoryRoute') {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double height = mediaQuery.size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Категории',
          style: TextStyle(
            fontSize: 26,
            fontFamily: fontApp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              GetIt.I<AppRouter>().push(const SettingsRoute());
            },
          ),
        ],
      ),
      body: BlocBuilder<CategoriesScreenBloc, CategoriesScreenState>(
        bloc: _categoriesBloc,
        builder: (context, state) {
          if (state is CategoriesScreenLoaded) {
            return isDeletingMode
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 50,
                              child: TextButton(
                                onPressed: () {
                                  deleteToggle();
                                  setState(() => selectedCategories.clear());
                                },
                                child: Text(
                                  'Отменить',
                                  style: TextStyle(
                                    color: AppColors.onBackground.withOpacity(
                                      0.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            isDeletingChoose
                                ? SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: IconButton(
                                      onPressed: () {
                                        CategoriesMethods().deleteCategories(
                                          selectedCategories:
                                              selectedCategories,
                                          bloc: _categoriesBloc,
                                        );
                                        setState(() {
                                          isDeletingMode = false;
                                          selectedCategories.clear();
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        size: 25,
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                        SizedBox(
                          height: height,
                          child: GridView.builder(
                            padding: const EdgeInsets.all(10),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1.0,
                            ),
                            itemCount: state.categoriesList.length,
                            itemBuilder: (context, index) {
                              return CategoryTileDeleting(
                                id: state.categoriesList[index].id,
                                title: state.categoriesList[index].title,
                                icon: CategoryIcons.allIcons[
                                    state.categoriesList[index].iconKey]!,
                                gradient: CategoryGradients.allGradients[
                                    state.categoriesList[index].gradientKey]!,
                                isDeletingMode: isDeletingMode,
                                selectedCategories: selectedCategories,
                                hasDeleteElements: hasDeleteElements,
                                deleteToggle: deleteToggle,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: state.categoriesList.length,
                    itemBuilder: (context, index) {
                      var category = state.categoriesList[index];
                      return CategoryTile(
                        id: category.id,
                        title: category.title,
                        icon: CategoryIcons.allIcons[category.iconKey]!,
                        gradient: CategoryGradients
                            .allGradients[category.gradientKey]!,
                        tasksList: category.tasks,
                        isDeletingMode: isDeletingMode,
                        deleteToggle: deleteToggle,
                      );
                    },
                  );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
            context: context,
            builder: (context) => AddCategoryDialog(bloc: _categoriesBloc),
          );
        },
        backgroundColor: AppColors.primary,
        child: const Icon(
          Icons.add,
          color: AppColors.highlight,
        ),
      ),
    );
  }

  deleteToggle() {
    setState(() => isDeletingMode = !isDeletingMode);
  }

  hasDeleteElements() {
    if (selectedCategories.isNotEmpty) {
      setState(() => isDeletingChoose = true);
    } else {
      setState(() => isDeletingChoose = false);
    }
  }
}
