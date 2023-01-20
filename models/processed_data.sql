WITH renamed AS (
    SELECT * 
    FROM crosstab(
        'with raw_data AS (
            SELECT * FROM ' {{ source('public', '_airbyte_raw_test') }} '
        )
        SELECT 
            _airbyte_ab_id,
            key,
            value
        FROM raw_data, jsonb_each_text(raw_data._airbyte_data)
        ORDER BY 1, 2',
        $$VALUES ('host'), ('title'), ('yields'), ('total_time'), ('ingredients'), ('instructions')$$
    ) AS ct ("_airbyte_ab_id" text, "host" text, "title" text, "yields" text, "total_time" text, "ingredients" text, "instructions" text)
)
SELECT *
FROM renamed