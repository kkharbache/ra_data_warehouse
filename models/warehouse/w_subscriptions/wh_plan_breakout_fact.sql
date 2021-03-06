{% if not var("enable_baremetrics_analytics_source")  %}
{{
    config(
        enabled=false
    )
}}
{% else %}
{{
    config(
        alias='plan_breakout_fact'
    )
}}
{% endif %}

WITH plans AS
  (
  SELECT *
  FROM   {{ ref('wh_plans_dim') }}
),
plan_breakouts as (
  SELECT *
  FROM   {{ ref('int_plan_breakout_metrics') }}
  )
SELECT
   GENERATE_UUID() as plan_breakout_pk,
   p.plan_pk,
   b.*
FROM
   plan_breakouts b
JOIN
   plans p
ON b.plan_id = p.plan_id
