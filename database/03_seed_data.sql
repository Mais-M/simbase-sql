-- SimBase MVP sample data
-- Run this file only once on an empty database

BEGIN;

-- 1. Neighborhoods
INSERT INTO neighborhoods
    (neighborhood_name, description, established_date)
VALUES
    ('Willow Creek', 'A quiet residential neighborhood with parks and family homes.', '1998-05-12'),
    ('Harbor Point', 'A lively coastal district with modern housing.', '2005-09-20'),
    ('Pinecrest Hills', 'A peaceful hillside neighborhood surrounded by nature.', '2001-03-15');


-- 2. Houses
INSERT INTO houses
    (neighborhood_id, address, lot_name, property_value)
VALUES
    (1, '12 Maple Street', 'Maple Cottage', 185000.00),
    (1, '28 Maple Street', 'Willow Residence', 245000.00),
    (2, '7 Ocean Drive', 'Harbor View', 310000.00),
    (2, '18 Harbor Lane', 'Bluewater House', 275000.00),
    (3, '3 Cedar Road', 'Cedar Lodge', 220000.00),
    (3, '22 Hilltop Avenue', 'Pinecrest Villa', 360000.00);


-- 3. Households
INSERT INTO households
    (household_name, household_funds, established_date, is_active)
VALUES
    ('Carter Household', 42000.00, '2011-06-18', TRUE),
    ('Vega Household', 27500.00, '2016-02-11', TRUE),
    ('Bennett Household', 61500.00, '2009-09-03', TRUE),
    ('Kim Household', 38000.00, '2018-04-22', TRUE),
    ('Moreau Household', 24000.00, '2020-07-14', TRUE);


-- 4. Household residence history
INSERT INTO household_residences
    (household_id, house_id, move_in_date, move_out_date)
VALUES
    (1, 1, '2019-01-10', NULL),
    (2, 3, '2021-05-06', NULL),
    (3, 2, '2017-08-19', NULL),
    (4, 5, '2020-11-03', NULL),
    (5, 6, '2022-02-17', NULL);


-- 5. Aspirations
INSERT INTO aspirations
    (aspiration_name, description)
VALUES
    ('Knowledge', 'Focused on learning, research and intellectual development.'),
    ('Family', 'Focused on relationships, family life and emotional stability.'),
    ('Fortune', 'Focused on career growth, income and financial achievement.'),
    ('Popularity', 'Focused on friendships, influence and social connections.'),
    ('Creativity', 'Focused on artistic expression and original work.'),
    ('Wellness', 'Focused on health, balance and personal wellbeing.');


-- 6. Sims
INSERT INTO sims
    (
        household_id,
        aspiration_id,
        first_name,
        last_name,
        age_stage,
        birth_date,
        joined_neighborhood_date,
        is_active
    )
VALUES
    (1, 1, 'Ava', 'Carter', 'adult', '1990-04-18', '2019-01-10', TRUE),
    (1, 3, 'Noah', 'Carter', 'adult', '1988-11-02', '2019-01-10', TRUE),
    (1, 5, 'Lily', 'Carter', 'child', '2015-07-23', '2019-01-10', TRUE),

    (2, 4, 'Sofia', 'Vega', 'young_adult', '2001-03-15', '2021-05-06', TRUE),
    (2, 2, 'Mateo', 'Vega', 'teen', '2008-09-09', '2021-05-06', TRUE),

    (3, 3, 'Ethan', 'Bennett', 'adult', '1986-01-27', '2017-08-19', TRUE),
    (3, 2, 'Chloe', 'Bennett', 'adult', '1989-06-12', '2017-08-19', TRUE),

    (4, 1, 'Mina', 'Kim', 'young_adult', '2000-12-05', '2020-11-03', TRUE),
    (4, 6, 'Daniel', 'Kim', 'elder', '1958-08-30', '2020-11-03', TRUE),

    (5, 5, 'Luc', 'Moreau', 'adult', '1992-02-14', '2022-02-17', TRUE);


-- 7. Careers
INSERT INTO careers
    (career_name, maximum_level)
VALUES
    ('Science', 10),
    ('Technology', 10),
    ('Education', 10),
    ('Arts', 10),
    ('Business', 10);


-- 8. Career history
INSERT INTO career_history
    (
        sim_id,
        career_id,
        career_level,
        salary,
        start_date,
        end_date
    )
VALUES
    (1, 1, 1, 3200.00, '2023-01-01', '2023-12-31'),
    (1, 1, 2, 3900.00, '2024-01-01', NULL),

    (2, 5, 1, 3000.00, '2022-01-01', '2022-06-30'),
    (2, 5, 2, 3600.00, '2022-07-01', '2023-06-30'),
    (2, 5, 3, 4500.00, '2023-07-01', NULL),

    (4, 2, 1, 3500.00, '2024-01-01', NULL),

    (6, 5, 2, 4200.00, '2021-01-01', '2022-12-31'),
    (6, 5, 3, 5200.00, '2023-01-01', NULL),

    (7, 3, 1, 2900.00, '2022-09-01', '2023-08-31'),
    (7, 3, 2, 3400.00, '2023-09-01', NULL),

    (8, 2, 1, 3300.00, '2024-03-01', NULL),

    (10, 4, 1, 2700.00, '2023-05-01', '2024-04-30'),
    (10, 4, 2, 3200.00, '2024-05-01', NULL);


-- 9. Relationships
INSERT INTO relationships
    (
        sim_id_1,
        sim_id_2,
        relationship_type,
        daily_score,
        lifetime_score,
        relationship_start_date,
        is_active
    )
VALUES
    (1, 2, 'married', 90, 95, '2010-06-18', TRUE),
    (1, 3, 'family', 85, 90, '2015-07-23', TRUE),
    (2, 3, 'family', 80, 88, '2015-07-23', TRUE),

    (4, 5, 'family', 75, 82, '2008-09-09', TRUE),

    (6, 7, 'married', 88, 92, '2009-09-03', TRUE),
    (6, 8, 'friend', 60, 58, '2022-04-16', TRUE),
    (7, 8, 'friend', 68, 65, '2022-06-10', TRUE),

    (8, 9, 'family', 78, 85, '2000-12-05', TRUE),
    (4, 8, 'best_friend', 82, 80, '2021-09-12', TRUE),

    (1, 7, 'friend', 55, 60, '2020-02-18', TRUE),
    (2, 6, 'friend', 58, 62, '2019-10-20', TRUE),

    (5, 8, 'acquaintance', 25, 20, '2023-01-11', TRUE),
    (4, 10, 'friend', 70, 68, '2022-08-04', TRUE),
    (8, 10, 'friend', 65, 64, '2022-11-15', TRUE),
    (3, 5, 'friend', 50, 45, '2024-02-01', TRUE);

COMMIT;