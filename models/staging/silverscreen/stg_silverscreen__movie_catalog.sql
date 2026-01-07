with 

source as (

    select * from {{ source('silverscreen', 'movie_catalog') }}

),

renamed as (

    select
        movie_id,
        movie_title,
        release_date,
        COALESCE(genre,'UNKNOWN') AS genre,
        country,
        studio,
        budget,
        director,
        rating,
        minutes

    from source

)

select * from renamed