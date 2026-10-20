namespace ToirApiPlayground.Models;

public class Equipment
{
    public int Id { get; set; }
    public string InventoryNumber { get; set; } = "";
    public string Name { get; set; } = "";
    public string Model { get; set; } = "";
    public string Status { get; set; } = "in_work";
    public DateTime CommissionDate { get; set; }

    public int GetAgeInDays()
    {
        return (DateTime.Today - CommissionDate).Days;
    }

    public override string ToString()
    {
        return $"{InventoryNumber} | {Name} | {Status} | возраст {GetAgeInDays()} дн.";
    }
}
