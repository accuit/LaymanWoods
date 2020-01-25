import { Dimension } from '../enums/app.enums';

export class Unit {
    feet: number;
    inches: number;
    type: Dimension
}

export class APIResponse {
    failedValidations: string
    isSuccess: boolean;
    message: string;
    result: any[];
    singleResult: any;
    statusCode: string;
}