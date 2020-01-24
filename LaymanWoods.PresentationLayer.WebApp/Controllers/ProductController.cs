using LaymanWoods.CommonLayer.Aspects.DTO;
using LaymanWoods.CommonLayer.Aspects;
using System;
using System.Web.Http;
using LaymanWoods.CommonLayer.Aspects.Utilities;
using System.Collections.Generic;
using LaymanWoods.BusinessLayer.Services.BO;

namespace LaymanWoods.PresentationLayer.WebApp.Controllers
{
    [RoutePrefix("api/product")]
    public class ProductController : BaseAPIController
    {
        [Route("getProductsList")]
        [HttpGet]
        public JsonResponse<List<ProductMasterDTO>> GetAllProducts()
        {
            JsonResponse<List<ProductMasterDTO>> response = new JsonResponse<List<ProductMasterDTO>>();
            response.SingleResult = ProductBusinessInstance.GetAllProducts(); //.Where(x => x.cemailaddress == email && x.cpassword == password).FirstOrDefault();
            response.IsSuccess = true;
            return response;
        }

        [Route("productsByCategory/{code}")]
        [HttpGet]
        public JsonResponse<List<ProductMasterDTO>> GetProductsByCategory(string code)
        {
            JsonResponse<List<ProductMasterDTO>> response = new JsonResponse<List<ProductMasterDTO>>();
            response.SingleResult = ProductBusinessInstance.GetAllProductsByCategory(code); //.Where(x => x.cemailaddress == email && x.cpassword == password).FirstOrDefault();
            response.IsSuccess = true;
            return response;
        }
    }
}
