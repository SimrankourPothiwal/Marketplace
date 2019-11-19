## On this page

- [7NOW Marketplace API](#7now-marketplace-api)
  - [Folder structure](#folder-structure)
  - [File descriptions](#file-descriptions)
- [MenuItemSchema Vendor Comparison](#menuitemschema-vendor-comparison)
  - [Current 7NOW Schema](#current-schema-for-7now-marketplace-api-menuitem)
  - [Mapping to DoorDash Item schema](#mapping-to-doordash-item-schema)
  - [Mapping to Google MenuItem schema](#mapping-to-google-menuitem-schema)
  - [Mapping to Postmates CatalogItem schema](#mapping-to-postmates-catalogitem-schema)

# 7NOW Marketplace API

The 7NOW_Marketplace_API.yaml file provides OpenAPI specifications for the API described in [marketplace-api.md](./marketplace-api.md).

The 7NOW_Marketplace_API follows OpenAPI 3.0 specifications. The file was becoming large, so it has been split into individual paths and components.

> Do not edit the completed 7NOW_Marketplace_API.yaml file directly. Instead, find the path or component you would like to modify in the OpenAPI_Spec folder and make your changes there.
>
> Once you are done editing, run `npm run build:spec` from the marketplace root to generate the 7NOW_Marketplace_API.yaml file.

## Folder structure

All necessary files for generating 7NOW_Marketplace_API.yaml are found in the OpenAPI_Spec folder.

File locations:

```
.
+--paths
|  +--auth.yaml
|  +--order-order_id.yaml
|  +--order.yaml
|  +--store-store_id-item.yaml
|  +--store-store_id-menu.yaml
|  +--store-store_id.yaml
|  +--webhook.yaml
+--components
|  +--schemas
|  |  +--AuthAPI
|  |  |  +--Auth.yaml
|  |  |  +--AuthParam.yaml
|  |  +--OrderAPI
|  |  |  +--OrderDataSchema.yaml
|  |  |  +--OrderItemSchema.yaml
|  |  |  +--OrderList.yaml
|  |  |  +--OrderRequest.yaml
|  |  |  +--OrderResponse.yaml
|  |  +--StoreAPI
|  |  |  +--CategorySchema.yaml
|  |  |  +--MenuItemSchema.yaml
|  |  |  +--MenuSchema.yaml
|  |  |  +--NutritionInfoItem.yaml
|  |  |  +--NutritionInfoSchema.yaml
|  |  |  +--StoreAddress.yaml
|  |  |  +--StoreHours.yaml
|  |  |  +--StoreSchema.yaml
|  |  +--WebhookAPI
|  |  |  +--WebhookSchema.yaml
|  |  +--MessageSchema.yaml
|  +--securitySchemes
|  |  +--BearerAuth.yaml
+--index.yaml
+--build.sh
```

## File descriptions

### Root

`index` is the main entry point for the file generation. All the paths and components are loaded into here.

`build.sh` is a bash script to generate the final OpenAPI spec file. It uses [swagger-merger](https://www.npmjs.com/package/swagger-merger) to bundle the files and [swagger-cli](https://www.npmjs.com/package/swagger-cli) as an extra linting step to verify the file is syntactically correct. The linting step can catch errors that the generation step missed. Both tools are invoked with `npx` so nothing is permanently installed. Run the script from directly inside the OpenAPI_Spec folder, or run `npm run build:spec` from the project root.

### Components

`BearerAuth` sets the authentication method for the API calls.

`Auth` describes the data that is returned from POSTing to the auth endpoint.

`AuthParam` describes the data that is POSTed to the auth endpoint.

`OrderDataSchema` is the data payload of an `OrderRequest` from the order POST endpoint.

`OrderItemSchema` describes the items/fee items contained in the `OrderDataSchema`.

`OrderList` is a list of `OrderResponse` obtained from the order GET endpoint.

`OrderRequest` is the request body for the order POST endpoint.

`CategorySchema` is returned inside of `MenuSchema` to describe each category in the menu.

`MenuItemSchema` describes each item in the menu. Returned inside of `CategorySchema`.

`MenuSchema` is returned from the store/{store_id}/menu GET endpoint and contains menu information.

`NutritionInfoItem` describes an element of the nutritional information found in `NutritionInfoSchema`.

`NutritionInfoSchema` is returned with each `MenuItemSchema` and contains the nutritional information of the item.

`StoreAddress` describes the store address.

`StoreHours` describes the days/hours that a given store is open.

`StoreSchema` contains details about the store.

`WebhookSchema` describes the information required for setting/updating webhooks.

### Paths

`auth` defines the endpoint for obtaining an access token.

`order-order_id` defines how to get an order by ID.

`order` defines the GET and POST endpoints for orders.

`store-store_id-item` defines how to obtain item details from a given store.

`store-store_id-menu` defines how to get a store's menu.

`store-store_id` defines how to get a store's details given a store ID.

`webhook` defines PUT and PATCH methods for setting/updating webhooks.

# MenuItemSchema Vendor Comparison

## Current schema for 7NOW Marketplace API MenuItem

### MenuItem

| Field          | Type         | Description                                        |
|----------------|--------------|----------------------------------------------------|
| product_id     | string       | Unique product ID                                  |
| store_id       | string       | Store ID                                           |
| name           | string       | Name of the product                                |
| desc           | string       | Product description                                |
| price          | number (int) | Product price in cents                             |
| image          | string       | Image URL                                          |
| popularity     | number (int) | Ranking of the item to display                     |
| available      | boolean      | true when available, false when unavailable        |
| handling       | string       | Hot or Cold                                        |
| min_age        | number (int) | Qualifying minimum age                             |
| ingredients    | string       | Description of the product ingredients information |
| nutrition_info | object       | Nutritional information                            |

## Mapping to DoorDash Item schema

### Item

| Field                | Type         | Required | Description | 7-11 field | same type | notes |
|----------------------|--------------|----------|-------------|------------|-----------|-------|
| name                 | string       | TRUE     | Item name   | name       | yes       |       |
| description          | string       | FALSE    |             | desc       | yes       |       |
| merchant_supplied_id | string       | TRUE     | 7-11 ID     | product_id | yes       |       |
| active               | boolean      | FALSE    |             | available  | yes       |       |
| is_alcohol           | boolean      | FALSE    |             |            | no        |       |
| is_bike_friendly     | boolean      | FALSE    |             |            | no        |       |
| sort_id              | number (int) | FALSE    |             | popularity | yes       |       |
| price                | number (int) | TRUE     |             | price      | maybe     |       |
| extras               | object       | FALSE    |             |            | no        |

## Mapping to Google MenuItem schema

### MenuItem

| Field                      | Type          | Required | Description                                 | 7-11 field | same type | notes             |
|----------------------------|---------------|----------|---------------------------------------------|------------|-----------|-------------------|
| @id                        | string (url)  | TRUE     | Unique identifier for item                  |            | no        | Needs to be a URL |
| name                       | string        | TRUE     | Item name                                   | name       | yes       |                   |
| description                | string        | FALSE    | Item description                            | desc       | yes       |                   |
| image                      | string        | FALSE    | URL to item image                           | image      | yes       |                   |
| menuAddOn                  | array         | FALSE    | List of allowed add-ons for item            |            | no        |                   |
| offers                     | array         | TRUE     | List of offers                              |            | yes       |                   |
| - Offer.sku                | string        | TRUE     | Unique identifier for item                  | product_id | yes       |                   |
| - Offer.price              | string        | TRUE     | Item price                                  | price      | no        |                   |
| - Offer.priceCurrency      | string        | TRUE     | 3-letter ISO 4217 price code                |            | no        |                   |
| - Offer.availabilityStarts | string (date) | FALSE    | Date/time when offer is available           |            | no        |                   |
| - Offer.availabilityEnds   | string (date) | FALSE    | Date/time when offer is no longer available |            | no        |                   |
| - Offer.availableDay       | array         | FALSE    | Days of the week the item is available      |            | no        |                   |
| - Offer.validFrom          | string (date) | FALSE    | Date/time from which item price is valid    |            | no        |                   |
| - Offer.validThrough       | string (date) | FALSE    | Date/time through which item price is valid |            | no        |                   |
| - Offer.eligibleQuantity   | number        | FALSE    | Ordering quantities which are allowed       |            | no        |                   |
| - Offer.inventoryLevel     | number        | FALSE    | Approximate inventory level for the item    |            | no        |

## Mapping to Postmates CatalogItem schema

### CatalogItem

| Field           | Type           | Required | Description                                                                      | 7-11 field | same type | notes                                     |
|-----------------|----------------|----------|----------------------------------------------------------------------------------|------------|-----------|-------------------------------------------|
| kind            | string         | TRUE     | 'item'                                                                           |            | yes       | Always 'item' so it matches if we send it |
| id              | string         | TRUE     | Unique ID of the item                                                            | product_id | yes       |                                           |
| created         | string (date)  | FALSE    | Date/time that this item was created                                             |            | no        |                                           |
| updated         | string (date)  | FALSE    | Date/time that this item was updated                                             |            | no        |                                           |
| name            | string         | TRUE     | Display name for the item. Limited to 100 characters                             | name       | yes       |                                           |
| price           | number (float) | TRUE     | Fixed precision currency amount, formatted as a string                           | price      | no        |                                           |
| price_currency  | string         | FALSE    | Currency code for unit price. Defaults to 'USD'                                  |            | no        |                                           |
| description     | string         | FALSE    | Detailed item description                                                        | desc       | yes       |                                           |
| ordinal         | number (int)   | FALSE    | Item ranking for display                                                         | popularity | yes       |                                           |
| is_available    | boolean        | FALSE    | Whether this item is available for purchase                                      | available  | yes       |                                           |
| tax_rate        | number (float) | FALSE    | Sales tax rate for this item as a percentage. Overrides location-level sales tax |            | no        |                                           |
| modifier_groups | array          | FALSE    | Modifier groups for item                                                         |            | no        |                                           |
| availability    | array          | FALSE    | List of availability windows for the item                                        |            | no        |                                           |
| photo_url       | string         | FALSE    | URL for item image                                                               | image      | yes       |
