import 'package:flutter/material.dart';
import 'package:sunflower_tools/modules/home/screens/home_screen.dart';
import 'package:sunflower_tools/modules/login/screens/login_page_screen.dart';
import 'package:sunflower_tools/modules/login/screens/splash_screen.dart';

class Routes {
  Routes();
  // Static variable to store the inital route of the app
  String initialRoute = '/initialPage';

  // Map relating the keys (routes) to it's values (Pages)
  Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>{
    // Route to the initial Spash Page
    '/initialPage': (context) => const SplashScreen(),
    '/loginPage': (context) => const LoginPageScreen(),
    '/homePage': (context) => const HomePage(),

    // '/booksCardListPage': (context) => const BooksCardList(),
    // '/booksListPage': (context) => const BookList(),
    // '/bookDetailPage': (context) {
    //   final args = ModalRoute.of(context)!.settings.arguments as BookModel;
    //   return BookDetail(
    //     bookArg: args,
    //   );
    // },
    // '/authorsListPage': (context) => const AuthorList(),
    // '/authorFormPage': (context) {
    //   final arguments = ModalRoute.of(context)!.settings.arguments as String?;
    //   AuthorModel? author;
    //   if (arguments != null) {
    //     author = AuthorModel.fromJson(jsonDecode(arguments));
    //   }
    //   return AuthorFormPage(
    //     author: author,
    //   );
    // },
    // '/publisherListpage': (context) => const PublisherList(),
    // '/publisherFormPage': (context) {
    //   final arguments = ModalRoute.of(context)!.settings.arguments as String?;
    //   PublisherModel? publisher;
    //   if (arguments != null) {
    //     publisher = PublisherModel.fromJson(jsonDecode(arguments));
    //   }
    //   return PublisherFormPage(
    //     publisher: publisher,
    //   );
    // },
    // '/homePage': (context) => const HomePage(),
    // '/inventoryListPage': (context) {
    //   final inventoyArgs =
    //       ModalRoute.of(context)!.settings.arguments as BookModel;
    //   return InventoryList(
    //     bookArg: inventoyArgs,
    //   );
    // },
  };
}
