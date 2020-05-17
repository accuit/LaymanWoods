using AutoMapper;
using LaymanWoods.BusinessLayer.Base;
using LaymanWoods.BusinessLayer.Services;
using LaymanWoods.BusinessLayer.Services.BO;
using LaymanWoods.CommonLayer.Aspects;
using System;
using Unity;
using LaymanWoods.PersistenceLayer.Data.Repository;
using LaymanWoods.PersistenceLayer.Data.Impl;
using LaymanWoods.PersistenceLayer.Data.EDMX;
using LaymanWoods.CommonLayer.Aspects.DTO;
using LaymanWoods.BusinessLayer.ServiceImpl;
using LaymanWoods.BusinessLayer.Base.Manager;
using LaymanWoods.BusinessLayer.Services.Contracts;

namespace LaymanWoods.CommonLayer.AOPRegistrations
{
    public class UnityRegistration
    {
        public static void InitializeAopContainer()
        {
            AopEngine.Initialize();
            InitializeLibrary();

            MapEntities();
        }

        private static void InitializeLibrary()
        {
            InitializeLibraryPersistenceLayer();
            InitializeLibraryBusinessLayer();
        }

        private static void InitializeLibraryPersistenceLayer()
        {
            AopEngine.Container.RegisterType<IUserRepository, UserDataImpl>(GetPersistenceRegisterInstanceName(AspectEnums.PeristenceInstanceNames.UserDataImpl, AspectEnums.ApplicationName.LaymanWoods));
            AopEngine.Container.RegisterType<ISecurityRepository, SecurityDataImpl>(GetPersistenceRegisterInstanceName(AspectEnums.PeristenceInstanceNames.SecurityDataImpl, AspectEnums.ApplicationName.LaymanWoods));
            AopEngine.Container.RegisterType<IProductRepository, ProductDataImpl>(GetPersistenceRegisterInstanceName(AspectEnums.PeristenceInstanceNames.ProductDataImpl, AspectEnums.ApplicationName.LaymanWoods));
            AopEngine.Container.RegisterType<INotificationRepository, NotificationDataImpl>(GetPersistenceRegisterInstanceName(AspectEnums.PeristenceInstanceNames.NotificationDataImpl, AspectEnums.ApplicationName.LaymanWoods));
        }

        private static string GetPersistenceRegisterInstanceName(AspectEnums.PeristenceInstanceNames aspectName, AspectEnums.ApplicationName application)
        {
            return String.Format("{0}_{1}", application.ToString(), aspectName.ToString());
        }

        private static string GetBusinessRegisterInstanceName(AspectEnums.AspectInstanceNames aspectName, AspectEnums.ApplicationName application)
        {
            return String.Format("{0}_{1}", application.ToString(), aspectName.ToString());
        }

        private static void InitializeLibraryBusinessLayer()
        {
            AopEngine.Container.RegisterType<IUserService, UserManager>(GetBusinessRegisterInstanceName(AspectEnums.AspectInstanceNames.UserManager, AspectEnums.ApplicationName.LaymanWoods));
            AopEngine.Container.RegisterType<ISecurityService, SecurityManager>(GetBusinessRegisterInstanceName(AspectEnums.AspectInstanceNames.SecurityManager, AspectEnums.ApplicationName.LaymanWoods));
            AopEngine.Container.RegisterType<IProductService, ProductManager>(GetBusinessRegisterInstanceName(AspectEnums.AspectInstanceNames.ProductManager, AspectEnums.ApplicationName.LaymanWoods));
            AopEngine.Container.RegisterType<INotificationService, NotificationManager>(GetBusinessRegisterInstanceName(AspectEnums.AspectInstanceNames.NotificationManager, AspectEnums.ApplicationName.LaymanWoods));
        }

        private static void MapEntities()
        {
            var config = MapBOEntities();
            AutoMapper.IMapper mapper = config.CreateMapper();
            AopEngine.Container.RegisterInstance(mapper);
        }

        private static MapperConfiguration MapBOEntities()
        {

            var config = new MapperConfiguration(map =>
            {
                //Create all maps here
                map.CreateMap<CommonSetup, CommonSetupDTO>();
                map.CreateMap<CommonSetupDTO, CommonSetup>();

                map.CreateMap<EmailTemplate, EmailTemplateDTO>();
                map.CreateMap<EmailTemplateDTO, EmailTemplate>();

                map.CreateMap<OTPMaster, OTPDTO>();
                map.CreateMap<OTPDTO, OTPMaster>();

                map.CreateMap<CategoryMaster, CategoryMasterDTO>();
                map.CreateMap<CategoryMasterDTO, CategoryMaster>();

                map.CreateMap<ProductMaster, ProductMasterDTO>();
                map.CreateMap<ProductMasterDTO, ProductMaster>();

                map.CreateMap<ProductHelp, ProductHelpDTO>();
                map.CreateMap<ProductHelpDTO, ProductHelp>();

                map.CreateMap<InteriorAndCategoryMapping, InteriorAndCategoryMappingDTO>();
                map.CreateMap<InteriorAndCategoryMappingDTO, InteriorAndCategoryMapping>();

                map.CreateMap<InteriorCategory, InteriorCategoryDTO>();
                map.CreateMap<InteriorCategoryDTO, InteriorCategory>();

                map.CreateMap<InteriorProduct, InteriorProductDTO>();
                map.CreateMap<InteriorProductDTO, InteriorProduct>();

                map.CreateMap<CompleteInteriorListingDTO, CompleteInteriorListing>();
                map.CreateMap<CompleteInteriorListing, CompleteInteriorListingDTO>();

                map.CreateMap<EntrepreneurEnquiryDTO, EntrepreneurEnquiry>();
                map.CreateMap<EntrepreneurEnquiry, EntrepreneurEnquiryDTO>();

                map.CreateMap<ContactEnquiryDTO, ContactEnquiry>();
                map.CreateMap<ContactEnquiry, ContactEnquiryDTO>();
            });

            return config;


        }
    }
}
