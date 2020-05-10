import { ProductMaster } from './product';
import { DecimalPipe } from '@angular/common';
import { WebPartTypeEnum } from '../enums/app.enums';
import { CategoryMaster } from './product-category';

export class InteriorCategory {
    id: number;
    name:string;
    title: string;
    image: string;
    isDeleted: boolean;
    companyID: number;
    interiorProducts: Array<InteriorProducts>;
}

export class InteriorProducts {
    id: number;
    name:string;
    title: string;
    image: string;
    type: number;
    interiorCategoryID: number;
    isDeleted: boolean;
    companyID: number;
}

export class InteriorAndCategoryMapping {
    id: number;
    name:string;
    title: string;
    image: string;
    type: number;
    interiorCategoryID: number;
    isDeleted: boolean;
    WebPartType: WebPartTypeEnum;
    isMultiSelect: boolean;
    companyID: number;
    isDefault: boolean;
}

export class CompleteInteriorListing {
    interiorCatgID: number;
    companyID: number = 1;
    category: CategoryMaster;
    products?: Array<ProductMaster>; 
    selectedProduct?: ProductMaster;
    multiplier?: number;
    divisor?: number
    webPartType: WebPartTypeEnum;
    isMultiSelect: boolean;
    isDefault: boolean;
}