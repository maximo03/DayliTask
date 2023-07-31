using System.ComponentModel.DataAnnotations;


namespace INFORMES.Models
{
    public class VMTask
    {
    public int IdUser { get; set; }

    [Required]
    public int IdTask { get; set; }
    
    [Required]
    public string TitleTask { get; set; }
    
    [Required]
    public string DescriptionTask { get; set; }

    [Required]
    public string HoursTask { get; set; }

    [DataType(DataType.Date)]
    public DateTime StartDate { get; set; } = DateTime.Today;

    [DataType(DataType.Date)]
    public DateTime CloseDate { get; set; } = DateTime.Today;

    [Required]
    public VMJourney Journey { get; set; } = VMJourney.Ordinaria;

    [Required]
    public string TeamProject { get; set; }
 
    public int MonthTask { get; set; } = 0;
    public int YearTask { get; set; } = 0;
    
    }
}
