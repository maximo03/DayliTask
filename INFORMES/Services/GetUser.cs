using System.Security.Claims;

namespace INFORMES.Services
{
    public interface IGetUser
    {
        int GetUserId();
    }
    public class GetUser: IGetUser
    {
        private readonly HttpContext httpContext;
        public GetUser(IHttpContextAccessor httpContextAccessor)
        {
            httpContext = httpContextAccessor.HttpContext;
        }
        public int GetUserId()
        {
            if (httpContext.User.Identity.IsAuthenticated)
            {
                var idClaim = httpContext.User.Claims.
                          Where(x => x.Type == ClaimTypes.
                          NameIdentifier).FirstOrDefault();
                int id = int.Parse(idClaim.Value);
                return id;
            }
            else
            {
                throw new ApplicationException("The user is dont Authenticated");
            }
        }



    //End Class
    }
}
