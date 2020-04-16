using System.Collections.Generic;

namespace LaymanWoods.PersistenceLayer.Data.EDMX
{
    public class CompleteInteriorListing
    {
        public int InteriorCatgID { get; set; }
        public CategoryMaster Category { get; set; }
        public  List<ProductMaster> Products { get; set; }
        public decimal? Multiplier { get; set; }
        public decimal? Divisor { get; set; }
        public int WebPartType { get; set; }
        public bool isMultiSelect { get; set; }
        public bool IsDefault { get; set; }
    }
}
