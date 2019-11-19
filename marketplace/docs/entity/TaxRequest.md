

# TaxRequest 
| Field            | Type | Definition |
|------------------|------------|-----|
| `store_id` | String | Store ID |
| `items` | Array | Array of [Items](#taxItem) |
| `store_details` | Object | See [Details] (#address) |
| `delivery_address_details` | Object | See [] (#address) |

# TaxItem
| Field            | Type | Definition |
|------------------|------------|-----|
| `product_id` | String | Product ID |
| `quantity` | Number | Number of items added to cart |
| `name` | String | Name of the product |
| `suiid` | String | Unique ID |
| `ipq` | Number | Number of packs in item |
| `price` | Number | Price of item in cents |
| `department_id` | String | Department ID  |
| `abv_liquor` | String | alcohol percent |
| `total_volume` | Number | total volumn in OZ |




# Address
| Field            | Type | Definition |
|------------------|------------|-----|
| `name` | String |  Name |
|  `street` | String |  street name |
| `city` | String | city |
| `state` | String | state |
| `country` | String | country |
| `zip` | String | zip code  |

