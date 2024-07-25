import 'package:flutter/cupertino.dart';

import '../models/quotes_model.dart';

class MainProvider extends ChangeNotifier {
  late Future<List<QuotesModel>> getLikedqoute;
  late List<QuotesModel> DModel;
}
