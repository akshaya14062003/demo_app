# Fix and "Undo" Broken Changes from Yesterday

Since the project is not using Git, a literal "undo" to the exact state of two days ago is not possible. However, I have identified the files modified yesterday and found the critical errors causing the "Application Not Responding" (ANR) issue.

## Proposed Changes

### [Navigation & Main Screens]

#### [MODIFY] [trending_product.dart](file:///C:/flutter/demo_app/lib/trending_product.dart)
- Remove the recursive `TrendingProduct()` call in the `AppBar` title.
- Replace it with a standard `Text` widget.

> [!IMPORTANT]
> This recursion is the primary cause of the app freezing.

#### [MODIFY] [resuable_bottom.dart](file:///C:/flutter/demo_app/lib/resuable_bottom.dart)
- Fix the `pages` list to correctly map to the icons in the bottom navigation bar:
    1.  Home -> `HomePage()`
    2.  Wishlist -> `FavoritePage()`
    3.  Cart -> `CartPage()` (currently `HomePage()`)
    4.  Searching -> `TrendingProduct()`
    5.  Profile -> `ProfilePage()` (currently `TrendingProduct()`)

### [Verification Plan]

#### Manual Verification
1.  Run the app and verify it no longer hangs on the Trending Products screen.
2.  Test all tabs in the bottom navigation bar to ensure they lead to the correct screens (Cart, Search, Profile, etc.).
