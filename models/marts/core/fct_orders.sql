with 
    payments as (
        select * from {{ ref('stg_payments') }}
    ),

    orders as (
        select * from {{ ref('stg_orders') }}
    ),

    order_payments as (
        select
            order_id,
            sum(iff(status = 'success', amount, 0)) as amount
        from payments
        group by 1
    ),

    final as (
        select
            o.order_id,
            o.customer_id,
            o.order_date,
            zeroifnull(op.amount) as amount
        from orders o
        left join order_payments op using (order_id)
    )

select * from final

