-- =========================================
-- RESET DATA
-- =========================================
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE product;
TRUNCATE TABLE brand;
TRUNCATE TABLE category;
TRUNCATE TABLE voucher;
TRUNCATE TABLE roles;
SET FOREIGN_KEY_CHECKS = 1;



INSERT INTO roles (id, name) VALUES
(1, 'ADMIN'),
(2, 'USER');

-- =========================================
-- INSERT DATA FOR CATEGORY
-- =========================================
INSERT INTO category (id, code, name) VALUES
(1, 'CLO', 'Clothing'),
(2, 'SHO', 'Shoes'),
(3, 'RAC', 'Rackets'),
(4, 'ACC', 'Accessories');

-- =========================================
-- INSERT DATA FOR BRAND
-- =========================================
INSERT INTO brand (id, name) VALUES
(1, 'Nike'),
(2, 'Adidas'),
(3, 'Yonex'),
(4, 'Li-Ning'),
(5, 'Decathlon');

-- =========================================
-- INSERT DATA FOR PRODUCT (80 PRODUCTS + IMAGE)
-- =========================================
INSERT INTO product (id, name, description, price, stock_quantity, category_id, brand_id, image) VALUES
(1, 'Nike Dri-FIT T-Shirt', 'Moisture-wicking fabric keeps you dry during workouts.', 450000, 120, 1, 1, 'CLO1.jpg'),
(2, 'Adidas Climacool Jacket', 'Lightweight and breathable jacket for outdoor training.', 650000, 80, 1, 2, 'CLO2.jpg'),
(3, 'Li-Ning Sports Shorts', 'Stretchy, soft shorts for gym or basketball.', 300000, 150, 1, 4, 'CLO3.jpg'),
(4, 'Decathlon Training Pants', 'Elastic, soft, and comfortable for running.', 350000, 90, 1, 5, 'CLO4.jpg'),
(5, 'Yonex CoolFit Tank Top', 'Smooth fabric with anti-bacterial properties.', 400000, 100, 1, 3, 'CLO5.jpg'),

(6, 'Nike Air Zoom Running Shoes', 'Air-cushioned sole for comfort and shock absorption.', 2200000, 60, 2, 1, 'SHO6.jpg'),
(7, 'Adidas Harden Vol.6 Basketball Shoes', 'Designed for agility and explosive jumps.', 2600000, 40, 2, 2, 'SHO7.jpg'),
(8, 'Yonex Aerus Z Badminton Shoes', 'Ultra-lightweight shoes for speed and control.', 2800000, 30, 2, 3, 'SHO8.jpg'),
(9, 'Li-Ning Pro Court Tennis Shoes', 'Anti-slip sole and heel protection.', 2400000, 45, 2, 4, 'SHO9.jpg'),
(10, 'Decathlon WalkEasy Shoes', 'Comfortable, breathable walking shoes.', 1200000, 70, 2, 5, 'SHO10.jpg'),

(11, 'Yonex Astrox 88D Badminton Racket', 'Enhanced power and precision with Namd technology.', 3500000, 25, 3, 3, 'RAC11.jpg'),
(12, 'Li-Ning Turbo Charging 75 Racket', 'Carbon frame with strong repulsion.', 3200000, 20, 3, 4, 'RAC12.jpg'),
(13, 'Decathlon TR990 Tennis Racket', 'Carbon frame for intermediate players.', 2900000, 15, 3, 5, 'RAC13.jpg'),
(14, 'Adidas Kalkul A5 Racket', 'Balanced racket suitable for offense and defense.', 2700000, 25, 3, 2, 'RAC14.jpg'),
(15, 'Nike Speed Shot Racket', 'Aerodynamic design for maximum swing speed.', 3100000, 18, 3, 1, 'RAC15.jpg'),

(16, 'Decathlon Water Bottle', '750ml leak-proof and easy-to-clean sports bottle.', 150000, 200, 4, 5, 'ACC16.jpg'),
(17, 'Nike Gym Bag', 'Water-resistant gym bag with separate shoe compartment.', 250000, 100, 4, 1, 'ACC17.jpg'),
(18, 'Adidas Wristband', 'Elastic and sweat-absorbing wristband.', 90000, 300, 4, 2, 'ACC18.jpg'),
(19, 'Yonex 3-Compartment Sports Bag', 'Spacious and moisture-resistant sports bag.', 550000, 60, 4, 3, 'ACC19.jpg'),
(20, 'Li-Ning Headband', 'Stretchable headband that keeps hair in place.', 80000, 250, 4, 4, 'ACC20.jpg'),

