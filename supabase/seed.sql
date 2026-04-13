-- UniBite Sample Data (Seed File)
-- Paste this into the Supabase SQL Editor AFTER schema.sql

-- Insert Sample Canteens
INSERT INTO public.canteens (name, location, university_block, open_status, avg_prep_time, queue_load, image_url)
VALUES 
('Main Block Canteen', 'Ground Floor, Main Block', 'Main Block', true, 10, 'low', 'https://images.unsplash.com/photo-1567529854338-fc097b30e738?w=500&q=80'),
('Hostel Night Canteen', 'Near Hostel Mess', 'Hostel Block', true, 15, 'medium', 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=500&q=80');

-- Insert Sample Menu Items (Using subqueries to get canteen IDs)
INSERT INTO public.menu_items (canteen_id, name, category, price, prep_time, available, description)
SELECT id, 'Exam Special Thali', 'Meals', 120, 15, true, 'Full meal with brain-boosting dry fruits and low oil.'
FROM public.canteens WHERE name = 'Main Block Canteen';

INSERT INTO public.menu_items (canteen_id, name, category, price, prep_time, available, description)
SELECT id, 'Budget Student Burger', 'Snacks', 45, 10, true, 'Classic aloo tikki burger for quick energy.'
FROM public.canteens WHERE name = 'Main Block Canteen';

INSERT INTO public.menu_items (canteen_id, name, category, price, prep_time, available, description)
SELECT id, 'Hot Masala Chai', 'Drinks', 15, 5, true, 'Freshly brewed tea to keep you awake.'
FROM public.canteens WHERE name = 'Main Block Canteen';

-- Insert a placeholder profile for the vendor (Manual auth linking required later)
-- Note: id should be a real auth.uid() in production
-- INSERT INTO public.profiles (id, role, name, email) VALUES ('...', 'vendor', 'Main Canteen Vendor', 'vendor@unibite.com');
