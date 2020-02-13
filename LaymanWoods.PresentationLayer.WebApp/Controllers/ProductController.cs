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
        [Route("getCategories")]
        [HttpGet]
        public JsonResponse<List<CategoryMasterDTO>> GetAllCategories()
        {
            JsonResponse<List<CategoryMasterDTO>> response = new JsonResponse<List<CategoryMasterDTO>>();
            response.SingleResult = ProductBusinessInstance.GetAllCategories(); //.Where(x => x.cemailaddress == email && x.cpassword == password).FirstOrDefault();
            response.IsSuccess = true;
            return response;
        }

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

        [Route("productHelp/{code}/{id}")]
        [HttpGet]
        public JsonResponse<ProductHelpDTO> GetProductHelpByID(string code, int? id = 0)
        {
            JsonResponse<ProductHelpDTO> response = new JsonResponse<ProductHelpDTO>();
            try
            {

                response.SingleResult = ProductBusinessInstance.GetProductHelp((int)id, code);
                response.IsSuccess = true;
                response.StatusCode = "200";
            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.StatusCode = "500";
                response.Message = ex.Message;
            }

            return response;
        }

        [Route("productHelpByCatg/{id}")]
        [HttpGet]
        public JsonResponse<ProductHelpDTO> GetProductHelpByCatgID(string code)
        {
            JsonResponse<ProductHelpDTO> response = new JsonResponse<ProductHelpDTO>();
            response.SingleResult = ProductBusinessInstance.GetCategoryHelp(code);
            response.IsSuccess = true;
            return response;
        }
    }
}
