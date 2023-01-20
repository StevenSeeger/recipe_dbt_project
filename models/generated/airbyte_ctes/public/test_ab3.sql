{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('test_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        adapter.quote('value'),
    ]) }} as _airbyte_test_hashid,
    tmp.*
from {{ ref('test_ab2') }} tmp
-- test
where 1 = 1

