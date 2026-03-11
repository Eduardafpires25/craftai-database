-- CraftAI Seed Data
-- Insert sample data for testing and demonstration

-- Insert sample users
INSERT INTO users (name, email, password_hash, role) VALUES
('John Customer', 'customer@example.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa', 'CUSTOMER'), -- password: password123
('Jane Seller', 'seller@example.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa', 'SELLER'), -- password: password123
('Admin User', 'admin@example.com', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iKTVEFDa', 'ADMIN'); -- password: password123

-- Insert sample stores
INSERT INTO stores (name, description, owner_user_id) VALUES
('Crafty Creations', 'Custom handmade crafts and personalized gifts', (SELECT id FROM users WHERE email = 'seller@example.com')),
('Artisan Workshop', 'Bespoke artistic creations and custom designs', (SELECT id FROM users WHERE email = 'seller@example.com'));

-- Insert sample product categories
INSERT INTO product_categories (name, description) VALUES
('T-Shirts', 'Custom printed t-shirts and apparel'),
('Mugs', 'Personalized coffee mugs and drinkware'),
('Phone Cases', 'Custom phone cases and accessories'),
('Posters', 'Custom posters and wall art'),
('Accessories', 'Various custom accessories and items'),
('Home Decor', 'Personalized home decoration items');

-- Insert sample custom projects
INSERT INTO custom_projects (user_id, store_id, category_id, title, description, style, color_palette, size, notes, status) VALUES
((SELECT id FROM users WHERE email = 'customer@example.com'), 
 (SELECT id FROM stores WHERE name = 'Crafty Creations'),
 (SELECT id FROM product_categories WHERE name = 'T-Shirts'),
 'Custom Nature T-Shirt',
 'A t-shirt featuring a beautiful mountain landscape with pine trees and a sunset',
 'Naturalistic',
 'Green, Blue, Orange',
 'Large',
 'Make the mountains look majestic and peaceful',
 'DRAFT'),

((SELECT id FROM users WHERE email = 'customer@example.com'), 
 (SELECT id FROM stores WHERE name = 'Crafty Creations'),
 (SELECT id FROM product_categories WHERE name = 'Mugs'),
 'Personalized Coffee Mug',
 'A coffee mug with my name "Sarah" and cat illustrations',
 'Cute and playful',
 'Pink, White, Black',
 'Standard',
 'Add small paw prints around the name',
 'GENERATED'),

((SELECT id FROM users WHERE email = 'customer@example.com'), 
 (SELECT id FROM stores WHERE name = 'Artisan Workshop'),
 (SELECT id FROM product_categories WHERE name = 'Phone Cases'),
 'Minimalist Phone Case',
 'A clean, minimalist phone case with geometric patterns',
 'Modern minimalist',
 'Black, White, Gold',
 'iPhone 14 Pro',
 'Keep it simple and elegant',
 'APPROVED');

-- Insert sample generated previews
INSERT INTO generated_previews (project_id, image_url, prompt_used, version_number, generation_status) VALUES
((SELECT id FROM custom_projects WHERE title = 'Custom Nature T-Shirt'),
 'https://picsum.photos/seed/nature-tshirt-1/400/400.jpg',
 'A beautiful mountain landscape with pine trees and sunset on a t-shirt, naturalistic style, green blue orange colors',
 1,
 'COMPLETED'),

((SELECT id FROM custom_projects WHERE title = 'Personalized Coffee Mug'),
 'https://picsum.photos/seed/coffee-mug-1/400/400.jpg',
 'A coffee mug with name "Sarah" and cat illustrations, cute and playful style, pink white black colors',
 1,
 'COMPLETED'),

((SELECT id FROM custom_projects WHERE title = 'Personalized Coffee Mug'),
 'https://picsum.photos/seed/coffee-mug-2/400/400.jpg',
 'A coffee mug with name "Sarah" and cat illustrations with paw prints, cute and playful style, pink white black colors',
 2,
 'COMPLETED'),

((SELECT id FROM custom_projects WHERE title = 'Minimalist Phone Case'),
 'https://picsum.photos/seed/minimalist-case-1/400/400.jpg',
 'A clean minimalist phone case with geometric patterns, modern minimalist style, black white gold colors',
 1,
 'COMPLETED');

-- Update approved preview for approved project
UPDATE custom_projects 
SET approved_preview_id = (SELECT id FROM generated_previews WHERE project_id = (SELECT id FROM custom_projects WHERE title = 'Minimalist Phone Case') AND version_number = 1)
WHERE title = 'Minimalist Phone Case';

-- Insert sample orders
INSERT INTO orders (project_id, user_id, store_id, status, total_price) VALUES
((SELECT id FROM custom_projects WHERE title = 'Minimalist Phone Case'),
 (SELECT id FROM users WHERE email = 'customer@example.com'),
 (SELECT id FROM stores WHERE name = 'Artisan Workshop'),
 'CONFIRMED',
 29.99),

((SELECT id FROM custom_projects WHERE title = 'Personalized Coffee Mug'),
 (SELECT id FROM users WHERE email = 'customer@example.com'),
 (SELECT id FROM stores WHERE name = 'Crafty Creations'),
 'IN_PROGRESS',
 14.99);

-- Update project status for projects with orders
UPDATE custom_projects 
SET status = 'ORDER_CREATED'
WHERE id IN ((SELECT id FROM custom_projects WHERE title = 'Minimalist Phone Case'),
             (SELECT id FROM custom_projects WHERE title = 'Personalized Coffee Mug'));

COMMIT;
