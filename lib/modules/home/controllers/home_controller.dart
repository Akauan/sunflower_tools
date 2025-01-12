import 'package:get/get.dart';

class HomeController extends GetxController {
  // Authors List
  // RxList<AuthorModel> authors = <AuthorModel>[].obs;
  // List<AuthorModel> cachedList = [];
  RxBool showSearch = false.obs;
  RxBool searchEnabled = true.obs;

  // Clear the filter for show all the items of list
  clearFilter() {
    showSearch.value = true;
    // authors.assignAll(cachedList.toList());
  }
}
