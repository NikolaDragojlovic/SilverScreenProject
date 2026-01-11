# 🎬 Silver Screen Cinema Profitability Analysis
## 📌 Project Overview

This dbt project was built to support business analysis for Silver Screen, a movie theater chain operating three locations in New Jersey (NJ_001, NJ_002, NJ_003), recently acquired by a major Entertainment Company.

The main goal of the project is to analyze the relationship between monthly movie rental costs and revenue generated from ticket sales, evaluate location efficiency, and deliver a clean, reliable analytics mart for BI reporting and decision-making.

The project uses Snowflake as the data warehouse, dbt Cloud for transformations, testing, and orchestration, and Tableau for downstream analytics.

## 🧱 Tech Stack

Data Warehouse: Snowflake

Transformation & Testing: dbt Cloud

Version Control: Git / GitHub

BI Tool: Tableau

## 📂 Data Sources

All raw data is loaded into Snowflake and defined in dbt as sources:

movie_catalogue – movie metadata (title, genre, studio)

invoices – monthly rental costs per movie and location

nj_001 – transaction-level ticket sales

nj_002 – daily aggregated ticket sales

nj_003 – item-level purchases (tickets, snacks, drinks)

⚠️ Source data arrives in different formats and grains, requiring normalization, filtering, and aggregation.

## 📦 Deliverables

| File / Link | Description |
|-------------|-------------|
| [README.md](README.md) | This file – project overview, setup, and deliverables |
| [Lineage Diagram](Lineage.png) | dbt lineage graph showing model dependencies |
| [DAG Diagram](DAG.png) | Directed Acyclic Graph of the dbt project flow |
| [mart_cinema_profitability CSV](models_marts_mart_cinema_profitability.csv) | Final mart output – cinema profitability data |
| [Staging Models](Staging) | Folder with all staging models (stg_*) |
| [Intermediate Models](Intermediate) | Folder with int models (int_*) |
| [Marts Models](Marts) | Folder with mart models (mart_*) |
| [Tests & Macros](Tests%20%26%20Macro) | Folder with custom tests and macros |
| [.yml Files – Silverscreen](.yml%20files%20Silverscreen) | Schema.yml files with documentation and tests |
| [Silverscreen Tableau Link](Silverscreen%20Tableau%20Link) | Link to the live Tableau Public dashboard |
| [Project Documentation](Project_Documentation.pdf) | Full project description, process, and insights (if uploaded as PDF) |

## 🏗️ Project Architecture (DAG)

The project follows a layered dbt architecture:

Sources → Staging → Intermediate → Mart

### 1️⃣ Staging Layer (stg_)

Purpose:

Clean raw source data

Standardize column names and data types

Handle missing values

Apply basic filters and transformations

Key actions:

Replace missing genres with 'Unknown'

Filter nj_003 to product_type = 'ticket'

Extract month from timestamps

Normalize ticket and revenue fields across locations

### 2️⃣ Intermediate Layer (int_)

Purpose:

Align data grain

Unify data across locations

Resolve duplication and aggregation issues

Key models:

int_union_locations_revenue

Unifies ticket sales and revenue from all locations

Aggregated at monthly level

Grain: 1 row = movie + location + month

int_movie_costs

Aggregates invoice data

Handles multiple invoices per movie/location/month

Produces a single monthly rental cost per movie and location

### 3️⃣ Mart Layer (mart_)

Purpose:

Deliver business-ready analytics

Serve as a single source of truth for BI tools

Final Model: mart_cinema_profitability

Grain:
1 row = 1 movie + 1 location + 1 month

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

⚠️ Rental cost is fixed per movie per month, regardless of the number of locations.

## 🧪 Testing Strategy
Built-in dbt Tests

Defined in schema.yml files:

not_null

unique

Relationship tests where applicable

Custom (Singular) Tests

Custom SQL tests are stored in the /tests directory:

mart_duplicate_grain
Ensures no duplicate rows at the defined mart grain (movie + location + month)

missing_movies_in_mart
Validates that all rented movies appear in the final mart

negative_amounts
Ensures ticket sales and revenue are never negative

All tests are executed via:

dbt test

## 📘 Documentation

All models and key columns are documented in .yml files

Documentation is written for:

Business users

BI analysts

Future data engineers

dbt documentation is generated using:

dbt docs generate

## 🔄 CI / Automation

The project is deployed in dbt Cloud

A scheduled Cloud Job runs:

dbt build


CI ensures:

All models build successfully

All tests pass

No broken dependencies are deployed

## 🚀 How to Run the Project

Clone the Git repository

Configure Snowflake connection in dbt Cloud

Install dependencies:

dbt deps


Run the full pipeline:

dbt build


Generate documentation:

dbt docs generate

## 📊 Downstream Usage

The final mart feeds Tableau dashboards covering:

Revenue vs Rental Cost over time

Monthly profit and loss

Revenue by location

Performance by movie and genre

📈 Key Insights (Summary)

Total rental costs exceed total revenue across most months

NJ_003 alone generates nearly as much revenue as NJ_001 and NJ_002 combined

Only May and October show slight profitability

Most profitable genres:

Action

Animation

Comedy

Sci-Fi

Higher revenue at NJ_003 is likely driven by a broader offering that attracts more visitors

## 🧠 Recommendations

Introduce drinks and snacks at NJ_001 and NJ_002 to attract more visitors and increase revenue

Consider acquiring one or two additional theaters

Leverage fixed rental costs by maximizing distribution reach

## ⚠️ Assumptions & Limitations

Monthly rental cost is assumed to be fixed per movie, independent of the number of locations

Analysis focuses on ticket revenue only (excluding snacks/drinks from revenue metrics)

Results depend on the accuracy and completeness of provided source data


👤 Author

Nikola Dragojlovic
Role: BI Analyst / Analytics Engineer
Project: Silver Screen – Movie Performance Analytics

