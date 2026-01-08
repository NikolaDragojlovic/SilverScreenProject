with 

source as (

    select * from {{ source('silverscreen', 'movie_catalog') }}

),

renamed as (    --Movie catalog with basic information including genre, country, studio, director, and duration.

    select
        movie_id,
        movie_title,
        release_date,
        COALESCE(genre,'UNKNOWN') AS genre,   --Replacing null values with UNKNOWN
        country,
        studio,
        budget,
        director,
        rating,
        minutes

    from source

)

select * from renamed