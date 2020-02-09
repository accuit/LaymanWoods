﻿using AutoMapper;
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
        }

        private static void MapEntities()
        {
            var config = MapBOEntities();
            AutoMapper.IMapper mapper = config.CreateMapper();
            AopEngine.Container.RegisterInstance(mapper);
        }

        private static MapperConfiguration MapBOEntities()
        {

            var config = new MapperConfiguration(cfg =>
            {
                //Create all maps here
                cfg.CreateMap<CommonSetup, CommonSetupDTO>();
                cfg.CreateMap<CommonSetupDTO, CommonSetup>();

                cfg.CreateMap<EmailTemplate, EmailTemplateDTO>();
                cfg.CreateMap<EmailTemplateDTO, EmailTemplate>();

                cfg.CreateMap<OTPMaster, OTPDTO>();
                cfg.CreateMap<OTPDTO, OTPMaster>();

                cfg.CreateMap<CategoryMaster, CategoryMasterDTO>();
                cfg.CreateMap<CategoryMasterDTO, CategoryMaster>();

                cfg.CreateMap<ProductMaster, ProductMasterDTO>();
                cfg.CreateMap<ProductMasterDTO, ProductMaster>();

                cfg.CreateMap<ProductHelp, ProductHelpDTO>();
                cfg.CreateMap<ProductHelpDTO, ProductHelp>();
            });

            return config;


        }
    }
}
