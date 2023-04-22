CREATE TABLE tool (
    id UUID NOT NULL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255),
    category VARCHAR(255),
    storage_location VARCHAR(255),
)