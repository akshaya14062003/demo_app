# Implementation Plan - Cart Details and App Bar Badge

The user wants to display the cart item count in the app bar and show product details (like size) on the cart page.

## User Review Required

> [!IMPORTANT]
> Since `CustomAppBar` is used across multiple screens (`HomePage`, `TrendingProduct`), adding a cart badge there will affect the entire app's navigation header. I will ensure it looks consistent with the existing design.

## Proposed Changes

### Cart Data & Details

#### [MODIFY] [product_details.dart](file:///C:/flutter/demo_app/lib/product_details.dart)
- Update `addToCart` to include the `selectedSize` in the map sent to `CartData`.

#### [MODIFY] [cart_page.dart](file:///C:/flutter/demo_app/lib/cart_page.dart)
- Update the item builder to display the "Size" property from the product map.

### Global App Bar Update

#### [MODIFY] [custom_appbar.dart](file:///C:/flutter/demo_app/lib/custom_appbar.dart)
- Add a cart icon with a numeric badge.
- The badge will display `CartData.itemCount` if it's greater than zero.
- Clicking the icon will navigate to the `CartPage`.

#### [MODIFY] [home_page.dart](file:///C:/flutter/demo_app/lib/home_page.dart)
- Ensure navigation to `ProductDetailScreen` instead of `ShopScreen` (if applicable) or ensure the badge updates when returning from the cart.

#### [MODIFY] [trending_product.dart](file:///C:/flutter/demo_app/lib/trending_product.dart)
- Update `productCard` to navigate to `ProductDetailScreen`.
- Ensure the screen rebuilds when returning from navigation to update the app bar badge.

## Verification Plan

### Manual Verification
1. Open a product, select a size, and click "Add to Cart".
2. Observe the badge count incrementing in the `ProductDetailScreen` app bar.
3. Navigate to `CartPage` and verify "Size: [Selected Size]" is visible.
4. Go to `HomePage` or `TrendingProduct` and verify the badge shows the same count.
5. Add another item from `TrendingProduct` (after wiring up the navigation) and verify the badge updates globally.
