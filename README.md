# Outbox example apps

This is example applications which uses:
- [sbmt-outbox](https://github.com/SberMarket-Tech/sbmt-outbox)
- [sbmt-kafka_producer](https://github.com/SberMarket-Tech/sbmt-kafka_producer)
- [sbmt-kafka_consumer](https://github.com/SberMarket-Tech/sbmt-kafka_consumer)

## How to run

1. Install [Dip](https://github.com/bibendi/dip)
2. Start [Kafka](./infra/) broker `cd infra && dip up`
3. Start [Quest](./quest/) application `cd quest && dip up`
4. Start [Voyage](./voyage/) application `cd voyage && dip up`

## Test case

1. Create an order in Quest app

```shell
curl --location http://localhost:3000/api/v1/orders \
--form '[order]name=Foo' \
--form '[order]qty=3' \
--form '[order]price=42'
```

2. Send the order to Vayage app through Outbox pattern

```shell
curl --request POST --location http://localhost:3000/api/v1/orders/<ORDER-UUID>/completion
```

3. Show the imported order

```shell
curl --location http://localhost:3001/api/v1/orders
```
