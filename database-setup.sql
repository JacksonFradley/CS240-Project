CREATE TABLE IF NOT EXISTS users (
    id SERIAL,
    name varchar(255) NOT NULL,
    PRIMARY KEY (id));

CREATE TABLE IF NOT EXISTS waitlist (
    id SERIAL,
    user int NOT NULL,
    next int,
    PRIMARY KEY (id),
    FOREIGN KEY tool REFERENCES tools (id) ON DELETE CASCADE,
    FOREIGN KEY user REFERENCES users (id),
    FOREIGN KEY next REFERENCES waitlist (id) ON DELETE CASCADE);

CREATE TABLE IF NOT EXISTS tools (
    id SERIAL,
    name varchar(255) NOT NULL,
    -- more fields such as description can go here
    is_checked_out boolean NOT NULL DEFAULT false,
    next int, -- the person who either has the tool (if is_checked_out) or will get it next
    PRIMARY KEY (id),
    FOREIGN KEY next REFERENCES waitlist (id) ON DELETE SET NULL);

-- Whenever the `next` value changes, `is_checked_out` is set to false
CREATE TRIGGER reset_checkout
    BEFORE UPDATE ON tools
    FOR EACH ROW
    WHEN NEW.next IS DISTINCT FROM OLD.next
    SET NEW.is_checked_out = false;