# Implementation Plan - Redesign Product Detail Screen

The goal is to redesign the `ProductDetailScreen` to match the provided screenshot, incorporating new UI components, refined styling, and a "Similar To" section.

## User Review Required

> [!IMPORTANT]
> The action buttons ("Go to cart" and "Buy Now") and the delivery info box are currently scrolling elements in this plan. If you want them pinned to the bottom (always visible), please let me know.

## Proposed Changes

### Product Detail Screen Component

#### [MODIFY] [product_details.dart](file:///C:/flutter/demo_app/lib/product_details.dart)

- **AppBar & Image Section**:
    - Transparent AppBar with circular back and cart icons.
    - Image section with a "Next" arrow button and dot indicators.
- **Product Information**:
    - Update **Size** selector style: Pink border, pink background for selected, white text for selected, pink text for unselected.
    - Update **Price** layout: Original Price (strikethrough), Current Price (bold), Discount % (pink).
    - Refine **Product Details** with a "...More" suffix.
- **New Feature Sections**:
    - **Store/Service Info**: A row containing "Nearest Store", "VIP", and "Return policy" tags with icons.
    - **Action Buttons**:
        - Refactor `customCartButton` to support multiple colors/gradients.
        - Add a green gradient "Buy Now" button with a hand icon.
    - **Comparison Row**: "View Similar" and "Add to Compare" buttons.
    - **Similar Products Section**:
        - "Similar To" header with item count.
        - "Sort" and "Filter" buttons.
        - A grid (`MasonryGridView`) displaying similar product cards.
- **Styling**:
    - Update global colors (e.g., using a specific pink/red shade for buttons and highlights).
    - Update the **Delivery** box to be larger with bold "1 within Hour" text.

## Verification Plan

### Manual Verification
- Verify that the image indicators and arrow layout match the screenshot.
- Ensure the size selection styling correctly toggles between states.
- Check that the action buttons (Blue/Green) and the Comparison row align correctly.
- Verify the "Similar To" section displays product cards in a staggered grid.
