import { Injectable } from '@angular/core';
import { Brand } from '../model/brand';
import { CategoryMaster } from '../model/product-category';
import { ProductsService } from './products.services';

@Injectable({
  providedIn: 'root'
})
export class DataService {

  constructor(private readonly service: ProductsService) { }

  getProducts(): any {
    this.service.getProducts().subscribe((res) => {
      return res;
    })
  }

  getCategories(): any {

    this.service.getCategories().subscribe((res) => {
      return res;
    })
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
