<<<<<<< HEAD
# SilverScreenProject

📌 Project Purpose

This dbt project was built to support business analysis for Silver Screen, a movie theater chain in New Jersey recently acquired by a major Entertainment Company.

The main business goal is to analyze the relationship between monthly movie rental costs and revenue generated across three theater locations, and to provide a clean, reliable, and well-documented analytics mart for reporting and dashboarding.

🧱 Tech Stack

Database: Snowflake

Transformation Tool: dbt Cloud

Version Control: Git

Visualization: Tableau (downstream)

📂 Data Sources

Raw data is loaded into Snowflake and defined in dbt as sources:

movie_catalogue – movie metadata (title, genre, studio)

invoices – monthly rental costs per movie and location

nj_001 – transaction-level ticket sales

nj_002 – daily aggregated ticket sales

nj_003 – item-level purchases (tickets, snacks, drinks)

⚠️ Source data comes in different formats and grains, requiring careful normalization and aggregation.

🏗️ Project Architecture (DAG)

The project follows a layered dbt architecture:

1️⃣ Staging Layer (stg\_)

Purpose:

Clean raw source data

Standardize column names and data types

Handle missing values and basic filtering

Examples:

Replace missing genres with 'Unknown'

Filter nj_003 to include only product_type = 'ticket'

Extract month from timestamps

Normalize ticket and revenue fields across locations

2️⃣ Intermediate Layer (int\_)

Purpose:

Align data grain

Unify data across locations

Resolve duplication and aggregation issues

Key models:

int_union_locations_revenue

Unions cleaned data from all three locations

Aggregates monthly ticket sales and revenue

Grain: 1 row = movie + location + month

int_movie_costs

Aggregates invoice data

Handles multiple invoices per movie/location/month

Produces a single monthly rental cost per movie and location

3️⃣ Mart Layer (mart\_)

Purpose:

Deliver business-ready analytics tables

Serve as a single source of truth for BI tools

Final model:

mart_cinema_profitability

Grain:

1 row = movie + location + month

Columns:

movie_id

movie_title

genre

studio

month

location_id

rental_cost

tickets_sold

revenue

This table is used directly for:

Profitability analysis

Location efficiency comparison

Genre performance insights

Tableau dashboards

🧪 Testing Strategy
Built-in dbt tests

Implemented in schema.yml:

not_null

unique

Relationship tests where applicable

Custom (Singular) Tests

Custom SQL tests are stored in the /tests directory.

Examples:

mart_duplicate_grain
→ Ensures no duplicate rows at the defined grain (movie + location + month)

missing_movies_in_mart
→ Validates that all rented movies appear in the final mart

negative_amounts
→ Checks that ticket sales and revenue are never negative

All tests are executed via:

dbt test

📘 Documentation

All models and key columns are documented in .yml files

Descriptions are written to support:

Business users

BI analysts

Future data engineers

dbt documentation is generated using:

dbt docs generate

🤖 Automation & Deployment

The project is deployed using dbt Cloud

A scheduled Cloud Job runs:

dbt build

CI ensures:

All models build successfully

All tests pass

No broken dependencies are deployed

📊 Downstream Usage

The final mart is designed for:

Tableau dashboards

Monthly performance reviews

Strategic decisions regarding:

Pricing

Location expansion

Product offering (e.g. snacks & drinks)

✅ Project Status

Sources defined

Models built

Custom tests implemented

Documentation completed

Cloud Job configured and executed successfully

👤 Author Nikola Dragojlovic

Role: BI Analyst / Analytics Engineer
Project: Silver Screen – Movie Performance Analytics
=======

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
>>>>>>> 67eefaac0ab8fd6865f28b58b5e625df1e38d7fa
