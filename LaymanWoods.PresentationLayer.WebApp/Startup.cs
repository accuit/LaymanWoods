using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(LaymanWoods.PresentationLayer.WebApp.Startup))]
namespace LaymanWoods.PresentationLayer.WebApp
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }

    }
}