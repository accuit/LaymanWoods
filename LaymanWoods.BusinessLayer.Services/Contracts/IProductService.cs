﻿using LaymanWoods.CommonLayer.Aspects;
using LaymanWoods.CommonLayer.Aspects.DTO;
using System.Collections.Generic;

namespace LaymanWoods.BusinessLayer.Services.Contracts
{
    public interface IProductService
    {
        List<CategoryMasterDTO> GetAllCategories();
        List<ProductMasterDTO> GetAllProducts();
        List<ProductMasterDTO> GetAllProductsByCategory(string code);

        ProductHelpDTO GetProductHelp(int productID, string code);
        ProductHelpDTO GetCategoryHelp(string code);
    }
}
