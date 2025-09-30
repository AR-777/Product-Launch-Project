-- DATA ANALYSIS


-- Total revenue

select round(sum(revenue),2) as total_revenue
from orders;

-- Total Orders

select count(*) total_orders
from orders;

-- Average User Rating

select round(avg(user_rating),1) as avg_rating
from feedback;

-- Average Minutes per day

select round(avg(minutes_used_per_day),2) as avg_min_per_day
from feedback;

select round((avg(minutes_used_per_day) / 60),2) as avg_time_per_day
from feedback;

-- % Pro Version

select round((sum(pro_version) / count(*) * 100),1) as percent_bought_pro
from orders;

-- % Pro Version contribute to revenue

select 
	round(100.0 * sum(case when pro_version = 1 then revenue else 0 end) / sum(revenue), 2) as pro_revenue_pct
from orders;


-- Revenue by state

select state, round(sum(revenue),2) as revenue
from orders o
	join users u
    on o.user_id = u.user_id
group by state
order by revenue desc;

-- Rating distribution

with ratings as (
select user_rating,
count(*) rating_count
from feedback
group by user_rating
)
select user_rating,
rating_count,
rating_count * 1.0 / SUM(rating_count) OVER () AS rating_percent
from ratings
where user_rating is not null;


-- Top Feature Usage

SELECT 
  feature_name,
  usage_count,
  RANK() OVER (ORDER BY usage_count DESC) AS feature_rank
FROM (
  SELECT 'sleep_tracking' AS feature_name, SUM(used_sleep_tracking) AS usage_count FROM features_used
  UNION ALL
  SELECT 'focus_mode', SUM(used_focus_mode) FROM features_used
  UNION ALL
  SELECT 'stress_monitoring', SUM(used_stress_monitoring) FROM features_used
  UNION ALL
  SELECT 'mood_analysis', SUM(used_mood_analysis) FROM features_used
  UNION ALL
  SELECT 'cognitive_coaching', SUM(used_cognitive_coaching) FROM features_used
) AS feature_usage;


-- Top Feature Usage % - Non pro

select
round(avg(used_sleep_tracking * 1.0) * 100, 2) as sleep_tracking_pct,
round(avg(used_focus_mode * 1.0) * 100, 2) as focus_mode_pct,
round(avg(used_stress_monitoring * 1.0) * 100, 2) as stress_monitoring_pct
from features_used;

-- Mood Analysis / Cognitive Coaching (Pro Only)

select
round(avg(case when o.pro_version = 1 then fu.used_mood_analysis end) * 100.0, 2) as mood_analysis_pct,
round(avg(case when o.pro_version = 1 then fu.used_cognitive_coaching end) * 100.0, 2) as coaching_pct
from features_used as fu
	join orders as o
    on fu.order_id = o.order_id;

-- Buyers timing

select purchase_timing,
count(*) as order_count,
round(count(*) * 100.0 / (select count(*) from orders), 2) as pct_of_total
from orders
group by purchase_timing
order by field(purchase_timing, 'Week 1-2', 'Week 3-4', 'Month 2-3', 'Late Adopter');


-- Buyer timing comparing app sessions and daily usage

select o.purchase_timing,
round(avg(f.app_sessions_first_month), 2) as avg_sessions,
	round(avg(f.minutes_used_per_day), 2) as avg_minutes
from feedback as f
	join orders as o
    on f.order_id = o.order_id
group by o.purchase_timing
order by field(o.purchase_timing, 'Week 1-2', 'Week 3-4', 'Month 2-3', 'Late Adopter');


-- Buyer timing - Satisfaction Rating

select o.purchase_timing,
round(avg(f.user_rating), 2) as avg_rating
from feedback as f
	join orders as o
    on f.order_id = o.order_id
group by o.purchase_timing
order by field(o.purchase_timing, 'Week 1-2', 'Week 3-4', 'Month 2-3', 'Late Adopter');


-- Which features are most/least adopted by product version?

SELECT 
  version,
  feature_name,
  usage_count,
  RANK() OVER (PARTITION BY version ORDER BY usage_count DESC) AS feature_rank
FROM (
  SELECT 
    CASE WHEN o.pro_version = 1 THEN 'Pro' ELSE 'Standard' END AS version,
    'sleep_tracking' AS feature_name, 
    SUM(fu.used_sleep_tracking) AS usage_count
  FROM features_used fu
  JOIN orders o ON fu.order_id = o.order_id
  GROUP BY version

  UNION ALL

  SELECT 
    CASE WHEN o.pro_version = 1 THEN 'Pro' ELSE 'Standard' END AS version,
    'focus_mode',
    SUM(fu.used_focus_mode)
  FROM features_used fu
  JOIN orders o ON fu.order_id = o.order_id
  GROUP BY version

  UNION ALL

  SELECT 
    CASE WHEN o.pro_version = 1 THEN 'Pro' ELSE 'Standard' END AS version,
    'stress_monitoring',
    SUM(fu.used_stress_monitoring)
  FROM features_used fu
  JOIN orders o ON fu.order_id = o.order_id
  GROUP BY version

  UNION ALL

  SELECT 
    CASE WHEN o.pro_version = 1 THEN 'Pro' ELSE 'Standard' END AS version,
    'mood_analysis',
    SUM(fu.used_mood_analysis)
  FROM features_used fu
  JOIN orders o ON fu.order_id = o.order_id
  GROUP BY version

  UNION ALL

  SELECT 
    CASE WHEN o.pro_version = 1 THEN 'Pro' ELSE 'Standard' END AS version,
    'cognitive_coaching',
    SUM(fu.used_cognitive_coaching)
  FROM features_used fu
  JOIN orders o ON fu.order_id = o.order_id
  GROUP BY version
) AS feature_usage;


-- Does product usage differ by channel

select o.channel,
round(avg(days_active_in_first_month),1) as usage_first
from orders o
	join feedback f
    on o.order_id = f.order_id
group by o.channel;


-- App Sessions

select -- needs to be redone on write up
	case 
		when app_sessions_first_month < 2 then '<2'
        when app_sessions_first_month between 2 and 10  then '2-10'
        else '11+'
	end as session_bucket,
    round(avg(user_rating), 2) as avg_rating
from feedback
group by session_bucket
order by field(session_bucket, '<2', '2-10', '11+');

-- Sleep Tracking

Select fu.used_sleep_tracking,
round(avg(f.minutes_used_per_day), 2) as avg_minutes
from feedback as f
	join features_used as fu
    on f.order_id = fu.order_id
group by fu.used_sleep_tracking

