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
