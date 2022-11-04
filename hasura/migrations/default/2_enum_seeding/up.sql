INSERT INTO generic_state (value, comment) VALUES
  ('Pending', 'The resource is pending'),
  ('Rejected', 'The resource was rejected'),
  ('Accepted', 'The resource was accepted'),
  ('Canceled', 'The resource was canceled');

INSERT INTO generic_status (value, comment) VALUES
  ('Active', 'The resource is active'),
  ('Inactive', 'The resource is inactive'),
  ('Deleted', 'The resource is deleted');

INSERT INTO media_type (value, comment) VALUES
  ('Image', 'The resource is an image'),
  ('Video', 'The resource is a video'),
  ('File', 'The resource isnt an image or a video');

INSERT INTO notification_topic (value, comment) VALUES
  ('System', 'The notification is about the system');

INSERT INTO notification_type (value, comment) VALUES
  ('Admin', 'Activity that related to admin user'),
  ('System', 'Message from the system or admin site');

INSERT INTO role (value, comment) VALUES
  ('admin', 'Only assigned by the other admin');

INSERT INTO system_announcement_type (value, comment) VALUES
  ('InApp', 'Announcement that will be shown in the app'),
  ('Push_Notification', 'Announcement that will be shown as push notification'),
  ('Email', 'Announcement that will be sent to the user email'),
  ('SMS', 'Announcement that will be sent to the user phone number'),
  ('Push_Notification_And_Email', 'Announcement that will be shown as push notification and sent to the user email'),
  ('Push_Notification_And_SMS', 'Push_Notification_And_SMS'),
  ('Email_And_SMS', 'Announcement that will be sent to the user email and phone number'),
  ('All', 'Announcement that will be shown as push notification, sent to the user email and phone number');

INSERT INTO user_auth_provider (value, comment) VALUES
  ('System', 'The user is registered by the system');

INSERT INTO user_device_type (value, comment) VALUES
  ('Ios', 'The user device is ios'),
  ('Android', 'The user device is android'),
  ('Web', 'The user device is web browser');
