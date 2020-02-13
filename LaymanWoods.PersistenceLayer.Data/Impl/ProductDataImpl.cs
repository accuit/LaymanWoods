﻿using System.Collections.Generic;
using System.Linq;
using LaymanWoods.PersistenceLayer.Data.EDMX;
using LaymanWoods.PersistenceLayer.Data.Repository;

namespace LaymanWoods.PersistenceLayer.Data.Impl
{
    public class ProductDataImpl : BaseDataImpl, IProductRepository
    {
        public List<CategoryMaster> GetAllCategories()
        {
            return LaymanWoodsDbContext.CategoryMasters.ToList();
        }

        public List<ProductMaster> GetAllProducts()
        {
            return LaymanWoodsDbContext.ProductMasters.Where(x => !x.IsDeleted && x.IsActive).ToList();

        }

        public List<ProductMaster> GetAllProductsByCategory(string code)
        {
            return LaymanWoodsDbContext.ProductMasters.Where(x => x.CategoryCode == code && !x.IsDeleted && x.IsActive).ToList();
        }

        public ProductHelp GetCategoryHelp(string code)
        {
            return LaymanWoodsDbContext.ProductHelps.Where(x => !x.IsDeleted && x.CategoryCode == code).FirstOrDefault();
        }

        public ProductHelp GetProductHelp(int productID, string code)
        {
            return LaymanWoodsDbContext.ProductHelps.Where(x => !x.IsDeleted && (x.ProductID == productID || x.CategoryCode == code)).FirstOrDefault();
        }
    }
}
