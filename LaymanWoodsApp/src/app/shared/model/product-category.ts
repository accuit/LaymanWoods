import { ProductMaster } from './product';
import { WebPartTypeEnum } from '../enums/app.enums';

export class CategoryMaster {
    categoryID: string;
    categoryName: string;
    title: string;
    categoryCode: string;
    companyID: number = 1;
    products?: Array<ProductMaster>; 
    selectedProduct?: ProductMaster;
}