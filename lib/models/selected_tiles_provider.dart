import 'package:flutter/foundation.dart';

import '../models/tile_model.dart';

class SelectedTilesProvider with ChangeNotifier {
  List<tile> _selectedTiles = [];

  List<tile> get selectedTiles => _selectedTiles;

  void addSelectedTile(tile tile) {
    _selectedTiles.add(tile);
    notifyListeners();
  }

  void removeSelectedTile(tile tile) {
    _selectedTiles.remove(tile);
    notifyListeners();
  }

  void clearSelectedTiles() {
    _selectedTiles.clear();
    notifyListeners();
  }
}
