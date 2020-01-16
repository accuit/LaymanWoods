import { Injectable } from '@angular/core';
import { Product } from '../model/product';
import { ProductCategory } from '../model/product-category';
import { Brand } from '../model/brand';

@Injectable({
  providedIn: 'root'
})
export class DataService {

  constructor() { }

  getProducts(): Array<Product> {

    const products: Product[] = [
      { id: 1, name: 'Ply Board', title: 'Ply and Board', categories: [1, 2] },
      { id: 2, name: 'Inner Laminate', title: 'Inner Laminate', categories: [1, 2] },
      { id: 3, name: 'Outer Finish', title: 'Outer Finish', categories: [1, 2] },
      { id: 4, name: 'Hinges', title: 'Hinges', categories: [1, 2] },
      { id: 5, name: 'Channels', title: 'Channels', categories: [1, 2] },
      { id: 6, name: 'Full', title: 'Full Size', categories: [3] },
      { id: 7, name: 'Border', title: 'Border and Corners', categories: [3] },
      { id: 8, name: 'Labour Work', title: 'Labour Work', categories: [3] }
    ];

    return products;
  }

  getCategories(): Array<ProductCategory> {

    const products: ProductCategory[] = [
      { id: 1, name: 'Kitchen', title: 'Kitchen' },
      { id: 2, name: 'Wardrobe', title: 'Wardrobe' },
      { id: 3, name: 'False Ceiling', title: 'False Ceiling' }
    ];

    return products;
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
