# SimBase: SQL Social Intelligence System

SimBase is a PostgreSQL portfolio project that models a fictional simulated neighborhood as a normalized relational database.

The project demonstrates relational database design, data integrity, historical data modeling, social-network analysis, SQL joins, Common Table Expressions, aggregate functions, correlated subqueries, and window functions.

## Project Objectives

The purpose of SimBase is to demonstrate how a relational database can represent a complex fictional social environment.

The database includes information about:

- Fictional Sims
- Households
- Houses
- Neighborhoods
- Household residence history
- Aspirations
- Career tracks
- Career progression
- Social relationships

## Technologies

- PostgreSQL 18
- pgAdmin 4
- SQL
- Visual Studio Code
- Git
- GitHub

## Database Structure

The current version contains nine normalized tables:

1. `neighborhoods`
2. `houses`
3. `households`
4. `household_residences`
5. `aspirations`
6. `sims`
7. `careers`
8. `career_history`
9. `relationships`

The database uses:

- Primary keys
- Foreign keys
- Unique constraints
- Check constraints
- Default values
- Historical tables
- One-to-many relationships
- Relationships between records from the same table

## Sample Data

The fictional dataset currently includes:

- 3 neighborhoods
- 6 houses
- 5 households
- 10 Sims
- 6 aspirations
- 5 career tracks
- 13 career-history records
- 15 social relationships

All names, locations, households, and records were created specifically for this project.

## SQL Skills Demonstrated

- Relational database design
- Database normalization
- Primary and foreign keys
- One-to-many relationships
- Historical data modeling
- Self-referencing social relationships
- `INNER JOIN`
- `LEFT JOIN`
- Common Table Expressions
- `UNION ALL`
- Aggregate functions
- Conditional analysis with `CASE`
- Correlated subqueries
- Window functions
- `LAG`
- `DENSE_RANK`
- `PARTITION BY`
- Temporal analysis
- Social-network analysis

## Analytical Questions

The SQL queries in this project examine questions such as:

- Who are the most socially connected Sims?
- How many active relationships does each Sim have?
- Which Sims have the fewest social connections?
- How has each Sim progressed through their career?
- Who earns more than the average salary in their career?
- How do current salaries rank within each career?
- Where does each household currently live?
- How do relationship scores differ by relationship type?

## Example Analysis

One of the main analytical queries creates a complete relationship network by examining both sides of every relationship.

Because each relationship contains two Sims, the query uses `UNION ALL` to represent connections from both directions.

It then counts the number of unique connections for each Sim and ranks the Sims from the most connected to the least connected.

## Project Structure

```text
simbase-sql/
├── README.md
├── database/
│   ├── 01_create_database.sql
│   ├── 02_schema.sql
│   └── 03_seed_data.sql
└── queries/
    └── 01_analysis.sql
    How to Run the Project
Install PostgreSQL and pgAdmin.
Create a PostgreSQL database named simbase_db.
Open the Query Tool in pgAdmin.
Run the SQL code from database/02_schema.sql to create the tables.
Run database/03_seed_data.sql once to insert the fictional sample data.
Run the queries from queries/01_analysis.sql.

The seed-data file should be executed only once on an empty version of the database.

Data Integrity

The database includes several rules that protect the quality of the data.

Examples include:

Property values cannot be negative.
Household funds cannot be negative.
Career levels must be between 1 and 10.
Relationship scores must be between -100 and 100.
A Sim cannot have a relationship with themselves.
The same pair of Sims cannot be entered twice.
A residence move-out date cannot occur before the move-in date.
A career end date cannot occur before the career start date.
Limitations

The dataset is fictional and intentionally small.

It was created to demonstrate SQL, relational-database design, and analytical methods. It should not be used to draw conclusions about real people or real social behavior.

Relationships between variables in the dataset should not be interpreted as evidence of causation.

The analytical results are also influenced by the way the fictional sample data was designed.

Future Development

Possible future extensions include:

Skills and Sim-skills tables
Wants and fears
Relationship-history tracking
Life events
Additional data-quality tests
Views and indexes
A Streamlit dashboard
Visual social-network analysis
A machine-learning model for career promotion
A model for identifying possible social-isolation risk
Explainability and fairness analysis for future predictions
Disclaimer

This is an independent educational portfolio project.

It is not affiliated with, sponsored by, or endorsed by Electronic Arts or The Sims franchise.

All data, names, locations, and records used in this project are fictional and original.