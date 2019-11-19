# Item Object Definition

### Item
| Field            | Type | Definition |
|------------------|------------|-----|
| `product_id` | String | Unique product ID |
| `store_id` | String | Store ID |
| `name` | String | Name of the product |
| `desc` | String | Product description |
| `price` | Integer | Price in cents |
| `tax` | Integer | Tax in cents |
| `calories` | Integer | Calories per serving |
| `image` | String | Image Url |
| `category` | Array | Array of category Names |
| `popularity` | Number | ranking of item to display
| `available` | Boolean | `true` when available and `false` when unavailable |
| `handling` | String | Hot or Cold |
| `min_age` | Integer | Qualifying minimum age |
| `ingredients` | String | Describe the product ingredients information |
| `nutrition_info`| Object | See [Nutritional Information](#nutritional-information) |


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

### Store Item Status
- active  `true` or `false`


> For each item status change event, we need to update the partners about item status by invoking their registered web-hook.

## Order Item Events

--------------------------------------------------------------
| Event Name | Definition
|--------------|------------------------------------------------
| in-progress |   Preparing  |
| ready |  Item is ready  | 
| cacel | Cancelling item due to unavailability |

## Order Item  Status Transition 

| Previous Status | Event | Current Status |
|--------------|------------|----------------|
| N/A  | default  |   pending  |
| pending | preparing |  in-progress  | 
| in-progress | ready | completed |
| N/A | cancel  | caancelled |