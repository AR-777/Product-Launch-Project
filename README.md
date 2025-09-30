# Portfolio Project: Product Launch Performance Review – Halo One
 
## Background Overview
As a Data Analyst at Neurowear, a wearable tech company focused on cognitive wellness, I was tasked with evaluating the post-launch performance of our first consumer product: the Halo One. This smart headband helps users improve focus, sleep quality, and mental resilience using biometric feedback and real-time app support.
The product was officially launched on January 1, 2023 across the United States.
Halo One comes in two tiers:
•	Base version ($249.99) – includes Sleep Tracking, Focus Mode, and Stress Monitoring
•	Pro version ($349.99) – adds advanced features like Mood Analysis and Cognitive Coaching
Six months post-launch, leadership requested a deep-dive analysis of customer behavior, product engagement, and market performance across key channels and regions.
 
## Project Goals
•	Understand who bought the product and how soon after launch
•	Measure feature adoption by version and user type
•	Evaluate user satisfaction and app engagement
•	Identify trends in Pro vs Base adoption and purchase channel
•	Recommend strategies for product and marketing optimization
 
## Data Model Summary
Table Name	Key Columns
users	user_id, age, gender, state
orders	order_id, user_id, purchase_date, purchase_timing, channel, pro_version, revenue_usd
features_used	order_id, binary flags for each feature (5 total)
feedback	order_id, user_rating, app_sessions_first_week, minutes_used_per_day, days_active_in_first_month
 
## Key Insights

### Pro Version Drives Revenue
•	Approximately 30% of users purchased the Pro version
•	This segment contributed approximately 40% of total revenue — a realistic outcome due to the $100 price difference, demonstrating the financial value of premium pricing despite a smaller user base
 
### Feature Adoption Patterns
•	Sleep Tracking is the most widely used feature (~55.6% adoption)
•	Focus Mode is enabled by ~58.6% of users
•	Stress Monitoring is evenly adopted (~49.5%) and available to both Base and Pro users
•	Mood Analysis and Cognitive Coaching are exclusive to Pro users, with adoption rates of ~58.5% and ~49.3%, confirming Pro features are actively used
 
### Early Buyers Are More Engaged
•	Early adopters (Week 1–2) represented ~20% of all orders
•	Month 2–3 buyers and Late adopters (post-Month 3) each made up ~30% of orders
•	Across all buyer segments, engagement remained steady:
o	Average sessions in the first month: ~16
o	Average daily minutes of usage: ~270
 
### Usage Behavior Mirrors Feature Enablement
•	Users who enabled Sleep Tracking averaged ~440 minutes/day
•	Users without Sleep Tracking averaged ~55 minutes/day
•	This reflects the higher stickiness and passive engagement driven by always-on features like sleep monitoring
 
### Feedback Trends
•	Average user rating across all users was ~3.7
•	Users with fewer than 2 sessions in the first month were disproportionately represented among 1–2 star ratings, suggesting early churn is linked to dissatisfaction
 
## Recommendations
1.	Upsell Sleep-Focused Users to Pro
o	Many base users heavily using Sleep Tracking could benefit from Pro-only coaching features
2.	Target Low-Session Users for Intervention
o	Users with ≤1 session in the first week had lower retention — use onboarding reminders or app walkthroughs
3.	Promote in High-Converting States
o	States like California, Texas, and New York had the highest sales volumes — double down on regional targeting
4.	Feature-Level Satisfaction Surveys
o	To refine product direction, consider capturing satisfaction for individual features like Focus Mode or Coaching
 
