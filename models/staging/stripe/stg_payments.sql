with payments as (
    select
        id as payment_id,
        orderid as order_id,
        paymentmethod as payment_method,
        status,

        -- amount is stored as cents, convert it to dollars
        amount / 100 as amount,
        created as created_at
    from test_randy.stripe.payment
)

select * from payments