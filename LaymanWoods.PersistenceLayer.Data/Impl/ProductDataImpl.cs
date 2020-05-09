using System.Collections.Generic;
using System.Linq;
using LaymanWoods.PersistenceLayer.Data.EDMX;
using LaymanWoods.PersistenceLayer.Data.Repository;

namespace LaymanWoods.PersistenceLayer.Data.Impl
{
    public class ProductDataImpl : BaseDataImpl, IProductRepository
    {
        public List<InteriorCategory> GetInteriorCategories()
        {
            DbContext.Configuration.LazyLoadingEnabled = true;
            return DbContext.InteriorCategories
                .Include("InteriorProducts")
                .Where(x => !x.IsDeleted)
                .ToList();
        }

        public List<CompleteInteriorListing> GetInteriorCategoryMapping(int id)
        {
            var data = (from m in DbContext.InteriorAndCategoryMappings
                       join c in DbContext.CategoryMasters.Include("ProductMasters") on m.CategoryCode equals c.CategoryCode
                       where m.InteriorID == id && m.IsDeleted == false
                       select new CompleteInteriorListing
                       {
                           InteriorCatgID = m.InteriorID,
                           Category = c,
                           Products = c.ProductMasters.Where(x => !x.IsDeleted).ToList(),
                           Multiplier = m.Multiplier,
                           Divisor = m.Divisor,
                           WebPartType = m.WebPartType,
                           isMultiSelect = m.isMultiSelect,
                           IsDefault = m.IsDefault
                       }).ToList();


            return data.ToList();

        }
        public List<CategoryMaster> GetAllCategories()
        {
            DbContext.Configuration.LazyLoadingEnabled = true;
            return DbContext.CategoryMasters
                .Include("ProductMasters")
                 .ToList();
        }

        public List<ProductMaster> GetAllProducts()
        {
            return DbContext.ProductMasters.Where(x => !x.IsDeleted && x.IsActive).ToList();

        }

        public List<ProductMaster> GetAllProductsByCategory(string code)
        {
            return DbContext.ProductMasters.Where(x => x.CategoryCode == code && !x.IsDeleted && x.IsActive).ToList();
        }

        public ProductHelp GetCategoryHelp(string code)
        {
            return DbContext.ProductHelps.Where(x => !x.IsDeleted && x.CategoryCode == code).FirstOrDefault();
        }

        public ProductHelp GetProductHelp(int productID, string code)
        {
            return DbContext.ProductHelps.Where(x => !x.IsDeleted && (x.ProductID == productID || x.CategoryCode == code)).FirstOrDefault();
        }
    }
}
