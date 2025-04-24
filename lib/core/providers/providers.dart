import 'package:hotel_app/features/search/presentation/viewmodels/filter_viewmodel.dart';
import 'package:hotel_app/features/search/presentation/viewmodels/search_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class Providers {
  static final List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (context) => SearchViewmodel()),
    ChangeNotifierProvider(create: (context) => FilterViewmodel()),
  ];
}