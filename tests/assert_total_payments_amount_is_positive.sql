
select
    order_id,
    sum(amount) as total
from {{ ref('stg_payments') }}
group by order_id
having total < 0