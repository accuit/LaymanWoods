namespace LaymanWoods.PersistenceLayer.Data.EDMX
{
    using System;
    using System.Data.Entity;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Linq;

    public partial class LaymanWoodsModel : DbContext
    {
        public LaymanWoodsModel()
            : base("name=LaymanWoodsDBContext")
        {
        }

        public virtual DbSet<C__MigrationHistory> MigrationHistory { get; set; }
        public virtual DbSet<CategoryMaster> CategoryMasters { get; set; }
        public virtual DbSet<CommonSetup> CommonSetups { get; set; }
        public virtual DbSet<Email> Emails { get; set; }
        public virtual DbSet<EmailTemplate> EmailTemplates { get; set; }
        public virtual DbSet<InteriorAndCategoryMapping> InteriorAndCategoryMappings { get; set; }
        public virtual DbSet<InteriorCategory> InteriorCategories { get; set; }
        public virtual DbSet<InteriorProduct> InteriorProducts { get; set; }
        public virtual DbSet<OTPMaster> OTPMasters { get; set; }
        public virtual DbSet<ProductHelp> ProductHelps { get; set; }
        public virtual DbSet<ProductMaster> ProductMasters { get; set; }
        public virtual DbSet<UserMaster> UserMasters { get; set; }
        public virtual DbSet<DictionaryEncryptDecrypt> DictionaryEncryptDecrypts { get; set; }
        public virtual DbSet<ContactEnquiry> ContactEnquiries { get; set; }
        public virtual DbSet<EntrepreneurEnquiry> EntrepreneurEnquiries { get; set; }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            Database.SetInitializer<LaymanWoodsModel>(null);
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<CategoryMaster>()
                .Property(e => e.CategoryName)
                .IsUnicode(false);

            modelBuilder.Entity<CategoryMaster>()
                .Property(e => e.CategoryCode)
                .IsUnicode(false);

            modelBuilder.Entity<CategoryMaster>()
                .HasMany(e => e.ProductMasters)
                .WithRequired(e => e.CategoryMaster)
                .WillCascadeOnDelete(false);

            modelBuilder.Entity<InteriorCategory>()
            .HasMany(e => e.InteriorProducts)
            .WithRequired(e => e.InteriorCategory)
            .WillCascadeOnDelete(false);

            modelBuilder.Entity<CommonSetup>()
                .Property(e => e.MainType)
                .IsUnicode(false);

            modelBuilder.Entity<CommonSetup>()
                .Property(e => e.SubType)
                .IsUnicode(false);

            modelBuilder.Entity<CommonSetup>()
                .Property(e => e.DisplayText)
                .IsUnicode(false);

            modelBuilder.Entity<CommonSetup>()
                .Property(e => e.Description)
                .IsUnicode(false);

            modelBuilder.Entity<Email>()
                .Property(e => e.FirstName)
                .IsUnicode(false);

            modelBuilder.Entity<Email>()
                .Property(e => e.LastName)
                .IsUnicode(false);

            modelBuilder.Entity<Email>()
                .Property(e => e.Mobile)
                .IsUnicode(false);

            modelBuilder.Entity<Email>()
                .Property(e => e.EmailAddress)
                .IsUnicode(false);

            modelBuilder.Entity<Email>()
                .Property(e => e.Message)
                .IsUnicode(false);

            modelBuilder.Entity<Email>()
                .Property(e => e.Address)
                .IsUnicode(false);

            modelBuilder.Entity<Email>()
                .Property(e => e.Pincode)
                .IsUnicode(false);

            modelBuilder.Entity<EmailTemplate>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<EmailTemplate>()
                .Property(e => e.Body)
                .IsUnicode(false);

            modelBuilder.Entity<EmailTemplate>()
                .Property(e => e.Subject)
                .IsUnicode(false);

            modelBuilder.Entity<InteriorAndCategoryMapping>()
                .Property(e => e.CategoryCode)
                .IsUnicode(false);

            modelBuilder.Entity<InteriorCategory>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<InteriorCategory>()
                .Property(e => e.Title)
                .IsUnicode(false);

            modelBuilder.Entity<InteriorCategory>()
                .Property(e => e.Image)
                .IsUnicode(false);

            modelBuilder.Entity<InteriorProduct>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<InteriorProduct>()
                .Property(e => e.Title)
                .IsUnicode(false);

            modelBuilder.Entity<InteriorProduct>()
                .Property(e => e.Image)
                .IsUnicode(false);

            modelBuilder.Entity<OTPMaster>()
                .Property(e => e.GUID)
                .IsUnicode(false);

            modelBuilder.Entity<OTPMaster>()
                .Property(e => e.OTP)
                .IsUnicode(false);

            modelBuilder.Entity<ProductHelp>()
                .Property(e => e.Title)
                .IsUnicode(false);

            modelBuilder.Entity<ProductHelp>()
                .Property(e => e.ImageUrl)
                .IsUnicode(false);

            modelBuilder.Entity<ProductHelp>()
                .Property(e => e.Description)
                .IsUnicode(false);

            modelBuilder.Entity<ProductHelp>()
                .Property(e => e.AdditionalInfo)
                .IsUnicode(false);

            modelBuilder.Entity<ProductHelp>()
                .Property(e => e.Specification)
                .IsUnicode(false);

            modelBuilder.Entity<ProductHelp>()
                .Property(e => e.CategoryCode)
                .IsUnicode(false);

            modelBuilder.Entity<ProductMaster>()
                .Property(e => e.Name)
                .IsUnicode(false);

            modelBuilder.Entity<ProductMaster>()
                .Property(e => e.Title)
                .IsUnicode(false);

            modelBuilder.Entity<ProductMaster>()
                .Property(e => e.ImageUrl)
                .IsUnicode(false);

            modelBuilder.Entity<ProductMaster>()
                .Property(e => e.CategoryCode)
                .IsUnicode(false);

            modelBuilder.Entity<ProductMaster>()
                .Property(e => e.SKUCode)
                .IsUnicode(false);

            modelBuilder.Entity<ProductMaster>()
                .Property(e => e.SKUName)
                .IsUnicode(false);

            modelBuilder.Entity<UserMaster>()
                .Property(e => e.UserCode)
                .IsUnicode(false);

            modelBuilder.Entity<UserMaster>()
                .Property(e => e.EmplCode)
                .IsUnicode(false);

            modelBuilder.Entity<UserMaster>()
                .Property(e => e.FirstName)
                .IsUnicode(false);

            modelBuilder.Entity<UserMaster>()
                .Property(e => e.LastName)
                .IsUnicode(false);

            modelBuilder.Entity<UserMaster>()
                .Property(e => e.Username)
                .IsUnicode(false);

            modelBuilder.Entity<UserMaster>()
                .Property(e => e.Password)
                .IsUnicode(false);

            modelBuilder.Entity<UserMaster>()
                .Property(e => e.MySingleID)
                .IsUnicode(false);

            modelBuilder.Entity<UserMaster>()
                .Property(e => e.Mobile_Calling)
                .IsUnicode(false);

            modelBuilder.Entity<UserMaster>()
                .Property(e => e.Mobile_SD)
                .IsUnicode(false);

            modelBuilder.Entity<UserMaster>()
                .Property(e => e.EmailID)
                .IsUnicode(false);

            modelBuilder.Entity<UserMaster>()
                .Property(e => e.UserCommunicationGroup)
                .IsUnicode(false);

            modelBuilder.Entity<UserMaster>()
                .Property(e => e.ProfilePictureFileName)
                .IsUnicode(false);

            modelBuilder.Entity<UserMaster>()
                .Property(e => e.Address)
                .IsUnicode(false);

            modelBuilder.Entity<UserMaster>()
                .Property(e => e.Pincode)
                .IsUnicode(false);

            modelBuilder.Entity<UserMaster>()
                .Property(e => e.AlternateEmailID)
                .IsUnicode(false);

            modelBuilder.Entity<UserMaster>()
                .Property(e => e.ModifiedBy)
                .IsUnicode(false);

            modelBuilder.Entity<UserMaster>()
                .Property(e => e.AndroidRegistrationId)
                .IsUnicode(false);

            modelBuilder.Entity<UserMaster>()
                .Property(e => e.DistrictCode)
                .IsUnicode(false);

            modelBuilder.Entity<UserMaster>()
                .Property(e => e.DistrictName)
                .IsUnicode(false);

            modelBuilder.Entity<DictionaryEncryptDecrypt>()
                .Property(e => e.CharacterValue)
                .IsUnicode(false);

            modelBuilder.Entity<DictionaryEncryptDecrypt>()
                .Property(e => e.EncryptedValue)
                .IsUnicode(false);
        }
    }
}
