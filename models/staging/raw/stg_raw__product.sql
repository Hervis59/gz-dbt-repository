with 

source as (

    select * from {{ source('raw', 'product') }}

),

renamed as (

    select
        products_id AS pdt_id,
        CAST(purchse_price AS FLOAT64) AS purchase_price

    from source

)

select * from renamed
