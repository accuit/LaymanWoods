using System.Collections.Generic;
using System.Linq;
using LaymanWoods.PersistenceLayer.Data.EDMX;
using LaymanWoods.PersistenceLayer.Data.Repository;

namespace LaymanWoods.PersistenceLayer.Data.Impl
{
    public class ProductDataImpl : BaseDataImpl, IProductRepository
    {
        public List<ProductMaster> GetAllProducts()
        {
            return LaymanWoodsDbContext.ProductMasters.Where(x=>!x.IsDeleted).ToList();
            
        }

        public List<ProductMaster> GetAllProductsByCategory(string code)
        {
            return LaymanWoodsDbContext.ProductMasters.Where(x=>x.CategoryCode == code).ToList();
        }
    }
}
