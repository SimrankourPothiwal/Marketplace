# Store Object Definition

# Store
| Field            | Type | Definition |
|------------------|------------|-----|
| `store_id` | String | Unique store ID |
| `name` | String | Name of the store |
| `image` | String | store image url |
| `desc` | String | Description about the store |
| `latitude` | Number | latitude of store  |
| `longitude` | Number | longitude of store |
| `phone` | String | Store phone number |
| `email` | String | Store email |
| `status`| Boolean | `true` store online and `false` store offline |
| `address`| Object | See [ Store Address](#storeAddress)|
| `hours` | Object | See [Store Hours](#storeHours)|

### StoreAddress
| Field            | Type | Definition |
|------------------|------------|-----|
| `street` | String |  street name |
| `city` | String | city |
| `state` | String | state |
| `zip` | String | zip code  |
| `country` | String | country |

### StoreHours
| Field            | Type | Definition |
|------------------|------------|-----|
| `day` | String | Day index of the week|
| `hours` | Array | See [Hours](#hours)

### Hours
| Field            | Type | Definition |
|------------------|------------|-----|
| `start_time` | String | Store open time in HH:MM format |
| `end_time` | String | Store close time in HH:MM format |

# 
| Day            | DayIndex |
|------------------|------------|-----|
| `Monday` | `MON` |
| `Tuesday` | `TUE` |
| `Wednesday`| `WED`|
| `Thursday`| `THU` |
| `FRIDAY`| `FRI`|
| `SATURDAY` | `SAT`|
| `SUNDAY` | `SUN` |

