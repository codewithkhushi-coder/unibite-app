-- UniBite Database Schema (Live Update Mode)
-- Paste this into the Supabase SQL Editor

-- CLEAN SLATE (Optional: Remove if you have production data)
DROP TABLE IF EXISTS public.notifications CASCADE;
DROP TABLE IF EXISTS public.sales_logs CASCADE;
DROP TABLE IF EXISTS public.delivery_assignments CASCADE;
DROP TABLE IF EXISTS public.order_items CASCADE;
DROP TABLE IF EXISTS public.orders CASCADE;
DROP TABLE IF EXISTS public.menu_items CASCADE;
DROP TABLE IF EXISTS public.canteens CASCADE;
DROP TABLE IF EXISTS public.profiles CASCADE;

-- 1. PROFILES
CREATE TABLE public.profiles (
  id UUID REFERENCES auth.users ON DELETE CASCADE PRIMARY KEY,
  role TEXT NOT NULL DEFAULT 'user',
  name TEXT,
  email TEXT,
  phone TEXT,
  hostel_block TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. CANTEENS
CREATE TABLE public.canteens (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  location TEXT,
  university_block TEXT,
  open_status BOOLEAN DEFAULT true,
  avg_prep_time INTEGER DEFAULT 15,
  queue_load TEXT DEFAULT 'low',
  image_url TEXT,
  rating FLOAT8 DEFAULT 4.5,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. MENU ITEMS
CREATE TABLE public.menu_items (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  canteen_id UUID REFERENCES public.canteens(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  category TEXT,
  base_price FLOAT8 NOT NULL, -- Renamed for clarity if needed, or stick to price
  price FLOAT8 NOT NULL,
  prep_time INTEGER DEFAULT 15,
  available BOOLEAN DEFAULT true,
  image_url TEXT,
  description TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 4. ORDERS
CREATE TABLE public.orders (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  customer_id UUID REFERENCES public.profiles(id),
  canteen_id UUID REFERENCES public.canteens(id),
  order_type TEXT NOT NULL DEFAULT 'pickup', -- 'pickup', 'delivery'
  total_amount FLOAT8 NOT NULL,
  status TEXT NOT NULL DEFAULT 'pending', 
  eta INTEGER,
  delivery_location TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 5. ORDER ITEMS
CREATE TABLE public.order_items (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  order_id UUID REFERENCES public.orders(id) ON DELETE CASCADE,
  menu_item_id UUID REFERENCES public.menu_items(id),
  quantity INTEGER NOT NULL DEFAULT 1,
  item_price FLOAT8 NOT NULL
);

-- 6. DELIVERY ASSIGNMENTS
CREATE TABLE public.delivery_assignments (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  order_id UUID REFERENCES public.orders(id) ON DELETE CASCADE,
  delivery_boy_id UUID REFERENCES public.profiles(id),
  current_status TEXT DEFAULT 'assigned',
  live_lat FLOAT8,
  live_lng FLOAT8,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- 7. SALES LOGS
CREATE TABLE public.sales_logs (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  canteen_id UUID REFERENCES public.canteens(id),
  order_id UUID REFERENCES public.orders(id),
  total FLOAT8 NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 8. NOTIFICATIONS
CREATE TABLE public.notifications (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  message TEXT NOT NULL,
  is_read BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- RLS POLICIES
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.canteens ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.menu_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.order_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.delivery_assignments ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.sales_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;

-- Basic Policies
CREATE POLICY "Public profiles are viewable by everyone" ON public.profiles FOR SELECT USING (true);
CREATE POLICY "Users can insert their own profiles" ON public.profiles FOR INSERT WITH CHECK (auth.uid() = id);
CREATE POLICY "Users can update their own profiles" ON public.profiles FOR UPDATE USING (auth.uid() = id);
CREATE POLICY "Canteens are viewable by everyone" ON public.canteens FOR SELECT USING (true);
CREATE POLICY "Menu items are viewable by everyone" ON public.menu_items FOR SELECT USING (true);
CREATE POLICY "Orders are viewable by involved parties" ON public.orders FOR SELECT USING (
  auth.uid() = customer_id OR 
  EXISTS (SELECT 1 FROM public.profiles p WHERE p.id = auth.uid() AND p.role IN ('vendor', 'admin', 'delivery'))
);

-- REALTIME ENABLEMENT
ALTER PUBLICATION supabase_realtime ADD TABLE public.orders;
ALTER PUBLICATION supabase_realtime ADD TABLE public.canteens;
ALTER PUBLICATION supabase_realtime ADD TABLE public.delivery_assignments;
ALTER PUBLICATION supabase_realtime ADD TABLE public.notifications;

-- INDEXES
CREATE INDEX IF NOT EXISTS idx_menu_items_canteen ON public.menu_items(canteen_id);
CREATE INDEX IF NOT EXISTS idx_orders_customer ON public.orders(customer_id);
CREATE INDEX IF NOT EXISTS idx_orders_canteen ON public.orders(canteen_id);
CREATE INDEX IF NOT EXISTS idx_order_items_order ON public.order_items(order_id);
