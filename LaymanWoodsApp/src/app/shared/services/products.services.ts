import { Injectable } from '@angular/core';
import { ProductMaster } from '../model/product';
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

  getProductsByCategory(code): Observable<ProductMaster[]> {

    return this.httpClient.get<APIResponse>(this.baseUrl + 'api/product/productsByCategory/'+ code, { headers: this.headers })
    .pipe(
        map(res => {
          if (!res.isSuccess) {
            throw new Error(res.message);
          }
          return res.singleResult;
        }));
  }

  getBrands(): Array<Brand> {

    const brands: Brand[] = [
      { id: 1, name: 'Century', title: 'Century', productID: 1, price: 30 },
      { id: 2, name: 'Virgo', title: 'Virgo', productID: 2, price: 20 },
      { id: 3, name: 'Wood', title: 'Wood Laminate', productID: 3, price: 120 },
      { id: 4, name: 'Hettich', title: 'Hettich', productID: 4, price: 405 },
      { id: 5, name: 'Hettich', title: 'Hettich', productID: 5, price: 45 },
      { id: 6, name: 'Inox', title: 'Inox', productID: 5, price: 55 },
      { id: 7, name: 'Wood', title: 'Wood Laminate', productID: 6, price: 75 },
      { id: 8, name: 'Century CLUB PRIME', title: 'Century CLUB PRIME', productID: 1, price: 90 },
      { id: 9, name: 'Century Popular MR', title: 'Century Popular MR', productID: 8, price: 55 },
      { id: 10, name: 'Century MARINE', title: 'Century MARINE', productID: 7, price: 120 },
    ];

    return brands;
  }

}
