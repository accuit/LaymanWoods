//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace LaymanWoods.PersistenceLayer.Data.EDMX
{
    using System;
    using System.Collections.Generic;
    
    public partial class traderwishlist
    {
        public int lwishlistid { get; set; }
        public Nullable<int> ltraderid { get; set; }
        public Nullable<int> lproductid { get; set; }
        public Nullable<System.DateTime> dentrydatetime { get; set; }
        public Nullable<byte> bstatus { get; set; }
        public Nullable<byte> bdeleteflag { get; set; }
        public Nullable<int> lquantity { get; set; }
        public Nullable<double> lprice { get; set; }
    }
}
