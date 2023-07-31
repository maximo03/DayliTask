using System.ComponentModel.DataAnnotations;

namespace INFORMES.Models
{
    public class VMRegister
    {

        [Required(ErrorMessage = "The {0} field is required")]
        [Display(Name = "Full Name")]
        public string Name { get; set; }

        [Required]
        [EmailAddress(ErrorMessage = "The Email is invalid")]
        public string Email { get; set; }

        [Required(ErrorMessage = "The {0} field is required")]
        [DataType(DataType.Password)]
        public string Password { get; set; }
    }
}
