CREATE EXTENSION citext;

CREATE TABLE "user_account" (
  "user_profile_id" bigint PRIMARY KEY,
  "username" varchar(128) UNIQUE NOT NULL,
  "password_hash" char (60) NOT NULL,
  "hash_algorithm_id" int UNIQUE,
  "email" citext UNIQUE NOT NULL,
  "confirmation_token" varchar(100),
  "token_generation_time" timestamptz,
  "email_validation_status_id" int,
  "password_recovery_token" varchar(100),
  "password_recovery_expire" timestamptz,
  "user_status_id" int
);

CREATE TABLE "user_profile" (
  "id" BIGSERIAL PRIMARY KEY,
  "firstname" varchar(128),
  "lastname" varchar(128),
  "gender" char (1),
  "rating" int NOT NULL DEFAULT 10,
  "date_of_birth" timestamptz NOT NULL,
  "role_id" int,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "hashing_algorithm" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar(10) NOT NULL
);

CREATE TABLE "user_status" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar(64) NOT NULL
);

CREATE TABLE "external_providers" (
  "id" SERIAL PRIMARY KEY,
  "provider_name" varchar(50) NOT NULL,
  "endpoint" varchar(100)
);

CREATE TABLE "user_account_external" (
  "user_profile_id" bigint PRIMARY KEY,
  "provider_token" varchar(100) NOT NULL,
  "provider_id" int
);

CREATE TABLE "email_validation_status" (
  "id" SERIAL PRIMARY KEY,
  "status" varchar(32) NOT NULL
);

CREATE INDEX ON "user_account" ("username");

CREATE INDEX ON "user_account" ("email");

CREATE INDEX ON "user_account" ("user_profile_id");

CREATE INDEX ON "user_profile" ("id");