(21, 'Nike Training Hoodie', 'Soft fleece hoodie for warmth during workouts.', 650000, 80, 1, 1, 'CLO21.jpg'),
(22, 'Adidas Performance Polo', 'Breathable polo shirt with quick-dry tech.', 500000, 120, 1, 2, 'CLO22.jpg'),
(23, 'Yonex Court Shorts', 'Designed for full range of motion and comfort.', 350000, 100, 1, 3, 'CLO23.jpg'),
(24, 'Li-Ning Warm-Up Jacket', 'Lightweight, stretchable warm-up jacket.', 600000, 75, 1, 4, 'CLO24.jpg'),
(25, 'Decathlon QuickDry Tee', 'Affordable and breathable T-shirt for sports.', 250000, 180, 1, 5, 'CLO25.jpg'),

(26, 'Nike Training Pants', 'Slim-fit pants with elastic waistband.', 550000, 100, 1, 1, 'CLO26.jpg'),
(27, 'Adidas Studio Tank', 'Comfortable cotton blend for gym workouts.', 400000, 90, 1, 2, 'CLO27.jpg'),
(28, 'Yonex Pro Jersey', 'Moisture-wicking jersey for athletes.', 500000, 60, 1, 3, 'CLO28.jpg'),
(29, 'Li-Ning Game Shorts', 'Breathable mesh shorts for training.', 300000, 140, 1, 4, 'CLO29.jpg'),
(30, 'Decathlon Yoga Pants', 'Stretch fabric for comfort and movement.', 320000, 200, 1, 5, 'CLO30.jpg'),

(31, 'Nike Dri-FIT Long Sleeve', 'UV protection and cooling fabric.', 480000, 110, 1, 1, 'CLO31.jpg'),
(32, 'Adidas Cotton Hoodie', 'Classic hoodie with front pocket.', 600000, 80, 1, 2, 'CLO32.jpg'),
(33, 'Yonex Warm Jersey', 'Soft material for training in cold weather.', 550000, 70, 1, 3, 'CLO33.jpg'),
(34, 'Li-Ning Sport Tee', 'Durable, lightweight, and stylish.', 420000, 150, 1, 4, 'CLO34.jpg'),
(35, 'Decathlon Sports Bra', 'Supportive fit for high-intensity training.', 300000, 130, 1, 5, 'CLO35.jpg'),

(36, 'Nike Air Max Trainer', 'Cushioned sole for ultimate comfort.', 2300000, 50, 2, 1, 'SHO36.jpg'),
(37, 'Adidas Ultraboost Light', 'Responsive cushioning for long runs.', 2800000, 60, 2, 2, 'SHO37.jpg'),
(38, 'Yonex Eclipsion Z2', 'Stability and traction for court play.', 2900000, 35, 2, 3, 'SHO38.jpg'),
(39, 'Li-Ning Sonic Boom', 'Powerful grip with lightweight design.', 2500000, 45, 2, 4, 'SHO39.jpg'),
(40, 'Decathlon RunActive Shoes', 'Affordable running shoes with arch support.', 1100000, 80, 2, 5, 'SHO40.jpg'),

(41, 'Nike Court Lite', 'Durable tennis shoes for training.', 1800000, 55, 2, 1, 'SHO41.jpg'),
(42, 'Adidas Cross Trainer', 'Multi-purpose shoes for fitness and gym.', 1900000, 70, 2, 2, 'SHO42.jpg'),
(43, 'Yonex FusionRev 5', 'Superior cushioning and foot stability.', 3000000, 30, 2, 3, 'SHO43.jpg'),
(44, 'Li-Ning PowerStride', 'Supportive midsole and breathable mesh.', 2200000, 50, 2, 4, 'SHO44.jpg'),
(45, 'Decathlon Kids Run 100', 'Light and comfy running shoes for kids.', 600000, 90, 2, 5, 'SHO45.jpg'),

(46, 'Nike Zoom Freak 5', 'Basketball shoes for explosive moves.', 2600000, 40, 2, 1, 'SHO46.jpg'),
(47, 'Adidas Supernova', 'Designed for daily runners.', 2100000, 65, 2, 2, 'SHO47.jpg'),
(48, 'Yonex Comfort Z3', 'Professional badminton shoes.', 2700000, 25, 2, 3, 'SHO48.jpg'),
(49, 'Li-Ning Cloud Drive', 'Excellent shock absorption.', 2400000, 35, 2, 4, 'SHO49.jpg'),
(50, 'Decathlon Hiking Boots', 'Water-resistant boots for outdoor trips.', 1600000, 50, 2, 5, 'SHO50.jpg'),

