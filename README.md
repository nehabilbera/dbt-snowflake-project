# 🏠 DBT-SNOWFLAKE BASIC Project

## 📋 Overview

This project implements a complete end-to-end data engineering dbt-snowflake project. The solution demonstrates best practices in data warehousing, transformation, and analytics using **Snowflake**, **dbt (Data Build Tool)**, and **AWS**.

The pipeline processes Airbnb listings, bookings, and hosts data through a medallion architecture (marts and staging), implementing incremental loading, slowly changing dimensions (SCD Type 2), and creating analytics-ready datasets.

## 🏗️ Architecture

### Data Flow
```
Source Data (CSV) → AWS S3 → Snowflake (Staging)    ->  staging    ->  marts
                                                           ↓              ↓          
                                                      Raw Tables    Cleaned Data  
```

### Technology Stack

- **Cloud Data Warehouse**: Snowflake
- **Transformation Layer**: dbt (Data Build Tool)
- **Cloud Storage**: AWS S3 (implied)
- **Version Control**: Git
- **Python**: 3.11 or less
- **Key dbt Features**:
  - Incremental models
  - Snapshots (SCD Type 2)
  - Custom macros
  - Jinja templating
  - Testing and documentation

## 📊 Data Model

### Medallion Architecture

#### 🥉 Bronze Layer (Raw Data)
Raw data ingested from staging with minimal transformations:
- `bronze_bookings` - Raw booking transactions
- `bronze_hosts` - Raw host information
- `bronze_listings` - Raw property listings

#### 🥈 Silver Layer (Cleaned Data)
Cleaned and standardized data:
- `silver_bookings` - Validated booking records
- `silver_hosts` - Enhanced host profiles with quality metrics
- `silver_listings` - Standardized listing information with price categorization

#### 🥇 Gold Layer (Analytics-Ready)
Business-ready datasets optimized for analytics:
- `obt` (One Big Table) - Denormalized fact table joining bookings, listings, and hosts
- `fact` - Fact table for dimensional modeling
- Ephemeral models for intermediate transformations

### Snapshots (SCD Type 2)
Slowly Changing Dimensions to track historical changes:
- `dim_bookings` - Historical booking changes
- `dim_hosts` - Historical host profile changes
- `dim_listings` - Historical listing changes

## 📁 Project Structure

```
AWS_DBT_Snowflake/
├── README.md                           # This file
│
├── SourceData/                         # Raw CSV data files
│   ├── customers.csv
│   ├── orders.csv
│   └── payments.csv
│
├── SnowFlake_file                        # Database schema definitions
│                        
└── aws_dbt_snowflake_project/         # Main dbt project
    ├── dbt_project.yml                 # dbt project configuration
    ├── profiles.yml             # Snowflake connection profile
    │
    ├── models/                         # dbt models
    │   ├── staging/
    │   │   ├── jaffle_shop
    |   |   |    ├── _src_jaffle_shop.yml
    │   │   |    ├── _stg_jaffle_shop.yml
    │   │   |    └── jaffle_shop_docs.md
    |   |   |    ├── stg_jaffle_shop_customers.sql
    │   │   |    └── stg_jaffle_shop_orders.sql
    │   │   ├── stripe   
    |   |        ├── _src_stripe.yml_
    │   │        └── stg_stripe_payments.sql       
    │   ├── marts/                     
    │   │   ├── dim_customers.sql
    │   │   ├── fact_orders.sql
    │   ├── customer_macro_check.sql   
    │   │   
    │   └── inbuilt_macro_check.sql
    |   │   
    │   └── test_check.yml
    │
    ├── macros/                         # Reusable SQL functions
    │   ├── concat_name.sql             # custom macro for concatenation of two column
    │
    ├── snapshots/                      # SCD Type 2 configurations
    │   ├── sample1_snapshot.sql
    │   ├── sample2_snapshot.sql
    │
    ├── tests/                          # Data quality tests
    |   ├── assesrt_stg_stripe_payment_total_positive
    │   ├── custom_test1.sql
    │
    └── seeds/                          # Static reference data
```

## 🚀 Getting Started

### Prerequisites

