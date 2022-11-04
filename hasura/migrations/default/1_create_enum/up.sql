CREATE TABLE generic_state (
  value text PRIMARY KEY,
  comment text
);

CREATE TABLE generic_status (
  value text PRIMARY KEY,
  comment text
);

CREATE TABLE media_type (
  value text PRIMARY KEY,
  comment text
);

CREATE TABLE notification_topic (
  value text PRIMARY KEY,
  comment text
);

CREATE TABLE notification_type (
  value text PRIMARY KEY,
  comment text
);

CREATE TABLE role (
  value text PRIMARY KEY,
  comment text
);

CREATE TABLE system_announcement_type (
  value text PRIMARY KEY,
  comment text
);

CREATE TABLE user_auth_provider (
  value text PRIMARY KEY,
  comment text
);

CREATE TABLE user_device_type (
  value text PRIMARY KEY,
  comment text
);
