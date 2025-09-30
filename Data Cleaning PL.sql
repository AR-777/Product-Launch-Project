-- CREATING TABLES

create table users (
    user_id varchar(25) not null primary key,
    age int,
    gender varchar(45),
    state varchar(45)
);

create table orders (
	order_id varchar(25) not null primary key,
    user_id varchar(25),
    purchase_date datetime,
    purchase_timing varchar(45),
    channel varchar(45),
    pro_version boolean,
    revenue float
);
    
create table features_used (
	order_id varchar(25) not null primary key,
    used_sleep_tracking varchar(45),
    used_focus_mode varchar(45),
    used_stress_monitoring varchar(45),
    used_mood_analysis varchar(45),
    used_cognitive_coaching varchar(45)
);    

create table feedback (
	order_id varchar(25) not null primary key,
    user_rating int,
    app_sessions_first_month int,
    minutes_used_per_day decimal(10,7),
    days_active_in_first_month int
);  


select *
from users;

select *
from features_used;

select *
from feedback;

select count(*)
from feedback
where user_rating is null;

select count(*)
from feedback;

select *
from orders;

-- CREATE BACKUP TABLES

create table backup_users as
select * from users;

create table backup_features_used as
select * from features_used;

create table backup_feedback as
select * from feedback;

create table backup_orders as
select * from orders;

-- CLEANING DATA


-- Searching for any duplicate rows
select user_id, age, gender, state, count(*)
from users
group by user_id, age, gender, state
having count(*) > 1;

-- Check for any null values

select user_id, age, gender, state
from users
where user_id is null
or age is null
or gender is null
or state is null;

-- contains null values in user_rating (ok in that column)
select order_id, user_rating, app_sessions_first_month, minutes_used_per_day, days_active_in_first_month
from feedback
where order_id is null
or user_rating is null
or app_sessions_first_month is null
or minutes_used_per_day is null
or days_active_in_first_month is null;

select order_id, used_sleep_tracking, used_focus_mode, used_stress_monitoring, used_mood_analysis, used_cognitive_coaching
from features_used
where order_id is null
or used_sleep_tracking is null
or used_focus_mode is null
or used_stress_monitoring is null
or used_mood_analysis is null
or used_cognitive_coaching is null;

select order_id, user_id, purchase_date, purchase_timing, channel, pro_version, revenue
from orders
where order_id is null
or user_id is null
or purchase_date is null
or purchase_timing is null
or channel is null
or pro_version is null
or revenue is null;

-- Check to see if there are any outliers OR incosistencies in data types

select distinct gender
from users;

-- change data inconsistencies to correct format
update users 
set gender = case
	when gender like 'f%' then 'Female'
    when gender like 'm%' then 'Male'
    else gender 
end;


select distinct state
from users;

select *
from users;

-- Check to see if there are any outliers
select  min(age) as min_age,
max(age) as max_age
from users;




select distinct used_sleep_tracking
from features_used;

update features_used
set used_sleep_tracking = case
	when used_sleep_tracking = 'No' then 0
    when used_sleep_tracking = 'Yes' then 1
    else used_sleep_tracking
end;

select distinct used_focus_mode
from features_used;

update features_used
set used_focus_mode = case
	when used_focus_mode = 'No' then 0
    when used_focus_mode = 'Yes' then 1
    else used_focus_mode
end;

select distinct used_stress_monitoring
from features_used;

update features_used
set used_mood_analysis = case
	when used_mood_analysis = 'No' then 0
    when used_mood_analysis = 'Yes' then 1
    else used_mood_analysis
end;


select distinct used_mood_analysis
from features_used;

update features_used
set used_cognitive_coaching = case
	when used_cognitive_coaching = 'No' then 0
    when used_cognitive_coaching = 'Yes' then 1
    else used_cognitive_coaching
end;


-- feedback table

select distinct user_rating
from feedback;

select distinct app_sessions_first_month -- check this with chatgpt, why 32 - 35
from feedback
order by app_sessions_first_month asc;

select distinct minutes_used_per_day
from feedback
order by minutes_used_per_day desc;

select distinct days_active_in_first_month
from feedback
order by days_active_in_first_month asc;




select distinct purchase_date
from orders
order by purchase_date asc;

select distinct purchase_timing
from orders;

select distinct channel
from orders;


update orders
set channel = case
	when trim(lower(channel)) = 'retail' then 'Retail'
    else channel
end;

select distinct pro_version
from orders;

select distinct revenue
from orders;




