DROP DATABASE IF EXISTS toir_db;
CREATE DATABASE toir_db;

-- Справочник цехов
CREATE TABLE workshops (
 id SERIAL PRIMARY KEY,
 name VARCHAR(100) NOT NULL UNIQUE,
 code VARCHAR(20) NOT NULL UNIQUE
);
-- Оборудование
CREATE TABLE equipment (
 id SERIAL PRIMARY KEY,
 inventory_number VARCHAR(50) NOT NULL UNIQUE,
 name VARCHAR(200) NOT NULL,
 model VARCHAR(100),
 serial_number VARCHAR(100),
 workshop_id INTEGER NOT NULL REFERENCES workshops(id) ON DELETE
RESTRICT,
 commission_date DATE NOT NULL,
 start_operation_date DATE,
 manufacturer VARCHAR(200),
 warranty_until DATE,
 status VARCHAR(30) NOT NULL
 CHECK (status IN
('in_work','in_repair','idle','decommissioned')),
 created_at TIMESTAMP NOT NULL DEFAULT NOW(),
 updated_at TIMESTAMP,
 created_by INTEGER,
 updated_by INTEGER,
 CHECK (start_operation_date IS NULL OR start_operation_date >=
commission_date)
);
-- Виды ТО
CREATE TABLE maintenance_types (
 id SERIAL PRIMARY KEY,
 code VARCHAR(20) NOT NULL UNIQUE,
 name VARCHAR(100) NOT NULL,
 description TEXT,
 period_days INTEGER NOT NULL CHECK (period_days > 0),
 duration_hours INTEGER NOT NULL CHECK (duration_hours > 0),
 requires_shutdown BOOLEAN NOT NULL DEFAULT FALSE
);
-- Пользователи
CREATE TABLE users (
 id SERIAL PRIMARY KEY,
 email VARCHAR(200) NOT NULL UNIQUE,
 password_hash VARCHAR(500) NOT NULL,
 full_name VARCHAR(200) NOT NULL,
 role VARCHAR(30) NOT NULL
 CHECK (role IN
('master','brigadier','engineer','manager','admin')),
 workshop_id INTEGER REFERENCES workshops(id),
 is_active BOOLEAN NOT NULL DEFAULT TRUE,
 created_at TIMESTAMP NOT NULL DEFAULT NOW()
);
-- Бригады
CREATE TABLE brigades (
 id SERIAL PRIMARY KEY,
 code VARCHAR(20) NOT NULL UNIQUE,
 name VARCHAR(100) NOT NULL,
 specialization VARCHAR(100),
 workshop_id INTEGER REFERENCES workshops(id)
);
-- Заявки
CREATE TABLE work_orders (
 id SERIAL PRIMARY KEY,
 number VARCHAR(30) NOT NULL UNIQUE,
 equipment_id INTEGER NOT NULL REFERENCES equipment(id) ON DELETE
RESTRICT,
 type VARCHAR(20) NOT NULL CHECK (type IN
('planned','emergency','current')),
 priority VARCHAR(20) NOT NULL CHECK (priority IN
('low','medium','high','critical')),
 status VARCHAR(30) NOT NULL
 CHECK (status IN
('created','assigned','in_progress','waiting_parts','completed','close
d','cancelled')),
 description TEXT NOT NULL CHECK (LENGTH(description) <= 500),
 reason TEXT,
 brigade_id INTEGER REFERENCES brigades(id),
 master_id INTEGER NOT NULL REFERENCES users(id),
 created_at TIMESTAMP NOT NULL DEFAULT NOW(),
 planned_start TIMESTAMP,
 planned_end TIMESTAMP,
 actual_start TIMESTAMP,
 actual_end TIMESTAMP,
 -- Все три CHECK учитывают NULL:
 CHECK (planned_start IS NULL OR planned_end IS NULL OR planned_end
> planned_start),
 CHECK (actual_start IS NULL OR actual_end IS NULL OR actual_end >
actual_start),
 CHECK (type <> 'emergency' OR reason IS NOT NULL)
);
-- Материалы
CREATE TABLE materials (
 id SERIAL PRIMARY KEY,
 code VARCHAR(30) NOT NULL UNIQUE,
 name VARCHAR(200) NOT NULL,
 unit VARCHAR(20) NOT NULL,
 stock_quantity NUMERIC(10,2) NOT NULL DEFAULT 0 CHECK
(stock_quantity >= 0),
 min_quantity NUMERIC(10,2) NOT NULL DEFAULT 0,
 storage_location VARCHAR(100),
 price NUMERIC(10,2) NOT NULL CHECK (price >= 0)
);
-- Списание материалов
CREATE TABLE material_usages (
 id SERIAL PRIMARY KEY,
 work_order_id INTEGER NOT NULL REFERENCES work_orders(id) ON
DELETE CASCADE,
 material_id INTEGER NOT NULL REFERENCES materials(id) ON DELETE
RESTRICT,
 quantity NUMERIC(10,2) NOT NULL CHECK (quantity > 0),
 price_at_usage NUMERIC(10,2) NOT NULL,
 used_at TIMESTAMP NOT NULL DEFAULT NOW()
);
-- Индексы для частых запросов
CREATE INDEX idx_equipment_workshop ON equipment(workshop_id);
CREATE INDEX idx_equipment_status ON equipment(status);
CREATE INDEX idx_work_orders_status ON work_orders(status);
CREATE INDEX idx_work_orders_equipment ON work_orders(equipment_id);