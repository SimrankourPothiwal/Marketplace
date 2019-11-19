## 7NOW API changes

### Place Order changes
- API should accept & process requests without shipping, user and payment information
- Update schema to include source of order
- If source is `doordash` or `postmates` no need to place a delivery order with 3PL.
- Update device enum to include marketplace

### Order Status Update changes
- API will invoke market-place api on order status change events
- Mock the payment data (if it is not provided ) to insert into order-payment details to make sure transaction  will success.
- Ignore coustomer notifications if order is from market place

 - New Status
   - `complete` - For `doordash` and `postmates` order `out_for_delivery` = `complete`

 - `submitted`
   - No change
 - `in_progress`
   - No delivery order placement for `doordash` and `postmates`
 - `ready`
   - No fund capture for `doordash` and `postmates`
   - No notifications to user
 - out_for_delivery
   - For `doordash` and `postmates` order `out_for_delivery` = `complete`
 - delivered
   - Not applicable for `doordash` and `postmates` orders
 - cancel
 - returned
   - ???


