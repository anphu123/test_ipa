# Order Purchase Widgets

This directory contains all the widget components for the Order Purchase module, organized for better maintainability and reusability.

## Widget Structure

### Main Components

1. **OrderMapWidget** (`order_map_widget.dart`)
   - Displays Google Maps with customer location marker
   - Handles map initialization and configuration
   - Shows customer address on map

2. **OrderBottomSheet** (`order_bottom_sheet.dart`)
   - Main container for the draggable bottom sheet
   - Contains all order information sections
   - Handles scrolling and drag functionality

3. **BottomButtonWidget** (`bottom_button_widget.dart`)
   - Confirmation button with loading state
   - Fixed at bottom of screen
   - Handles order confirmation action

### Information Sections

4. **SellerInfoWidget** (`seller_info_widget.dart`)
   - Customer/seller information display
   - Action buttons (Chat, Call, Location)
   - Rating display

5. **ProductInfoWidget** (`product_info_widget.dart`)
   - Product details and image
   - Product name and price display
   - Compact product information card

6. **PickupInfoWidget** (`pickup_info_widget.dart`)
   - Pickup time information
   - Time and date display with icon

7. **OrderStatusWidget** (`order_status_widget.dart`)
   - Order status timeline
   - Progress indicators
   - Status step visualization

8. **PromotionBannerWidget** (`promotion_banner_widget.dart`)
   - Promotional banner display
   - Voucher information
   - Gradient background design

9. **OrderDetailsWidget** (`order_details_widget.dart`)
   - Detailed product specifications
   - Price breakdown and calculations
   - Payment information

10. **ContactInfoWidget** (`contact_info_widget.dart`)
    - Customer contact details
    - Address and phone information
    - Contact summary display

## Benefits of This Structure

### 1. **Maintainability**
- Each widget has a single responsibility
- Easy to locate and modify specific components
- Reduced code complexity in main view

### 2. **Reusability**
- Widgets can be reused in other parts of the app
- Consistent UI components across modules
- Easy to create variations of existing widgets

### 3. **Testability**
- Individual widgets can be tested in isolation
- Easier to write unit tests for specific components
- Better test coverage

### 4. **Team Collaboration**
- Multiple developers can work on different widgets simultaneously
- Clear separation of concerns
- Easier code reviews

### 5. **Performance**
- Smaller widget rebuilds
- Better widget tree optimization
- Reduced unnecessary rebuilds

## Usage Example

```dart
// In the main view
body: Stack(
  children: [
    const OrderMapWidget(),
    DraggableScrollableSheet(
      builder: (context, scrollController) {
        return OrderBottomSheet(scrollController: scrollController);
      },
    ),
  ],
),
bottomNavigationBar: const BottomButtonWidget(),
```

## Widget Dependencies

All widgets extend `GetView<OrderPurchaseController>` to access the controller and maintain reactive state management with GetX.

## Styling

All widgets use consistent styling from:
- `AppColors` for color scheme
- `AppTypography` for text styles  
- `ScreenUtil` for responsive sizing
