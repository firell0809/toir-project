namespace ToirApiPlayground.Models;

public class WorkOrder
{
    public int Id { get; set; }
    public string Number { get; set; } = "";
    public int EquipmentId { get; set; }
    public string Type { get; set; } = "planned";
    public string Priority { get; set; } = "medium";
    public string Status { get; set; } = "created";
    public string Description { get; set; } = "";
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
}
