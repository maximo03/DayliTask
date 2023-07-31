using INFORMES.Models;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;

namespace INFORMES.Controllers
{
    public class UsersController: Controller
    {
        private readonly UserManager<VMUser> userManager;
        private readonly SignInManager<VMUser> signInManager;

        public UsersController(UserManager<VMUser> userManager, SignInManager<VMUser> signInManager)
        {
            this.userManager = userManager;
            this.signInManager = signInManager;
        }

        [AllowAnonymous]
        public IActionResult Register()
        {
                return View();  
        }

        [HttpPost]
        [AllowAnonymous]
        public async Task<IActionResult> Register(VMRegister model)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }

            VMUser user = new VMUser() { Name = model.Name, Email = model.Email }; 
            var result = await userManager.CreateAsync(user, password: model.Password);

            if (result.Succeeded)
            {
                await signInManager.SignInAsync(user, isPersistent: true);
                return RedirectToAction("Index", "Home");
            }
            else
            {
                foreach (var error in result.Errors)
                {
                    ModelState.AddModelError(string.Empty, error.Description);

                }

                return View(model);
            }

            
        }

        [HttpGet]
        [AllowAnonymous]
        public IActionResult Login()
        {
            return View();
        }

        [HttpPost]
        [AllowAnonymous]
        public async Task<IActionResult> Login(VMLogin model)
        {
            if (!ModelState.IsValid)
            {
                return View(model);
            }

            var resultado = await signInManager.PasswordSignInAsync(model.Email,
                     model.Password, model.RememberMe, lockoutOnFailure: false);
            if (resultado.Succeeded)
            {
                return RedirectToAction("Index", "Home");
            }
            else
            {
                ModelState.AddModelError(string.Empty, "Nombre de usuario o contraseña incorrecto.");
                return View(model);
            }
        }





        [HttpPost]
        public async Task<IActionResult> Logout()
        {
            await HttpContext.SignOutAsync(IdentityConstants.ApplicationScheme);
            return RedirectToAction("Index","Home");
        }

    //End Class
    }
}
