import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:people_repository/people_repository.dart';
import 'package:squadio_test/helpers/constants.dart';

import '../people.dart';

class PopularPeopleFrom extends StatefulWidget {
  const PopularPeopleFrom({Key? key}) : super(key: key);

  @override
  State<PopularPeopleFrom> createState() => _PopularPeopleFromState();
}

class _PopularPeopleFromState extends State<PopularPeopleFrom> {
  final PagingController<int, Person> _pagingController =
      PagingController<int, Person>(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener(
      (int pageKey) {
        context
            .read<PopularPeopleCubit>()
            .loadPopularPeople(page: pageKey, apiKey: apiKey);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('popularPeople'.tr()),
      ),
      body: BlocListener<PopularPeopleCubit, PopularPeopleState>(
        listener: (context, state) {
          if (state is PopularPeopleLoadSuccess) {
            if (state.isLastPage) {
              _pagingController.appendLastPage(state.newPersons);
            } else {
              final int nextPageKey = state.peoplePage.page + 1;
              _pagingController.appendPage(state.newPersons, nextPageKey);
            }
          }
          if (state is PopularPeopleLoadFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.error.toString()),
                ),
              );
          }
        },
        child: RefreshIndicator(
          onRefresh: () async {
            _pagingController.refresh();
          },
          child: PagedListView<int, Person>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Person>(
              itemBuilder: (BuildContext context, Person item, int index) {
                return PeopleCard(person: item);
              },
              noItemsFoundIndicatorBuilder: (BuildContext context) {
                return Center(
                  child: Text(
                    'notification.noNotifications'.tr(),
                    style: Theme.of(context).textTheme.headline2!.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                        ),
                  ),
                );
              },
              newPageProgressIndicatorBuilder: (BuildContext context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              firstPageProgressIndicatorBuilder: (BuildContext context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
