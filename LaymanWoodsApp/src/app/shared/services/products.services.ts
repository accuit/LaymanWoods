import { Injectable } from '@angular/core';
import { ProductMaster, ProductHelp } from '../model/product';
import { CategoryMaster } from '../model/product-category';
import { Brand } from '../model/brand';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { APIResponse } from '../model/core.model';
import { environment } from 'src/environments/environment';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';

@Injectable()
export class ProductsService {

  baseUrl = environment.apiUrl;
  headers: HttpHeaders;

  constructor(private readonly httpClient: HttpClient) {

    this.headers = new HttpHeaders({
      'Content-Type': 'application/json; charset=utf-8',
      'Access-Control-Allow-Origin': '*',
      'No-Auth': 'True'
    });
  }

  getProducts(): Observable<ProductMaster[]> {

    return this.httpClient.get<APIResponse>(this.baseUrl + 'api/product/getProductsList/', { headers: this.headers })
      .pipe(
        map(res => {
          if (!res.isSuccess) {
            throw new Error(res.message);
          }
          return res.singleResult;
        }));
  }

  getCategories(): Observable<CategoryMaster[]> {
    return this.httpClient.get<APIResponse>(this.baseUrl + 'api/product/getCategories/', { headers: this.headers })
      .pipe(
        map(res => {
          if (!res.isSuccess) {
            throw new Error(res.message);
          }
          return res.singleResult;
        }));
  }

  getProductsByCategory(code): Observable<APIResponse> {

    return this.httpClient.get<APIResponse>(this.baseUrl + 'api/product/productsByCategory/' + code, { headers: this.headers })
      .pipe(
        map(res => {
          if (!res.isSuccess) {
            throw new Error(res.message);
          }
          return res;
        }));
  }

  getProductHelp(code: string, id?: number): Observable<APIResponse> {

    return this.httpClient.get<APIResponse>(this.baseUrl + 'api/product/productHelp/' + code + '/' + id, { headers: this.headers })
      .pipe(
        map(res => {
          if (!res.isSuccess) {
            throw new Error(res.message);
          }
          return res;
        }));
  }


}
