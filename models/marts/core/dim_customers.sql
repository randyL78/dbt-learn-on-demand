with customers as (
    select * from {{ ref('stg_customers') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

payments as (
    select * from {{ ref('stg_payments') }}
),

customer_orders as (

    select
        customer_id,

        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders,
        sum(p.amount) as lifetime_value

    from orders
    join payments p using (order_id)

    group by 1

),

final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        zeroifnull(customer_orders.number_of_orders) as number_of_orders,
        zeroifnull(customer_orders.lifetime_value) as lifetime_value

    from customers

    left join customer_orders using (customer_id)
)

select * from final