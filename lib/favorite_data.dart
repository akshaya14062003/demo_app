class FavoriteData {
  static final List<Map<String, String>> favoriteProducts = [];

  static bool isFavorite(String productName) {
    return favoriteProducts.any(
          (product) => product["name"] == productName,
    );
  }

  static void addFavorite(Map<String, String> product) {
    if (!isFavorite(product["name"]!)) {
      favoriteProducts.add(product);
    }
  }
  static void removeFavorite(String productName) {
    favoriteProducts.removeWhere(
          (product) => product["name"] == productName,
    );
  }

  static void toggleFavorite(Map<String, String> product) {
    final productName = product["name"]!;

    if (isFavorite(productName)) {
      removeFavorite(productName);
    } else {
      addFavorite(product);
    }
  }
}