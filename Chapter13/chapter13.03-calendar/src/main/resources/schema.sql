-- In Spring Boot using Spring Data, we use ~/src/main/resources/schema.sql to create the database schema.
-- We no longer have to use ~/src/main/resources/database/h2/calendar-schema.sql to create the database schema.

-- *** NOTE: We are going to use the following property:
-- "jpa.database-platform.hibernate.ddl-auto=none"
-- Otherwise adding ddl here would fail when loading data with data.sql

CREATE TABLE calendar_users (
  id         INTEGER GENERATED BY DEFAULT AS IDENTITY,
  email      VARCHAR(255),
  first_name VARCHAR(255),
  last_name  VARCHAR(255),
  password   VARCHAR(255),
  PRIMARY KEY (id)
);
CREATE TABLE events (
  id          INTEGER GENERATED BY DEFAULT AS IDENTITY,
  description VARCHAR(255) NOT NULL,
  summary     VARCHAR(255) NOT NULL,
  when        TIMESTAMP    NOT NULL,
  attendee    INTEGER,
  owner       INTEGER      NOT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE role (
  id   INTEGER GENERATED BY DEFAULT AS IDENTITY,
  name VARCHAR(255),
  PRIMARY KEY (id)
);
CREATE TABLE user_role (
  user_id INTEGER NOT NULL,
  role_id INTEGER NOT NULL,
  PRIMARY KEY (user_id, role_id)
);
ALTER TABLE events
  ADD CONSTRAINT FKlaq5j62pjejbqud229wxlo3fl FOREIGN KEY (attendee) REFERENCES calendar_users;
ALTER TABLE events
  ADD CONSTRAINT FKq6wxpkh9gqbuv84078vcpk3hb FOREIGN KEY (owner) REFERENCES calendar_users;
ALTER TABLE user_role
  ADD CONSTRAINT FKa68196081fvovjhkek5m97n3y FOREIGN KEY (role_id) REFERENCES role;
ALTER TABLE user_role
  ADD CONSTRAINT FKk4h0gth5yu5wecm1u27cmff1b FOREIGN KEY (user_id) REFERENCES calendar_users;

--- Remember-me Services ---
create table persistent_logins (
    username varchar_ignorecase(50) not null,
    series varchar(64) primary key,
    token varchar(64) not null,
    last_used timestamp not null
);

-- Security Filter Metadata --
create table security_filtermetadata (
  id          INTEGER GENERATED BY DEFAULT AS IDENTITY,
  ant_pattern VARCHAR(1024) NOT NULL unique,
  expression  VARCHAR(1024) NOT NULL,
  sort_order  INTEGER NOT NULL,
  PRIMARY KEY (id)
);

-- the end --
