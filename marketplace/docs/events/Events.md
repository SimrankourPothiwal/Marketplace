# Event Definitions

## Order Status Transition
| Current Status   | Event            | Target Status       | Description                      |
|------------------|------------------|---------------------|----------------------------------|
| NA                     | `submit` | `submitted` | Validate request, generate id and queue up for processing |
| `submitted`            | `accept` | `accepted` | Verify store online and item availability before accept |
| `submitted`            | `accept` | `failed` | Either store or items or platform is unavailable |
| `accepted`             | `items_update` | `processing` | Store fulfilling items on the order
| `processing`           | `items_complete` | `ready` | Store finished processing order and ready for pickup
| `ready`                | `picked_up` | `out_for_delivery` | Store handed over the order to driver
| `out_for_delivery`     | `dropoff` | `complete` | Order delivered
| `submitted / accepted` | `cancel` | `canceled` | Store or Customer cancelling the order |

## Order Events

| Type  | Event            | Description                      | Request and Response | 
|-------|------------------|----------------------------------|---------------------|
| order | `checkout` | Check for items availability and tax details | [Checkout](#checkout) |
| order | `submit` | Submit an order for processing | [Submit](#submit) |
| order | `accept` | Accept a submitted order | [Accept](#accept) |
| order | `items_update` | Process items on an accepted order | [Items Update](#items-update) |
| order | `items_complete` | No more items to process | [Items Complete](#items-complete) |
| order | `picked_up` | Package leaves the store | [Picked Up](#picked-up) |
| order | `dropoff` | Order delivered | [Dropoff](#dropoff) |
| order | `update` | Update an order prior to accept / confirm | [Update](#update) |
| order | `cancel` | Cancel an order prior to ready | [Cancel](#cancel) |

## Store Events

| type  | action           | description                      |
|-------|------------------|-----|----------------------------------|
| store | `offline` | Take a store `offline` from one or more marketplace |
| store | `online`  | Bring a store `online` for one ore more marketplace |

## Item Events

--------------------------------------------------------------
| Event Name | Definition
|--------------|------------------------------------------------
| InProgress |   Preparing  |
| Ready |  Item is ready  | 
| Cancel | Cancelling item due to unavailability |

## Item Status

| Previous Status | Event | Current Status |
|--------------|------------|----------------|
| N/A  | default  |   Pending  |
| Pending | Preparing |  InProgress  | 
| InProgress | Ready | Complete |
| N/A | Cancel  | Caancelled |

## Product Events
TODO

### Checkout
TODO
Request

```json
{
    "event": "checkout"
}
```

Response
```json
{
    "event": "checkout",
    "status": "success"
}
```

### Submit
TODO
Request

```json
{
    "event": "submit"
}
```

Response
```json
{
    "event": "submit",
    "status": "success"
}
```

### Accept
TODO
Request

```json
{
    "event": "accept"
}
```

Response
```json
{
    "event": "accept",
    "status": "success"
}
```

### Items Update
TODO
Request
```json
{
    "event": "items_update"
}
```

Response
```json
{
    "event": "items_update",
    "status": "success"
}
```

### Items Complete
TODO
Request
```json
{
    "event": "items_complete"
}
```

Response
```json
{
    "event": "items_complete",
    "status": "success"
}
```

### Picked Up
TODO
Request

```json
{
    "event": "picked_up"
}
```

Response
```json
{
    "event": "picked_up",
    "status": "success"
}
```

### Dropoff
TODO
Request

```json
{
    "event": "dropoff"
}
```

Response
```json
{
    "event": "dropoff",
    "status": "success"
}
```

### Cancel
TODO
Request

```json
{
    "event": "cancel"
}
```

Response
```json
{
    "event": "cancel",
    "status": "success"
}
```

### Update
TODO
Request

```json
{
    "event": "update"
}
```

Response
```json
{
    "event": "update",
    "status": "success"
}
```
