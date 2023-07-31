namespace INFORMES.Models
{
    public class VMUser
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
        public string EmailNormalized { get; set; }
        public string PasswordHash { get; set; }
    }
}
