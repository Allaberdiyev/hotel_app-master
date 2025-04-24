import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hotel_app/features/search/presentation/viewmodels/filter_viewmodel.dart';
import 'package:hotel_app/features/search/presentation/viewmodels/search_viewmodel.dart';
import 'package:hotel_app/features/search/presentation/views/widgets/search_delegate.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewmodel = context.watch<SearchViewmodel>();
    final filterViewModel = context.watch<FilterViewmodel>();

    if (viewmodel.isLoading) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "loading".tr(context: context),
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.search, size: 25, color: Colors.black),
            onPressed: () async {
              showSearch(context: context, delegate: SearchViewDelegate());
            },
          ),
        ],
      ),
    );
  }
}
