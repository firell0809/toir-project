using ToirApiPlayground.Models;

var equipment = new List<Equipment>
{
    new() { Id = 1, InventoryNumber = "EQ-001", Name = "Токарный станок", 
            Model = "16К20", Status = "in_work", CommissionDate = new DateTime(2018, 3, 15) },
    new() { Id = 2, InventoryNumber = "EQ-002", Name = "Фрезерный станок", 
            Model = "6Р13Ф3", Status = "in_work", CommissionDate = new DateTime(2019, 7, 20) },
    new() { Id = 3, InventoryNumber = "EQ-003", Name = "Расточной станок", 
            Model = "2М614", Status = "in_repair", CommissionDate = new DateTime(2017, 11, 10) },
    new() { Id = 4, InventoryNumber = "EQ-004", Name = "Шлифовальный станок", 
            Model = "3У131М", Status = "in_work", CommissionDate = new DateTime(2020, 4, 5) },
    new() { Id = 5, InventoryNumber = "EQ-005", Name = "Координатно-расточной", 
            Model = "2Е450", Status = "idle", CommissionDate = new DateTime(2016, 9, 12) }
};

Console.WriteLine("=== Всё оборудование ===");
foreach (var e in equipment)
    Console.WriteLine(e);

Console.WriteLine();
Console.WriteLine("=== Только в ремонте ===");
foreach (var e in equipment.Where(x => x.Status == "in_repair"))
    Console.WriteLine(e);

Console.WriteLine();
Console.WriteLine("=== Сортировка по дате ввода ===");
foreach (var e in equipment.OrderBy(x => x.CommissionDate))
    Console.WriteLine($"{e.CommissionDate:yyyy-MM-dd} | {e.Name}");
