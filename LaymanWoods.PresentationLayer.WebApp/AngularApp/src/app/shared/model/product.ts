export class ProductMaster {
    productID: number;
    name: string;
    title: string;
    imageUrl: string;
    categoryCode: string;
    color: number;
    skuCode: string;
    skuName: string;
    mrp: number;
    isDeleted: boolean;
    isActive: boolean;
    isDefault: boolean;
    categoryID: number;
    companyID: number;
    measurementUnit: number;
    isSelected: boolean
    isChecked: boolean;
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