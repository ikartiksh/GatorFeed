-- +goose Up
ALTER TABLE feeds ADD COLUMN LAST_FETCHED_AT TIMESTAMP;

-- +goose Down
ALTER TABLE users DROP COLUMN last_fetched_at;