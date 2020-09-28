DROP TABLE IF EXISTS films, persons, persons2content;
CREATE TABLE
films (
    title VARCHAR UNIQUE NOT NULL,
    id serial PRIMARY KEY,
    country VARCHAR (20) NOT NULL,
    box_office INT NOT NULL,
    release_date DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE
persons (
    id serial PRIMARY KEY,
    fio VARCHAR (255) NOT NULL 
);

CREATE TABLE
persons2content (
    person_id INT NOT NULL,
    film_id INT NOT NULL,
    person_type VARCHAR (20) NOT NULL,
    FOREIGN KEY (person_id) 
      REFERENCES persons(id),
    FOREIGN KEY (film_id)
      REFERENCES films(id)
);
INSERT INTO 
    persons (fio)
VALUES
    ('David Colson'),
    ('Christopher Nolan'),
    ('Ric Roman Waugh'),
    ('Janik Fayziev'),
    ('Pedro Luque');

INSERT INTO 
    films (title, country, box_office, release_date)
VALUES
    ('Mulan', 'USA/China/Canada', 57000000, '2020-09-03'),
    ('Tenet', 'UK', 251100000, '2020-08-22'),
    ('Greenland', 'UK/USA', 13600000, '2020-07-29'),
    ('Galaxy Goalkeeper', 'Russia', 2300000, '2020-08-27'),
    ('Antebellum', 'USA', 1039912, '2020-09-02');

INSERT INTO 
    persons2content VALUES
    (1, 1, 'Montage'),
    (2, 2, 'Film Director'),
    (3, 3, 'Film Director'),
    (4, 4, 'Film Direcot'),
    (5, 5, 'Operator');