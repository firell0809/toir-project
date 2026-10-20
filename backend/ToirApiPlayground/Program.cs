Console.WriteLine("Привет, ТОиР-Проф!");
var name = "Иванов И.И.";
var role = "мастер";
var equipmentCount = 5;

Console.WriteLine($"Пользователь: {name}");
Console.WriteLine($"Роль: {role}");
Console.WriteLine($"Количество оборудования: {equipmentCount}");

// Простой расчёт
var start = new DateTime(2026, 8, 1, 10, 0, 0);
var end = new DateTime(2026, 8, 3, 16, 0, 0);
var hours = (end - start).TotalHours;
Console.WriteLine($"Простой: {hours} часов");
