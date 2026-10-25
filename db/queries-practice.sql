-- 1. Всѐ оборудование с названием цеха
SELECT e.inventory_number, e.name, w.name AS workshop, e.status
FROM equipment e
JOIN workshops w ON w.id = e.workshop_id
ORDER BY e.inventory_number;
-- 2. Количество заявок по статусам
SELECT status, COUNT(*) AS cnt
FROM work_orders
GROUP BY status
ORDER BY cnt DESC;
-- 3. Топ-3 материала по остатку
SELECT code, name, stock_quantity
FROM materials
ORDER BY stock_quantity DESC
LIMIT 3;
-- 4. Оборудование, не обслуживавшееся > 60 дней
SELECT e.inventory_number, e.name, MAX(wo.actual_end) AS last_to
FROM equipment e
LEFT JOIN work_orders wo
 ON wo.equipment_id = e.id
 AND wo.status IN ('closed','completed')
GROUP BY e.id, e.inventory_number, e.name
HAVING MAX(wo.actual_end) IS NULL
 OR MAX(wo.actual_end) < NOW() - INTERVAL '60 days';
-- 5. Среднее время выполнения закрытых заявок (в часах)
SELECT ROUND(AVG(EXTRACT(EPOCH FROM (actual_end -
actual_start))/3600)::numeric, 2) AS avg_hours
FROM work_orders
WHERE status = 'closed'
 AND actual_start IS NOT NULL
 AND actual_end IS NOT NULL;
