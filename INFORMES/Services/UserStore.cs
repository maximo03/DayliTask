using INFORMES.Models;
using Microsoft.AspNetCore.Identity;

namespace INFORMES.Services
{
    public class UserStore : IUserStore<VMUser>, IUserEmailStore<VMUser>, IUserPasswordStore<VMUser>
    {
        private readonly IRepositoryUsers repositoryUsers;

        public UserStore(IRepositoryUsers repositoryUsers)
        {
            this.repositoryUsers = repositoryUsers;
        }

        public async Task<IdentityResult> CreateAsync(VMUser user, CancellationToken cancellationToken)
        {
            user.Id = await repositoryUsers.sp_CreateUser(user);
            return IdentityResult.Success;
        }

        public Task<IdentityResult> DeleteAsync(VMUser user, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public void Dispose()
        {
        }

        public async Task<VMUser> FindByEmailAsync(string normalizedEmail, CancellationToken cancellationToken)
        {
            return await repositoryUsers.sp_SelectUserForEmail(normalizedEmail);
        }

        public Task<VMUser> FindByIdAsync(string userId, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public async Task<VMUser> FindByNameAsync(string normalizedUserName, CancellationToken cancellationToken)
        {
            return await repositoryUsers.sp_SelectUserForEmail(normalizedUserName);
        }

        public Task<string> GetEmailAsync(VMUser user, CancellationToken cancellationToken)
        {
            return Task.FromResult(user.Email);
        }

        public Task<bool> GetEmailConfirmedAsync(VMUser user, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task<string> GetNormalizedEmailAsync(VMUser user, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task<string> GetNormalizedUserNameAsync(VMUser user, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task<string> GetPasswordHashAsync(VMUser user, CancellationToken cancellationToken)
        {
            return Task.FromResult(user.PasswordHash);
        }

        public Task<string> GetUserIdAsync(VMUser user, CancellationToken cancellationToken)
        {
            return Task.FromResult(user.Id.ToString());
        }

        public Task<string> GetUserNameAsync(VMUser user, CancellationToken cancellationToken)
        {
            return Task.FromResult(user.Name);
        }

        public Task<bool> HasPasswordAsync(VMUser user, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task SetEmailAsync(VMUser user, string email, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task SetEmailConfirmedAsync(VMUser user, bool confirmed, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task SetNormalizedEmailAsync(VMUser user, string normalizedEmail, CancellationToken cancellationToken)
        {
            user.EmailNormalized = normalizedEmail;
            return Task.CompletedTask;
        }

        public Task SetNormalizedUserNameAsync(VMUser user, string normalizedName, CancellationToken cancellationToken)
        {
            user.Name = normalizedName;
            return Task.CompletedTask;
        }

        public Task SetPasswordHashAsync(VMUser user, string passwordHash, CancellationToken cancellationToken)
        {
           user.PasswordHash = passwordHash;
            return Task.CompletedTask;
        }

        public Task SetUserNameAsync(VMUser user, string userName, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }

        public Task<IdentityResult> UpdateAsync(VMUser user, CancellationToken cancellationToken)
        {
            throw new NotImplementedException();
        }
    }
}
