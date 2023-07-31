using Dapper;
using INFORMES.Models;
using Microsoft.Data.SqlClient;

namespace INFORMES.Services
{
    public interface IRepositoryUsers
    {
        Task<VMUser> sp_SelectUserForEmail(string EmailNormalized);
        Task<int> sp_CreateUser(VMUser model);
    }
    public class RepositoryUsers: IRepositoryUsers
    {
        private readonly string connectionString;
        public RepositoryUsers(IConfiguration configuration)
        {
            connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        public async Task<int> sp_CreateUser(VMUser model)
        {
            SqlConnection connection = new SqlConnection(connectionString);
            var id = await connection.QuerySingleAsync<int>(@"SP_InsertUser",
                                        new { Name = model.Name, Email = model.Email,
                                              EmailNormalized = model.EmailNormalized,
                                              PasswordHash = model.PasswordHash },
                                              commandType: System.Data.CommandType.StoredProcedure);
            return id;
        }




        public async Task<VMUser> sp_SelectUserForEmail(string EmailNormalized)
        {
            SqlConnection connection = new SqlConnection(connectionString);
            return await connection.QuerySingleOrDefaultAsync<VMUser>(
               @"SELECT * FROM Users WHERE EmailNormalized=@EmailNormalized",
               new { EmailNormalized });

        }

        //End Class
    }
}