(51, 'Nike Storm Pro Racket', 'Lightweight design for beginners.', 2500000, 25, 3, 1, 'RAC51.jpg'),
(52, 'Adidas Carbon Smash', 'High elasticity shaft for power shots.', 2800000, 30, 3, 2, 'RAC52.jpg'),
(53, 'Yonex Nanoflare 700', 'Lightweight control-oriented racket.', 3200000, 22, 3, 3, 'RAC53.jpg'),
(54, 'Li-Ning Windstorm 72', 'Flexible shaft for fast swings.', 3100000, 20, 3, 4, 'RAC54.jpg'),
(55, 'Decathlon SoftFeel 900', 'Ideal for intermediate tennis players.', 2500000, 18, 3, 5, 'RAC55.jpg'),

(56, 'Nike Blade Shot', 'Enhanced speed and balance.', 3000000, 15, 3, 1, 'RAC56.jpg'),
(57, 'Adidas Spin Pro', 'High control with reinforced frame.', 2800000, 25, 3, 2, 'RAC57.jpg'),
(58, 'Yonex Astrox 99 Pro', 'Maximum power and control combination.', 3600000, 20, 3, 3, 'RAC58.jpg'),
(59, 'Li-Ning Turbo X90', 'Carbon graphite construction.', 3300000, 15, 3, 4, 'RAC59.jpg'),
(60, 'Decathlon TR560 Racket', 'For beginner-friendly play.', 2000000, 35, 3, 5, 'RAC60.jpg'),

(61, 'Nike Drive Control', 'Precision-oriented badminton racket.', 3100000, 12, 3, 1, 'RAC61.jpg'),
(62, 'Adidas Boost Racket', 'Extra tension and aerodynamic frame.', 2700000, 18, 3, 2, 'RAC62.jpg'),
(63, 'Yonex Duora 10', 'Dual optimum system for attack & defense.', 3700000, 16, 3, 3, 'RAC63.jpg'),
(64, 'Li-Ning Super Force', 'Enhanced stiffness for powerful hits.', 3400000, 20, 3, 4, 'RAC64.jpg'),
(65, 'Decathlon Speed 930', 'Entry-level racket for casual players.', 1800000, 30, 3, 5, 'RAC65.jpg'),

(66, 'Nike Water Bottle Pro', 'Durable stainless steel design.', 220000, 150, 4, 1, 'ACC66.jpg'),
(67, 'Adidas Headband Duo', 'Soft and stretchy material.', 100000, 200, 4, 2, 'ACC67.jpg'),
(68, 'Yonex Grip Tape Pack', 'Anti-slip grips for rackets.', 120000, 180, 4, 3, 'ACC68.jpg'),
(69, 'Li-Ning Arm Sleeve', 'Compression sleeve for muscle support.', 150000, 160, 4, 4, 'ACC69.jpg'),
(70, 'Decathlon Gym Gloves', 'Comfortable gloves for lifting.', 180000, 190, 4, 5, 'ACC70.jpg'),

(71, 'Nike Duffel Bag', 'Spacious sports bag with multiple pockets.', 400000, 100, 4, 1, 'ACC71.jpg'),
(72, 'Adidas Cap', 'Adjustable cotton sports cap.', 250000, 120, 4, 2, 'ACC72.jpg'),
(73, 'Yonex Socks Set', 'Breathable sports socks, pack of 3.', 90000, 220, 4, 3, 'ACC73.jpg'),
(74, 'Li-Ning Sports Bottle', '600ml BPA-free bottle.', 130000, 170, 4, 4, 'ACC74.jpg'),
(75, 'Decathlon Sports Towel', 'Quick-drying microfiber towel.', 140000, 200, 4, 5, 'ACC75.jpg'),

(76, 'Nike Training Belt', 'Support belt for weightlifting.', 350000, 60, 4, 1, 'ACC76.jpg'),
(77, 'Adidas Gym Mat', 'Non-slip mat for yoga and stretching.', 300000, 80, 4, 2, 'ACC77.jpg'),
(78, 'Yonex Backpack', 'Compact backpack for rackets and gear.', 450000, 90, 4, 3, 'ACC78.jpg'),
(79, 'Li-Ning Wrist Support', 'Elastic support for wrists.', 120000, 150, 4, 4, 'ACC79.jpg'),
(80, 'Decathlon Running Armband', 'Holds your phone securely while running.', 160000, 130, 4, 5, 'ACC80.jpg');


-- =========================================
-- INSERT DATA FOR VOUCHER
-- =========================================

INSERT INTO voucher (code, description, discount_type, discount_value) VALUES
('SALE10', '10% off all products', 'percentage', 10),
('SALE20', '20% off all products', 'percentage', 20),
('FIX500', 'Instant 500,000 VND off any order', 'fixed_amount', 500000),
('FIX100', '100,000 VND off any order', 'fixed_amount', 100000),
('FREESHIP', 'Free shipping nationwide', 'freeship', NULL),
('WELCOME10', '10% discount for new users', 'percentage', 10);