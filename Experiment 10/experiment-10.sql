DROP TABLE IF EXISTS students;
 
CREATE TABLE students (
    id    SERIAL PRIMARY KEY,
    name  VARCHAR(50) NOT NULL UNIQUE,
    age   INT CHECK (age > 0),
    class INT NOT NULL
);

DO $$
BEGIN
    -- insert 1
    BEGIN
        INSERT INTO students(name, age, class) VALUES ('Anisha', 16, 8);
        RAISE NOTICE 'Insert 1 OK: Anisha';
    EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'Insert 1 FAILED (rolled back): %', SQLERRM;
    END;
 
    -- insert 2
    BEGIN
        INSERT INTO students(name, age, class) VALUES ('Mayank', 19, 9);
        RAISE NOTICE 'Insert 2 OK: Mayank';
    EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'Insert 2 FAILED (rolled back): %', SQLERRM;
    END;
 
    -- insert 3: duplicate name, violates UNIQUE
    BEGIN
        INSERT INTO students(name, age, class) VALUES ('Anisha', 17, 8);
        RAISE NOTICE 'Insert 3 OK: Anisha';
    EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'Insert 3 FAILED (rolled back): %', SQLERRM;
    END;
 
    -- insert 4
    BEGIN
        INSERT INTO students(name, age, class) VALUES ('Rohan', 18, 10);
        RAISE NOTICE 'Insert 4 OK: Rohan';
    EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'Insert 4 FAILED (rolled back): %', SQLERRM;
    END;
 
    -- insert 5: negative age, violates CHECK
    BEGIN
        INSERT INTO students(name, age, class) VALUES ('Kabir', -5, 9);
        RAISE NOTICE 'Insert 5 OK: Kabir';
    EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'Insert 5 FAILED (rolled back): %', SQLERRM;
    END;
 
    RAISE NOTICE 'Transaction completed: successful inserts were kept.';
END;
$$;
 
SELECT * FROM students ORDER BY id;
