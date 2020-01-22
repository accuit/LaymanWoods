using System;


namespace LaymanWoods.CommonLayer.Aspects.DTO
{
    public class ProductMasterDTO
    {
        public int ProductID { get; set; }
        public Nullable<int> CompanyID { get; set; }
        public string ProductTypeCode { get; set; }
        public string ProductTypeName { get; set; }
        public string ProductGroupCode { get; set; }
        public string ProductGroupName { get; set; }
        public string CategoryCode { get; set; }
        public string CategoryName { get; set; }
        public string BasicModelCode { get; set; }
        public string BasicModelName { get; set; }
        public string SKUCode { get; set; }
        public string SKUName { get; set; }
        public Nullable<decimal> MRP { get; set; }
        public Nullable<decimal> DealerPrice { get; set; }
        public System.DateTime CreatedDate { get; set; }
        public int CreatedBy { get; set; }
        public Nullable<System.DateTime> ModifiedDate { get; set; }
        public string ModifiedBy { get; set; }
        public bool IsDeleted { get; set; }
        public bool IsActive { get; set; }
    }
}
