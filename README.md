# AppSync Demo

## Example Queries

### Query
```
query getOrders {
  getOrders(id:123) {
    firstName
    lastName
  }
}
```

### Mutation
```
muatition createOrder {
  createOrder(id:123) {
    firstName
    lastName
  }
}
```