## Payment Object Defination

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


