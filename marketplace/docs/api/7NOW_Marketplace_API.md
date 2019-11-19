# 7NOW Marketplace API

## Authorization API
To access service endpoints, authorize using `client_id` and `client_secret` to get a temporary `access_token` .
All marketplace end points need access token except below auth endpoint.

### POST /auth
### Request

```json
{
     "client_id": "", // provided by 7-Eleven
     "client_secret": "", // provided by 7-Eleven
     "grant_type": "client_credentials",

}
```

### Response

```json
{
    "refresh_token_expires_in" : "0",
    "api_product_list" : "[store,order]",
    "api_product_list_json" : [ "store", "order" ],
    "organization_name" : "seveneleven",
    "developer.email" : "developer@doordash.com",
    "token_type" : "BearerToken",
    "issued_at" : "1568388709590",
    "client_id" : "oZ1P3cTCYDOZZxyYY9KdB21JGn0nGrbL",
    "access_token" : "wRV87uhORzlgtKIL8QEAMlA77tqZ", //Pass this access_token on Authorization header
    "application_name" : "f47585a9-86ff-4016-bb4e-fe4f63c4c821",
    "scope" : "doordash",
    "expires_in" : "86400",
    "refresh_count" : "0",
    "status" : "approved"
}
```

## Order API
See [Order Schema](#order-schema) for Order Object definition.

### POST /v1/order
Checkout and place an order. See supported `actions` and corresponding request / response below.

#### Available actions
| Action     | Description                                                                    | Request data                           | Response data                            |
| ---------- | ------------------------------------------------------------------------------ | -------------------------------------- | ---------------------------------------- |
| `verify`   | Order payload verification. No tax or order generated                          | [Verify Request](#verify-request)      | [Verify Response](#verify-response)      |
| `checkout` | Items and store availability verified. Tax and Total produced in the response. | [Checkout Request](#checkout-request)  | [Checkout Response](#checkout-response)  |
| `submit`   | Place an order. Order ID is generated.                                         | [Order Request](#order-submit-request) | [Order-Response](#order-submit-response) |
| `cancel`   | Cancel previously placed order. Not allowed after an order is accepted         | [Cancel Request](#cancel-request)      | [Cancel Response](#cancel-response)      |

#### Verify Request
```json
{
    "action":"verify",
    "source": "doordash",
    "data":{
        "store_id":"12202", //Unique store Id
        "items":[
            {
                "item_id":"10001-0-1", // Unique item id
                "price": 199, //price in cents
                "qty": 4 // Number of items,
            }
        ]
    }
}
```

#### Verify Response
```json
{
    "action": "verify",
    "status": "success | failed",
    "source": "doordash",
    "message": {},//Message object in case of any error
    "data":{
        "store_id":"12202",
        "items":[
            {
                "item_id":"10001-0-1",
                "price": 199, //price in cents
                "qty": 4// Number of items,

            }
        ]
    }
}
```

#### Checkout Request
```json
{
    "action":"checkout",
    "source": "doordash",
    "data":{
        "store_id":"12202", // store ID
        "items":[
            {
                "item_id":"171367-1-8", // item id
                "name": "Large Whole Pizza - Pepperoni",
                "price": 700, //price in cents
                "qty": 2 // Number of items,
            },
            {
                "item_id": "174261-1-8", // item id
                "name": "Large Whole Pizza - Triple Cheese",
                "price": 700, //price in cents
                "qty": 2 // Number of items,
            }
        ]
    }
}
```

#### Checkout Response

```json
{
    "action": "checkout",
    "status": "success | failed",
    "source": "doordash",
    "message": {},//See Message Schema
    "checkout_hash": "", //Optional during order submit
    "checkout_time": "2019-09-09T22:00:00.000Z",
    "data":{
        "store_id":"12202",
        "items":[
            {
                "item_id":"10001-0-1",
                "price": 199, //price in cents
                "qty": 2,// Number of items,
                "tax": 130, //tax on the item
                "available": true
            },
            {
                "item_id": "174261-1-8", // item id
                "name": "Large Whole Pizza - Triple Cheese",
                "price": 700, //price in cents
                "qty": 2, // Number of items
                "tax": 130, //tax on the item
                "available": false,
                "availability_message": "Out-of-Stock"
            }
        ],
        "fee_items":[ // This is sent if any additional fees like basket fee, bag fee, etc.
            {
                "item_id": "fee item id",
                "price": 199, //price in cents
                "qty": 4, // Number of items
                "tax": 0 //tax on fee item if applicable
            }
        ],
        "tax": 160, // Tax on the order
        "subtotal": 2800, //sum of all items
        "total": 2960
    }
}
```

#### Order Submit Request
```json
{
    "action": "submit",
    "source": "doordash",
    "checkout_hash": "", //Optional during order submit
    "checkout_time": "2019-09-09T22:00:00.000Z",
    "data": { //Checkout Response data
        "store_id":"Store ID",
        "items":[
            {
                "item_id": "item id",
                "price": 199, //price in cents
                "qty": 4, // Number of items,
                "tax":4 //tax on the item
            }
        ],
        "fee_items":[ // This is sent if any additional fees like basket fee,
            {
                "item_id":" item id",
                "price": 199, //price in cents
                "qty": 4,// Number of items,
                "tax":4 //tax on the item
            }
        ],
        "tax": 234, // Tax on the order
        "subtotal": 345, //sum of all items
        "total": 579
    }
}
```

#### Order Submit Response

```json
{
    "action": "submit",
    "source": "doordash",
    "status": "success | failed",
    "message": {},//See Message Schema
    "data":{
        "order_id":"Unique order ID",
        "created":"Creation data",
        "store_id":"Store ID",
        "status":"Order status",
        "items":[
            {
                "item_id":" item id",
                "price": 199, //price in cents
                "qty": 4,// Number of items,
                "tax":4 //tax on the item

            }
        ],
        "fee_items":[
            // This is send if any additional fees like basket fee,
            {
                "item_id":" item id",
                "price": 199, //price in cents
                "qty": 4,// Number of items,
                "tax":4 //tax on the item

            }
        ],
        "tax": 234, // Tax on the order
        "subtotal": 345, //sum of all items
        "total": 579 // sum of subtotal + tax,
    }
}
```

#### Cancel Request

```json
{
    "action": "cancel",
    "source": "doordash",
    "data":{
        "order_id": "order id"
    }
}
```

#### Cancel Response

```json
{
    "action": "cancel",
    "status": "success | failed",
    "source": "doordash",
    "message": {
        "code": "O404",
        "message": "Order already processed"
    },//See Message Schema
    "data":{
        "order_id": "Unique order ID",
        "status": "Order status",

    }
}
```

### GET /v1/order?limit=10&status=submitted&store_id=12345
Query for orders

| Parameter Name | Value Definition                                                            |
| -------------- | --------------------------------------------------------------------------- |
| `limit`        | Number of orders to return. Default 10. Max 100.                            |
| `status`       | Comma separated list of status to filter. See [Order Status](#order-status) |
| `store_id`     | Store ID                                                                    |

### GET /v1/order/{order_id}
Get a single order details using its order id

#### Response

| HTTP Code | Definition                             |
| --------- | -------------------------------------- |
| 200       | Success [Order Details](#order-schema) |

## Store API

### Store Details
### GET /v1/store/{store_id}
Get store details

#### Response

| HTTP Code | Definition                                      |
| --------- | ----------------------------------------------- |
| 200       | Success, returns [Store Details](#store-schema) |

``` json
{
  "store_id": "string",
  "name": "string",
  "active": true,
  "latitude": 0,
  "longitude": 0,
  "telephone": "string",
  "image": "string",
  "address": {
    "street": "string",
    "city": "string",
    "state": "string",
    "country": "string",
    "zip": "string"
  },
  "opening_hours": [

    {
        "day_index":"MON",  
        "start_time": "0600",
        "end_time": "2230"
    },
    {
        "day_index":"TUE",  
        "start_time": "0600",
        "end_time": "2230"
    }  
    // etc. for all the days of the week
  ]
}
```

### Store Menu
### GET /v1/store/{store_id}/menu
Get full menu of the store. An item may appear in more than one category.

#### Response

| HTTP Code | Definition                                         |
| --------- | -------------------------------------------------- |
| 200       | Success , returns Array of [Categories](#category) |

``` Json
{
    "categories": [
        {
            "category_id": "string",
            "category_name": "string",
            "popularity": 1,
            "image": "url to image",
            "items": [{
                // Array of all items in category, see item schema
            }]
        }
    ]
}
```
### GET /v1/store/{store_id}/menu?item_id=1,2,3
Get latest information of a set of items at a store

#### Response

| HTTP Code | Definition                               |
| --------- | ---------------------------------------- |
| 200       | Success , returns array of [Item](#item) |

```json
{
    "items": [
        {
        "item_id": "string",
        "store_id": "string",
        "name": "string",
        "desc": "string",
        "price": 0,
        "image": "string",
        "popularity": 0,
        "available": true,
        "handling": "Hot",
        "min_age": 0,
        "ingredients": "string",
        "nutrition_info": {}
        }
    ]
}
```

## Webhooks
Register your webhook end points to notify on item, store and order events.

See [Order Events](/docs/events/Events.md#order-events) for Order Events.

See [Item Events](/docs/events/Events.md#item-events) for Order Events.

### Register Webhook
### PUT and PATCH /v1/webhook
Full webhook setup (replace) for a given source. To selectively update certain webhooks

#### Request
```Json
{
    "source": "doordash",
    "webhooks" :[
        {
            "type":"menu | store | order",
            "event": "menu_refresh | menu_item_status | store_status | order_status | order_item_status",
            "method":"POST|GET",
            "url":"url to invoke"
        }
    ]
}
```
#### Response

| HTTP Code | Definition |
| --------- | ---------- |
| 200       | Success    |

### Store Menu Refresh Event
The `menu_refresh` type event is used to trigger a store menu refresh.
```json
{
    "created": "2019-09-20T12:23:00Z",
    "type": "menu",
    "event": "menu_refresh",
    "data": {
        "request_id": "", //A unique request id
        "store_id": "12345", // store requiring its menu refreshed
        "webhook_url": "https://api.7-eleven.com/partners/now/webhook" // Callback URL to publish refresh job status updates
    }
}
```

### Menu Refresh Job Status Update Event
Job status event to be received on the callback / webhook URL provided in the request
```json
{
    "created": "2019-09-20T12:23:00Z",
    "type": "menu",
    "event": "menu_refresh_status",
    "data": {
        "request_id": "",
        "status": "received | in_progress | complete | failed",
        "store_id": "12345"
    }
}
```

### Menu Item Status Event
The `menu_item_status` event is used to update item availability
```Json
{
    "created": "2019-09-20T12:23:00Z",
    "type" : "menu",
    "event": "menu_item_status",
    "data": {
        "items" :[
            {
                "store_id": "12202",
                "item_id": "1000325-0-1",
                "available" : true | false
            }
        ] 
    }
}
```
### Store Status Event
The `store_status` event is used to update store online / offline status
```Json
{
    "created": "2019-09-20T12:23:00Z",
    "type" : "store",
    "event": "store_status",
    "data": {
        "stores" :[
            {
                "store_id": "12202",
                "active" : true | false,
                "reason": "Maintenance",
                "operating_hours": {
                    "MON": [{
                        "start_time": "0600",
                        "end_time": "2330"
                    }],
                    "TUE": [{
                        "start_time": "0600",
                        "end_time": "2330"
                    },{
                        "start_time": "0000",
                        "end_time": "0300"
                    }]
                } // if any changes in operating hours
            }
        ] 
    }
}
```
### Order Status Event
``` Json
{
    "created": "2019-09-20T12:23:00Z",
    "type" : "order",
    "event": "order_status",
    "data": {
        "order_id": "12344567",
        "status" : "submitted | accepted | in_progress | ready | complete | canceled | rejected",
        "reason" : " " // If any cancelation reason will sent out
    }
}
```
### Order Item Status Event
```json
{
    "created": "2019-09-20T12:23:00Z",
    "type" : "order",
    "event" : "order_item_status",
    "data": {
        "order_id": "12345677",
        "item_id": "1000325-0-1",
        "status" : "canceled | complete"
    }
}
```

## Schema Definitions
### Order Schema

| Field          | Type    | Definition                                                |
| -------------- | ------- | --------------------------------------------------------- |
| `order_id`     | String  | Unique order ID                                           |
| `store_id`     | String  | Store ID                                                  |
| `source`       | String  | Order origination source                                  |
| `status`       | String  | Current status of the order [Order Status](#order-status) |
| `items`        | Array   | Array of [Order Item](#order-item)                        |
| `fee_items`    | Array   | Array of [Order Item](#order-item)                        |
| `promo_items`  | Array   | Array of [Order Item](#order-item)                        |
| `tax`          | Integer | Total tax on the order in cents                           |
| `discount`     | Integer | Total discounts on the order in cents                     |
| `subtotal`     | Integer | Items total in cents (excluding fee and taxes)            |
| `total`        | Integer | Order total in cents                                      |
| `created`      | Date    | Order created timestamp                                   |
| `last_updated` | Date    | Last updated timestamp                                    |

### Order Item
| Field      | Type    | Definition                     |
| ---------- | ------- | ------------------------------ |
| `item_id`  | String  | Unique item ID                 |
| `name`     | String  | Name of item                   |
| `price`    | Integer | Price in cents                 |
| `quantity` | Integer | Original quantity on the order |
| `tax`      | Integer | Tax on the item                |

### Order Response
| Field     | Type   | Definition                                  |
| --------- | ------ | ------------------------------------------- |
| `status`  | String | `success`                                   | `failed`. Read `message` object when failed. |
| `message` | Object | See [ Message Codes](#error-message-object) |
| `order`   | Object | See [Order Schema](#order-schema)           |

### Store Schema
| Field             | Type    | Description                                                      |
| ----------------- | ------- | ---------------------------------------------------------------- |
| `store_id`        | String  | Store Id                                                         |
| `name`            | String  | Name of the store                                                |
| `active`          | Boolean | `true` - store is available , `false` - store is not available   |
| `latitude`        | Number  | The latitude of a location                                       |
| `longitude`       | Number  | The longitude of a location                                      |
| `telephone`       | String  | The telephone number                                             |
| `image`           | String  | Store image url                                                  |
| `address`         | Object  | Store address details , see [Address](#address)                  |
| `operating_hours` | Array  | Store operation hours, see [Hours](#hours), `null` if it is 24/7 |

### Address
| Field     | Type   | Description                             |
| --------- | ------ | --------------------------------------- |
| `street`  | String | Street name                             |
| `city`    | String | City name                               |
| `state`   | String | Short of the state (ex: `TX` for Texas) |
| `country` | String | Short form of country name (ex: `US`)   |
| `zip`     | String | zip code                                |

### Hours
`null` if store is open 24/7.
``` Json
[
    {
        "day_index":"MON",
        "start_time":"06:00",
        "end_time":"23:30"
    },
    {
        "day_index":"TUE",
        "start_time":"06:00",
        "end_time":"23:30"
    }
]
 ```

### Category
| Field           | Type   | Description                   |
| --------------- | ------ | ----------------------------- |
| `category_id`   | String | Unique id of category         |
| `category_name` | String | Category name                 |
| `popularity`    | Number | Sorting order of the category |
| `image`         | String | Category image URL            |
| `items`         | Array  | Array of [Items](#item)       |

### Item
| Field            | Type    | Definition                                              |
| ---------------- | ------- | ------------------------------------------------------- |
| `item_id`        | String  | Unique item ID                                          |
| `store_id`       | String  | Store ID                                                |
| `name`           | String  | Name of the item                                        |
| `desc`           | String  | Item description                                        |
| `price`          | Integer | Price in cents                                          |
| `image`          | String  | Image Url                                               |
| `popularity`     | Number  | ranking of item to display                              |
| `available`      | Boolean | `true` when available and `false` when unavailable      |
| `handling`       | String  | Hot or Cold                                             |
| `min_age`        | Integer | Qualifying minimum age                                  |
| `ingredients`    | String  | Item ingredients information                            |
| `nutrition_info` | Object  | See [Nutritional Information](#nutritional-information) |

### Nutritional Information

```json
{
    "servingSize": [
        {
            "name": "Servings Per Container",
            "value": "3.5"
        },
        {
            "name": "Serving Size",
            "value": "about 21 pieces (28g)"
        }
    ],
    "calories": [
        {
            "name": "Calories",
            "value": "160"
        }
    ],
    "fat": [
        {
            "name": "Total Fat",
            "value": "10g"
        },
        {
            "name": "Saturated Fat",
            "value": "1.5g"
        },
        {
            "name": "Trans Fat",
            "value": "0g"
        }
    ],
    "cholesterol": [
        {
            "name": "Cholesterol",
            "value": "0mg"
        }
    ],
    "sodium": [
        {
            "name": "Sodium",
            "value": "250mg"
        }
    ],
    "potassium": [
        {
            "name": "Potassium",
            "value": "53mg"
        }
    ],
    "carbs": [
        {
            "name": "Total Carbohydrate",
            "value": "15g"
        },
        {
            "name": "Dietary Fiber",
            "value": "<1g"
        }
    ],
    "protein": [
        {
            "name": "Protein",
            "value": "2g"
        }
    ],
    "vitamin": [
        {
            "name": "Vitamin D",
            "value": "0%"
        },
        {
            "name": "Calcium",
            "value": "0%"
        },
        {
            "name": "Iron",
            "value": "2%"
        }
    ],
    "contains": [
        {
            "name": "Milk",
            "value": "true"
        },
        {
            "name": "Gluten Free",
            "value": "true"
        }
    ]
}
```

## Error Message and Codes definitions

### Error Message Object
The `message` will appear only when `status` = `failure`

```json
{
    "code": "O205",
    "message": "One of more items unavailable"
}
```

| code | message                         |
| ---- | ------------------------------- |
| O400 | Invalid request format          |
| O401 | One or more items unavailable   |
| O402 | Store is down                   |
| O403 | One or more items price changed |
| O404 | Order already processed         |

### Http Status Codes

| HTTP Code | Definition            |
| --------- | --------------------- |
| 200       | Successful Response   |
| 400       | Bad Request           |
| 401       | Unauthorized          |
| 403       | Forbidden             |
| 500       | Internal server error |
| 503       | Service unavailable   |

## Order Status
- submitted
- rejected
- accepted
- in_progress
- ready
- out_for_delivery
- complete
- canceled

## Order State Transition

Successful flow of order
> submitted > accepted > in_progress > ready > complete

Unable to accept an order
> submitted > rejected

Canceled by user or support before `in_progress`
> submitted > accepted > canceled

Canceled by store
> submitted > accepted > canceled

