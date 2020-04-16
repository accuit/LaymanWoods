using LaymanWoods.PersistenceLayer.Data.EDMX;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LaymanWoods.PersistenceLayer.Data.Impl
{
    public abstract class BaseDataImpl
    {
        private LaymanWoodsModel laymanWoodsDbContext;

        #region Constructors

        /// <summary>
        /// Constructor to intialize database instance for EF
        /// </summary>
        public BaseDataImpl()
        {
            laymanWoodsDbContext = new LaymanWoodsModel();
        }

        #endregion

        /// <summary>
        /// Property to get db context instance of Entity Framework Database
        /// </summary>
        public LaymanWoodsModel DbContext
        {
            get
            {
                return laymanWoodsDbContext;
            }
        }
    }
}
