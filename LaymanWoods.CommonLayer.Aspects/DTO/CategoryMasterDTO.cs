using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LaymanWoods.CommonLayer.Aspects.DTO
{
    public class CategoryMasterDTO
    {
        public int CategoryID { get; set; }
        public string CategoryName { get; set; }
        public string CategoryCode { get; set; }
        public Nullable<int> CompanyID { get; set; }
    }
}
