using LaymanWoods.CommonLayer.Aspects;
using LaymanWoods.PersistenceLayer.Data.EDMX;
using System.Collections.Generic;

namespace LaymanWoods.PersistenceLayer.Data.Repository
{
    public interface IProductRepository
    {
        List<InteriorCategory> GetInteriorCategories();
        List<CompleteInteriorListing> GetInteriorCategoryMapping(int id);
        List<CategoryMaster> GetAllCategories();
        List<ProductMaster> GetAllProducts();
        List<ProductMaster> GetAllProductsByCategory(string code);

        ProductHelp GetProductHelp(int productID, string code);
        ProductHelp GetCategoryHelp(string code);

    }
}
