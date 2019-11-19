# 7NOW Marketplace

## Code Style

This project follows [Airbnb's JavaScript style guide](https://github.com/airbnb/javascript). This style is enforced by ESLint and supported by Prettier and EditorConfig. If you install the Prettier and EditorConfig extensions, much of the formatting work will be taken care of for you. The `.editorconfig` and `.prettierrc` files will take care of most of the formatting for you, especially if you enable the "Format on Save" option in VSCode. I think all the formatting and linting options are complete, but there may be some changes as we start coding (-Mike).

## Architecture



To have a detailed view  about Marketplace Architecture visit the Architecture Diagram [Marketplace_Architecture](docs/architecture/Marketplace_Architecture.png)

See more about MarketPlace Order API Order Flow here [MarketPlace Order API(Order Flow)](docs/api/img/MarketPlace_Order_API_(Order_Flow)_Internal_HLD.png)

See more about MarketPlace Order API Retrieve Order here[MarketPlace Order API(Retrieve_Order)](docs/api/img/MarketPlace_Order_API_(Retrieve_Order)_HLD.png)

See more about MarketPlace Order API Checkout Flow[MarketPlace Order API(Checkout_Flow)](docs/api/img/MarketPlace_Order_API(Checkout_Flow)_Internal_HLD.png)

See more about MarketPlace Order API Create| Cancel | Order  here [MarketPlace Order API(Create_Cancel_Order)](docs/api/img/MarketPlace_Order_API(Create_Cancel_Order)_HLD.png)


## Core Services

 - Provides storage services


 - Receive and sends events to Marketplace


 - Interface with 7NOW through its APIs



## Marketplace APIs
The Marketplace has the following set of APIs

### AuthAPI

 To access service endpoints, authorize using `client_id` and `client_secret` to get a temporary `access_token`.
 All marketplace end points need access token except below auth endpoint.

See [AuthAPI](docs/api/7NOW_Marketplace_API.md#Authorization_API) for `AuthAPI endpoint definitions`.

### OrderAPI
The OrderAPI provides the interface to get the order from the user and it does series of `Actions` to process the order.

See [OrderAPI](docs/api/7NOW_Marketplace_API.md#Order_API) for `OrderAPI endpoint definitions and available actions`.

### StoreAPI
The StoreAPI provides the interface for invoking the Store details. The invoked details can vary depending on the type of invoke thats been made for example "`(GET /v1/store/{store_id}, GET /v1/store/{store_id}/menu)`". 

See [StoreAPI](docs/api/7NOW_Marketplace_API.md#Store_API) for `StoreAPI  endpoint definitions`.

### WebhookAPI
The WebhookAPI is used to  notify real time information on item, store and order when an event occurs.

See [WebhookAPI](docs/api/7NOW_Marketplace_API.md#Webhooks) for `WebhookAPI endpoint definitions`.


## Batch Process




## Marketplace Adapters

### Doordash

### Google

### Postmates


