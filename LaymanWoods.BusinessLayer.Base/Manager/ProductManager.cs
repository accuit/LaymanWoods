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
        [Unity.Dependency(ContainerDataLayerInstanceNames.PRODUCT_REPOSITORY)]
        public IProductRepository ProductRepository { get; set; }
        private readonly IMapper mapper;
        public ProductManager(IMapper mapper)
        {
            this.mapper = mapper;
        }

        public List<ProductMasterDTO> GetAllProducts()
        {
            List<ProductMasterDTO> products = new List<ProductMasterDTO>();
            List<ProductMaster> result = ProductRepository.GetAllProducts();
            products = mapper.Map<List<ProductMasterDTO>>(result);

            return mapper.Map<List<ProductMasterDTO>>(result);
        }

        public List<ProductMasterDTO> GetAllProductsByCategory(string code)
        {
            List<ProductMasterDTO> products = new List<ProductMasterDTO>();
            List<ProductMaster> result = ProductRepository.GetAllProductsByCategory(code);
            products = mapper.Map<List<ProductMasterDTO>>(result);

            return mapper.Map<List<ProductMasterDTO>>(result);
        }
    }
}
