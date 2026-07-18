-- Stores the fictional neighborhoods in the SimBase system
CREATE TABLE neighborhoods (
    neighborhood_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    neighborhood_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    established_date DATE
);
-- Stores the houses located in each neighborhood
CREATE TABLE houses (
    house_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    neighborhood_id INTEGER NOT NULL,
    address VARCHAR(150) NOT NULL,
    lot_name VARCHAR(100) NOT NULL,
    property_value NUMERIC(12, 2) NOT NULL
        CHECK (property_value >= 0),

    CONSTRAINT fk_houses_neighborhood
        FOREIGN KEY (neighborhood_id)
        REFERENCES neighborhoods(neighborhood_id),

    CONSTRAINT uq_house_address
        UNIQUE (neighborhood_id, address)
);
-- Stores the households living in the simulated neighborhoods
CREATE TABLE households (
    household_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    household_name VARCHAR(100) NOT NULL,
    household_funds NUMERIC(12, 2) NOT NULL DEFAULT 0
        CHECK (household_funds >= 0),
    established_date DATE,
    is_active BOOLEAN NOT NULL DEFAULT TRUE
);
-- Tracks where each household lived over time
CREATE TABLE household_residences (
    residence_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    household_id INTEGER NOT NULL,
    house_id INTEGER NOT NULL,
    move_in_date DATE NOT NULL,
    move_out_date DATE,

    CONSTRAINT fk_residence_household
        FOREIGN KEY (household_id)
        REFERENCES households(household_id),

    CONSTRAINT fk_residence_house
        FOREIGN KEY (house_id)
        REFERENCES houses(house_id),

    CONSTRAINT chk_residence_dates
        CHECK (
            move_out_date IS NULL
            OR move_out_date >= move_in_date
        ),

    CONSTRAINT uq_household_residence
        UNIQUE (household_id, house_id, move_in_date)
);
-- Stores the possible life aspirations of Sims
CREATE TABLE aspirations (
    aspiration_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    aspiration_name VARCHAR(80) NOT NULL UNIQUE,
    description TEXT
);
-- Stores the Sims living in the fictional neighborhoods
CREATE TABLE sims (
    sim_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    household_id INTEGER NOT NULL,
    aspiration_id INTEGER,
    first_name VARCHAR(80) NOT NULL,
    last_name VARCHAR(80) NOT NULL,
    age_stage VARCHAR(20) NOT NULL,
    birth_date DATE,
    joined_neighborhood_date DATE NOT NULL DEFAULT CURRENT_DATE,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    CONSTRAINT fk_sims_household
        FOREIGN KEY (household_id)
        REFERENCES households(household_id),

    CONSTRAINT fk_sims_aspiration
        FOREIGN KEY (aspiration_id)
        REFERENCES aspirations(aspiration_id),

    CONSTRAINT chk_sims_age_stage
        CHECK (
            age_stage IN (
                'baby',
                'toddler',
                'child',
                'teen',
                'young_adult',
                'adult',
                'elder'
            )
        )
);