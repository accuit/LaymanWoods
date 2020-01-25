using System.Collections.Generic;
using AutoMapper;
using LaymanWoods.BusinessLayer.Services.Contracts;
using LaymanWoods.CommonLayer.Aspects.DTO;
using LaymanWoods.PersistenceLayer.Data.EDMX;
using LaymanWoods.PersistenceLayer.Data.Repository;

namespace LaymanWoods.BusinessLayer.Base.Manager
{


    public class ProductManager : ServiceBase, IProductService
    {
        #region initialize private fields

        [Unity.Dependency(ContainerDataLayerInstanceNames.PRODUCT_REPOSITORY)]
        public IProductRepository ProductRepository { get; set; }
        private readonly IMapper mapper;
        public ProductManager(IMapper mapper)
        {
            this.mapper = mapper;
        }

        #endregion

        public List<CategoryMasterDTO> GetAllCategories()
        {
            List<CategoryMasterDTO> categories = new List<CategoryMasterDTO>();
            List<CategoryMaster> result = ProductRepository.GetAllCategories();
            return mapper.Map<List<CategoryMasterDTO>>(result);
        }

        public List<ProductMasterDTO> GetAllProducts()
        {
            List<ProductMasterDTO> products = new List<ProductMasterDTO>();
            List<ProductMaster> result = ProductRepository.GetAllProducts();
            return mapper.Map<List<ProductMasterDTO>>(result);

        }

        public List<ProductMasterDTO> GetAllProductsByCategory(string code)
        {
            List<ProductMasterDTO> products = new List<ProductMasterDTO>();
            List<ProductMaster> result = ProductRepository.GetAllProductsByCategory(code);
            return mapper.Map<List<ProductMasterDTO>>(result);

        }
    }
}
