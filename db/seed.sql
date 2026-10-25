-- Цеха
INSERT INTO workshops (name, code) VALUES
('Механосборочный цех', 'МСЦ'),
('Сварочно-термический цех', 'СТЦ'),
('Электротехнический цех', 'ЭТЦ');

-- Оборудование
INSERT INTO equipment (inventory_number, name, model, workshop_id, commission_date, status) VALUES
('EQ-001', 'Токарно-винторезный станок', '16К20', 1, '2018-03-15', 'in_work'),
('EQ-002', 'Вертикально-фрезерный станок', '6Р13Ф3', 1, '2019-07-20', 'in_work'),
('EQ-003', 'Горизонтально-расточной станок', '2М614', 1, '2017-11-10', 'in_repair'),
('EQ-004', 'Круглошлифовальный станок', '3У131М', 1, '2020-04-05', 'in_work'),
('EQ-005', 'Координатно-расточной станок', '2Е450', 1, '2016-09-12', 'idle');

-- Виды ТО
INSERT INTO maintenance_types (code, name, period_days, duration_hours, requires_shutdown) VALUES
('ТО-1', 'Ежемесячное ТО', 30, 4, FALSE),
('ТО-2', 'Квартальное ТО', 90, 8, FALSE),
('ТО-3', 'Полугодовое ТО', 180, 16, TRUE),
('ТО-4', 'Годовое ТО', 365, 32, TRUE);

-- Пользователи (пароль для всех: password123, хеш заменим позже)
INSERT INTO users (email, password_hash, full_name, role, workshop_id) VALUES
('master@pmz.ru', 'TEMP_HASH', 'Иванов Иван Иванович', 'master', 1),
('brigadier@pmz.ru', 'TEMP_HASH', 'Петров Пѐтр Петрович', 'brigadier', 1),
('engineer@pmz.ru', 'TEMP_HASH', 'Белов Игорь Анатольевич', 'engineer', NULL),
('manager@pmz.ru', 'TEMP_HASH', 'Громов Виктор Васильевич', 'manager', NULL),
('admin@pmz.ru', 'TEMP_HASH', 'Администратор системы', 'admin', NULL);

-- Бригады
INSERT INTO brigades (code, name, specialization, workshop_id) VALUES
('BR-1', 'Бригада №1', 'Механики-ремонтники', 1),
('BR-2', 'Бригада №2', 'Электрики-сварщики', 2),
('BR-3', 'Бригада №3', 'Электромонтѐры', 3);

-- Материалы
INSERT INTO materials (code, name, unit, stock_quantity, min_quantity, storage_location, price) VALUES
('М-001', 'Масло индустриальное И-20', 'л', 200, 50, 'Склад №3', 150.00),
('М-002', 'Смазка Литол-24', 'кг', 80, 20, 'Склад №3', 320.00),
('М-003', 'Фильтр масляный', 'шт', 15, 5, 'Склад №1', 850.00),
('М-004', 'Ремень приводной', 'шт', 10, 3, 'Склад №1', 1200.00),
('М-005', 'Подшипник 6-205', 'шт', 50, 15, 'Склад №2', 850.00);

-- Заявки
INSERT INTO work_orders (number, equipment_id, type, priority, status, description, master_id, created_at) VALUES
('Z-2026-0001', 1, 'emergency', 'critical', 'closed', 'Оборвался ремень привода, заклинило шпиндель', 1, '2026-09-01 10:00:00'),
('Z-2026-0002', 2, 'planned', 'medium', 'in_progress', 'Плановое ТО-1 по графику', 1, '2026-09-15 08:00:00'),
('Z-2026-0003', 3, 'emergency', 'high', 'assigned', 'Заклинило шпиндель', 1, '2026-09-20 14:00:00'),
('Z-2026-0004', 1, 'planned', 'low', 'created', 'Плановое ТО-2', 1, '2026-09-25 09:00:00'),
('Z-2026-0005', 4, 'current', 'medium', 'completed', 'Замена смазки', 1, '2026-09-28 11:00:00');
