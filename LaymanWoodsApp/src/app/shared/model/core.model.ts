import { DimensionEnum } from '../enums/app.enums';

export class Unit {
    feet: number;
    inches: number;
    type: DimensionEnum
}

export class APIResponse {
    failedValidations: string
    isSuccess: boolean;
    message: string;
    result: any[];
    singleResult: any;
    statusCode: string;
}

export class Enquiry {
    companyID: number;
    email: string;
    investment: string;
    location: string;
    name: string;
    mobile: string;
    profession: string;
}