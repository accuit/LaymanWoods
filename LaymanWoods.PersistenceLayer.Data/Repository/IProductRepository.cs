using LaymanWoods.CommonLayer.Aspects;
using LaymanWoods.PersistenceLayer.Data.EDMX;
using System.Collections.Generic;

namespace LaymanWoods.PersistenceLayer.Data.Repository
{
    public interface IProductRepository
    {
        List<ProductMaster> GetAllProducts();
        List<ProductMaster> GetAllProductsByCategory(string code);
    }
}
