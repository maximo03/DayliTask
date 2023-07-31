using System.ComponentModel.DataAnnotations;

namespace INFORMES.Models
{
    public class VMLogin
    {

        [Required]
        [EmailAddress(ErrorMessage = "The Email is invalid")]
        public string Email { get; set; }

        [Required(ErrorMessage = "The {0} field is required")]
        [DataType(DataType.Password)]
        public string Password { get; set; }
        public bool RememberMe { get; set; }
    }
}
