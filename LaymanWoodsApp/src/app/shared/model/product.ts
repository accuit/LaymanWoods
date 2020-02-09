export class ProductMaster {
    productID: number;
    name: string;
    title: string;
    imageUrl: string;
    categoryCode: string;
    basicModelCode: string;
    basicModelName: string;
    color: number;
    sKUCode: string;
    sKUName: string;
    mrp: string;
    isDeleted: boolean;
    isActive: boolean;
    categoryID: number;
    companyID: number;
    measurementUnit: number;
}

export class ProductHelp {
    iD: number;
    title: string;
    imageUrl: string;
    categoryID: number;
    productID: number;
    description: string;
    additionalInfo: string;
    specification: string;
    isDeleted: boolean;
    companyID: number;
}