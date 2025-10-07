-- Seed sample users
INSERT INTO users (username, email, age, gender, location, preferences) VALUES
('alice_smith', 'alice@example.com', 28, 'female', 'New York', '{"interests": ["tech", "books", "fitness"]}'),
('bob_jones', 'bob@example.com', 35, 'male', 'San Francisco', '{"interests": ["gaming", "music", "travel"]}'),
('carol_white', 'carol@example.com', 42, 'female', 'Chicago', '{"interests": ["fashion", "food", "art"]}'),
('david_brown', 'david@example.com', 31, 'male', 'Austin', '{"interests": ["sports", "tech", "movies"]}'),
('emma_davis', 'emma@example.com', 26, 'female', 'Seattle', '{"interests": ["books", "coffee", "hiking"]}')
ON CONFLICT (username) DO NOTHING;

-- Seed sample items
INSERT INTO items (item_code, name, category, tags, price, popularity_score) VALUES
('TECH001', 'Wireless Headphones', 'electronics', ARRAY['audio', 'wireless', 'tech'], 99.99, 0.85),
('BOOK001', 'The Great Novel', 'books', ARRAY['fiction', 'bestseller'], 14.99, 0.72),
('FIT001', 'Yoga Mat Premium', 'fitness', ARRAY['exercise', 'wellness'], 29.99, 0.68),
('GAME001', 'Adventure Quest Game', 'gaming', ARRAY['rpg', 'multiplayer'], 59.99, 0.91),
('MUSIC001', 'Bluetooth Speaker', 'electronics', ARRAY['audio', 'portable'], 79.99, 0.78),
('FASHION001', 'Designer Handbag', 'fashion', ARRAY['accessories', 'luxury'], 299.99, 0.65),
('FOOD001', 'Gourmet Coffee Beans', 'food', ARRAY['coffee', 'organic'], 24.99, 0.73),
('SPORT001', 'Basketball Pro', 'sports', ARRAY['outdoor', 'team-sport'], 39.99, 0.70),
('MOVIE001', 'Classic Film Collection', 'entertainment', ARRAY['movies', 'classics'], 49.99, 0.66),
('HIKE001', 'Hiking Backpack', 'outdoor', ARRAY['hiking', 'camping'], 89.99, 0.75)
ON CONFLICT (item_code) DO NOTHING;

-- Seed sample interactions
INSERT INTO interactions (user_id, item_id, interaction_type, interaction_value) VALUES
-- Alice interactions (tech, books, fitness)
(1, 1, 'purchase', 3.0),
(1, 2, 'view', 1.0),
(1, 3, 'click', 2.0),
(1, 5, 'view', 1.0),
-- Bob interactions (gaming, music, travel)
(2, 4, 'purchase', 3.0),
(2, 5, 'purchase', 3.0),
(2, 1, 'click', 2.0),
-- Carol interactions (fashion, food, art)
(3, 6, 'purchase', 3.0),
(3, 7, 'purchase', 3.0),
(3, 2, 'view', 1.0),
-- David interactions (sports, tech, movies)
(4, 8, 'purchase', 3.0),
(4, 1, 'click', 2.0),
(4, 9, 'view', 1.0),
-- Emma interactions (books, coffee, hiking)
(5, 2, 'purchase', 3.0),
(5, 7, 'purchase', 3.0),
(5, 10, 'click', 2.0);
