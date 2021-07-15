with customers as (

    select
        id as customer_id,
        first_name,
        last_name

    from test_randy.jaffle_shop.customers

)

select * from customers