1. **Snowflake Account (will create one if doesn't exist)**

2. **Python Environment**
   - Python 3.11 or lesser
   - pip install dbt-snowflake

3. **AWS Account (will create one if doesn't exist) ** (for S3 storage)

### Installation

1. **Clone the Repository**
   ```bash
   git clone <repository-url>
   cd dbt-Snowflake-project
   ```

2. **Create Virtual Environment**
   ```bash
   python -m venv .venv
   .venv\Scripts\Activate.ps1  # Windows PowerShell
   # or
   source .venv/bin/activate    # Linux/Mac
   ```

3. **Install Dependencies**
   ```bash
   pip install -r requirements.txt
   pip install -e .
   ```

   **Core Dependencies:**
   - `dbt-core>=1.11.2`
   - `dbt-snowflake>=1.11.0`
   - `sqlfmt>=0.0.3`

4. **Configure Snowflake Connection**
   
   Create `~/.dbt/profiles.yml`:
   ```yaml
   aws_dbt_snowflake_project:
     outputs:
       dev:
         account: <your-account-identifier>
         database: RAW
         password: <your-password>
         role: <your-role>
         schema: JAFFLE_SHOP
         threads: 1
         type: snowflake
         user: <your-username>
         warehouse: COMPUTE_WH
     target: dev
   ```

5. **Set Up Snowflake Database**
   
   Run the SNOWFLAKE_FILE scripts to create tables:
   ```bash
   # Execute snowflake_file.txt in Snowflake to create staging tables
   ```

6. **Load Source Data**
   
   Load CSV files from `SourceData/` to Snowflake staging schema:
   - `customers.csv` → `RAW.JAFFLE_SHOP.CUSTOMERS`
   - `orders.csv` → `RAW.JAFFLE_SHOP.ORDERS`
   - `payments.csv` → `RAW.STRIPE.PAYMENT`

## 🔧 Usage

### Running dbt Commands

1. **Test Connection**
   ```bash
   cd dbt_snowflake_project
   dbt debug
   ```

2. **Install Dependencies**
   ```bash
   dbt deps
   ```

3. **Run All Models**
   ```bash
   dbt run
   ```

4. **Run Tests**
   ```bash
   dbt test
   ```

5. **Run Snapshots**
   ```bash
   dbt snapshot
   ```

6. **Generate Documentation**
   ```bash
   dbt docs generate
   dbt docs serve
   ```

7. **Build Everything**
   ```bash
   dbt build  # Runs models, tests, and snapshots
   ```

## 🎯 Key Features

### 1. Slowly Changing Dimensions
Track historical changes with timestamp-based snapshots:
- Valid from/to dates automatically maintained
- Historical data preserved for point-in-time analysis


## 📈 Data Quality

### Testing Strategy
- Source data validation tests
- Unique key constraints
- Not null checks
- Referential integrity tests
- Custom business rule tests

### Data Lineage
dbt automatically tracks data lineage, showing:
- Upstream dependencies
- Downstream impacts
- Model relationships
- Source to consumption flow

## 🔐 Security & Best Practices

1. **Credentials Management**
   - Never commit `profiles.yml` with credentials
   - Use environment variables for sensitive data
   - Implement role-based access control (RBAC) in Snowflake

2. **Code Quality**
   - SQL formatting with `sqlfmt`
   - Version control with Git
   - Code reviews for model changes

3. **Performance Optimization**
   - Incremental models for large datasets
   - Ephemeral models for intermediate transformations
   - Appropriate clustering keys in Snowflake

## 🐛 Troubleshooting

### Common Issues

1. **Connection Error**
   - Verify Snowflake credentials in `profiles.yml`
   - Check network connectivity
   - Ensure warehouse is running

2. **Compilation Error**
   - Run `dbt debug` to check configuration
   - Verify model dependencies
   - Check Jinja syntax

3. **Incremental Load Issues**
   - Run `dbt run --full-refresh` to rebuild from scratch
   - Verify source data timestamps

## 📊 Future Enhancements

- [ ] Add data quality dashboards
- [ ] Implement CI/CD pipeline
- [ ] Integrate with BI tools (Tableau/Power BI)