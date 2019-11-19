## List of batch processes

### Process to copy stores and store_products from 7Now to Market place DB
- Read vendor specific configurations
- Read rules defined for vendor
- Copy stores from 7now to Market place 
- Copy inventory (store_products) to Market place 
- Generate vendor specific object or files
- Invoke vendor specific webhook url as per their request object

### Process to listen store and item status change events
This process is to listen the change events on 7Now and act accordingly (i.e to invoke  vendor specific webhooks to update the status )


### Process to generate settlement files
This process is to generate settlement files applicable to vendors

