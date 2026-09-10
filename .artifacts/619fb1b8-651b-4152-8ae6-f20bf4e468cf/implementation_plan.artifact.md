# Implementation Plan - Fix Cart Functionality

Implement the missing `addToCart` logic in `ProductDetailScreen` and ensure the cart data is correctly displayed and updated across the app.

## User Review Required

> [!IMPORTANT]
> This plan focuses on fixing the immediate errors in `ProductDetailScreen` where the `addToCart` method is missing, and ensuring the UI updates correctly when items are added.

## Proposed Changes

### UI Layer

#### [MODIFY] [product_details.dart](file:///C:/flutter/demo_app/lib/product_details.dart)
- Define the `addToCart` method inside `_ProductDetailScreenState`.
- Update the `OutlinedButton` ("Go to cart") to call `goToCart()`.
- Update the `ElevatedButton` ("Add to Cart") to call `addToCart(product)`.
- Ensure `setState(() {})` is called after adding to cart to update the cart icon badge.
- Fix the `cartIcon` badge logic to correctly reflect `CartData.itemCount`.

### Data Layer

#### [MODIFY] [cart_data.dart](file:///C:/flutter/demo_app/lib/cart_data.dart)
- (Optional but recommended) Add a `print` or debug log to `addToCart` to verify it's working.

## Verification Plan

### Manual Verification
- Navigate to a product detail screen.
- Tap "Add to Cart".
- Verify the red badge on the shopping cart icon increases.
- Tap the cart icon to go to `CartPage`.
- Verify the added product is displayed in the list.
- Remove the product and verify the badge updates when returning.
