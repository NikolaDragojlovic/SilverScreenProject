
# Silver Screen Cinema Profitability Analysis
## Project Overview

This project analyzes the financial performance of Silver Screen, a movie theater chain operating three locations in New Jersey (NJ_001, NJ_002, NJ_003).
The goal is to understand the relationship between movie rental costs and revenue generated from ticket sales, and to evaluate the efficiency of each location.

The project is built using Snowflake as the data warehouse and dbt Cloud for data transformation, testing, and orchestration.

The final output is a monthly profitability table that supports business decision-making and BI reporting.

## Business Objective

Management wants to answer the following questions:

Are movie rental costs justified by the revenue generated?

Which locations perform best and why?

How does performance vary by movie, genre, and month?

Which movies and genres are the most profitable?

## Data Sources

Silver Screen provided five data sources, all loaded into Snowflake:

movie_catalogue
Contains movie metadata (movie title, genre, studio, release year).

invoices
Monthly rental invoices issued by studios for movie distribution at each location.

nj_001
Transaction-level ticket sales data (timestamp-based).

nj_002
Daily aggregated ticket sales data.

nj_003
Transaction-level data including multiple product types (tickets, snacks, drinks).
Ticket sales are filtered using product_type = 'ticket', and movie_id is extracted from a details column.

## Data Architecture & DAG

The project follows a layered dbt architecture:

Sources (Snowflake)
   ↓
Staging Models (stg_)
   ↓
Intermediate Models (int_)
   ↓
Mart Model (mart_)

## Model Layers
### Staging (stg_)

Standardize column names and data types

Handle missing values (e.g. replace missing genre with 'Unknown')

Normalize date fields and extract month

Filter invalid or irrelevant records

### Intermediate (int_)

Union and harmonize revenue data across all locations

Aggregate ticket sales and revenue at the monthly, movie, location level

Clean invoice data to ensure one row per movie, location, month

Resolve duplicate invoices before joining with movie metadata

### Mart (mart_)

mart_cinema_profitability
Final analytical table with the following granularity:

1 row = 1 movie + 1 location + 1 month

## Final Model: mart_cinema_profitability
Columns
Column Name	Description
movie_id	Unique movie identifier
movie_title	Movie title
genre	Movie genre
studio	Production studio
month	Reporting month
location_id	Theater location
rental_cost	Monthly rental cost paid to studio (fixed per movie/month)
tickets_sold	Total tickets sold
revenue	Total ticket revenue

⚠️ Rental cost is fixed per movie per month, regardless of the number of locations.

## Data Quality & Testing

The project includes both generic dbt tests and custom singular tests.

## Generic Tests

not_null

unique

Referential integrity checks

Custom Tests

mart_duplicate_grain
Ensures no duplicate rows exist at the defined mart grain.

missing_movies_in_mart
Validates that all expected movies appear in the final mart.

negative_amounts
Ensures ticket sales and revenue are non-negative.

All tests pass successfully using:

dbt build

## Orchestration & Automation

The project is deployed in dbt Cloud

A Cloud Job is configured to:

Run dbt build

Execute all models and tests

Job runs complete successfully with no errors

## BI & Reporting

The final mart is used as the data source for Tableau dashboards, including:

Revenue vs Rental Cost over time

Profitability by movie and genre

Revenue by location

Monthly profit/loss analysis

## Key Insights (Summary)

Total rental costs exceed total revenue across most months

NJ_003 alone generates nearly as much revenue as NJ_001 and NJ_002 combined

Only May and October show slight profitability

Most profitable genres:

Action

Animation

Comedy

Higher revenue at NJ_003 is likely driven by broader offerings, which attract more visitors

## Recommendations

Introduce drinks and snacks at NJ_001 and NJ_002 to attract more visitors and increase revenue

Consider expanding the network by acquiring one or two additional theaters

Leverage fixed rental costs by maximizing distribution reach

## Tech Stack

Data Warehouse: Snowflake

Transformation & Testing: dbt Cloud

BI Tool: Tableau

Version Control: Git / GitHub

## Project Deliverables

dbt project with documented models and tests

Project .yml files

Complete lineage (DAG)

Tableau dashboard

Live presentation recording
