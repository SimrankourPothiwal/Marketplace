# Order Object Definition

# Order
| Field            | Type | Definition |
|------------------|------------|-----|
| `order_id` | String | Unique order ID |
| `store_id` | String | Store ID |
| `source` | String | Order origination source |
| `status` | String | Current status of the order |
| `items` | Array | Array of [Items](#item) |
| `fee_items` | Array | Array of [Items](#item) |
| `promo_items` | Array | Array of [Items](#item) |
| `tax` | Integer | Total tax on the order in cents |
| `fee` | Integer | Total fee on the order in cents |
| `discount` | Integer | Total discounts on the order in cents |
| `subtotal` | Integer | Items total in cents (excluding fee and taxes) |
| `total` | Integer | Order total in cents |
| `payment` | Object | See [Payment](#payment) |
| `created` | Date | Order created timestamp | 
| `last_updated` | Date | Last updated timestamp |

### Item
| Field            | Type | Definition |
|------------------|------------|-----|
| `product_id` | String | Unique product ID |
| `name` | String | Name of the product |
| `desc` | String | Product description |
| `price` | Integer | Price in cents |
| `quantity` | Integer | Original quantity on the order |
| `available_quantity` | Integer | Quantity available at the store |
| `tax` | Integer | Total tax on the item |
| `available` | Boolean | `true` when available and `false` when unavailable
| `status` | String | - `pending` Yet to be fulfilled <br> - `preparing` Under preparation <br> - `complete` Packed / Prepared and its ready

### Payment
| Field            | Type | Definition |
|------------------|------------|-----|
| `type` | String | `card` | `Google Pay` | `Apple Pay`
| `brand` | String | `Visa`, `Mastercard`, etc.
| `tokenization_type` | String | `Stripe`, `Google Pay`, etc.
| `token` | String | One time payment token
| `amount` | Number | Amount to charge |
| `last4` | String | Last 4 digitals of the card (if applicable) |
| `exp_month` | String | Two digit month of expiry. Value range from `01` to `12`|
| `exp_year` | String | Four digit year value. Current year or greater.

### Shipping
| Field            | Type | Definition |
|------------------|------------|-----|
| `pickup` | Object | [Pickup Address](#address) |
| `dropoff` | Object | [Dropoff Address](#address) |

### Address
| Field            | Type | Definition |
|------------------|------------|-----|
| `street` | String | Street address |
| `apt` | String | Appartment number (optional) |
| `city` | String | City name |
| `state` | String | US state code |
| `zip` | String | US zip code |
| `notes` | String | Additional notes (optional) |

### User
| Field            | Type | Definition |
|------------------|------------|-----|
| `first_name` | String | User's first name |
| `last_name` | String | User's last name |
| `email` | String | User's email |
| `phone` | String | User's phone number |
