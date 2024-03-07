# Outbox example apps

These are example applications that use:
- [sbmt-outbox](https://github.com/SberMarket-Tech/sbmt-outbox)
- [sbmt-kafka_producer](https://github.com/SberMarket-Tech/sbmt-kafka_producer)
- [sbmt-kafka_consumer](https://github.com/SberMarket-Tech/sbmt-kafka_consumer)

## How to run

1. Install [Dip](https://github.com/bibendi/dip)
2. Start [Quest](./quest/) application `cd quest && dip infra up && dip up`
3. Start [Voyage](./voyage/) application `cd voyage && dip infra up && dip up`

## Test case

1. Create an order in the Quest app

```shell
curl -L http://quest.lvh.me/api/v1/orders -F '[order]name=Foo' -F '[order]qty=3' -F '[order]price=42'
```

2. Send the order to the Voyage app with Outbox pattern

```shell
curl -X POST -L  http://quest.lvh.me/api/v1/orders/ORDER-ID/completion
```

3. Show the imported order in the Voyage app

```shell
curl -L http://voyage.lvh.me/api/v1/orders/ORDER-ID
```
