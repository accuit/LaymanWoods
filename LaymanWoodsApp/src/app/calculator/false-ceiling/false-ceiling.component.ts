import { Component, OnInit, EventEmitter, Output, Input } from '@angular/core';
import { DimensionEnum, InteriorEnum } from 'src/app/shared/enums/app.enums';
import { ProductsService } from 'src/app/shared/services/products.services';
import { CompleteInteriorListing } from 'src/app/shared/model/interior';
import { ProductMaster } from 'src/app/shared/model/product';
import * as _ from 'underscore';

@Component({
  selector: 'app-false-ceiling',
  templateUrl: './false-ceiling.component.html',
  styleUrls: ['./false-ceiling.component.scss', '../calculator.component.scss']
})
export class FalseCeilingComponent implements OnInit {
  @Output() readonly ceilingPrice: EventEmitter<any> = new EventEmitter<any>();
  @Output() readonly addAnother: EventEmitter<any> = new EventEmitter<any>();
  @Input('next') nextProduct: number;

  formData: any = {};
  interiorCategories: CompleteInteriorListing[];

  constructor(private readonly service: ProductsService) { }

  ngOnInit() {
    this.service.getInteriorCategories(+InteriorEnum.FalseCeiling).subscribe(result => {
      this.interiorCategories = result;
      this.getProductFormData();
    });
  }

  getProductFormData() {
    this.formData.totalPrice = 0;
    this.formData.area = 100;
    this.formData.A = { feet: 10, inches: 0, type: DimensionEnum.LENGTH };
    this.formData.B = { feet: 10, inches: 0, type: DimensionEnum.WIDTH }

    this.formData.categories = new Array<CompleteInteriorListing>();
    this.interiorCategories.forEach(c => {
      c.selectedProduct = new ProductMaster();
      const defaultProduct = c.products.filter(x => x.isDefault);
      c.selectedProduct = _.first(defaultProduct.length ? defaultProduct : c.products);
    });
    this.formData.categories = this.interiorCategories;
  }

  onCeilingTypeChange(item) {
    this.formData.type = item;
    this.formData.totalPrice = 0;
    this.calculatePrice();
  }

  addAnotherProduct(prod) {
    this.addAnother.emit(prod);
  }

  calculateArea = (): number => {
    const sideA = (+this.formData.A.feet + (+this.formData.A.inches) / 12); // Feet
    const sideB = (+this.formData.B.feet + (+this.formData.B.inches) / 12); // Feet
    const area = Math.round(sideA + sideB);
    this.formData.area = area;
    return area;

  };

  calculatePrice() {
    const area = this.calculateArea();
    const basicPrice = area * 120;
    const sideA: number = +this.formData.A.feet + +(this.formData.A.inches / 12);
    const sideB: number = +this.formData.B.feet + +(this.formData.B.inches / 12);
    const coverPrice = 2 * area * 240;
    const mouldingPrice: number = 40 * 2 * area;
    const C = .25;
    const wallPOP: number = 22 * (2 * area + 2 * sideB * C + C * sideA);

    this.formData.totalPrice = basicPrice + mouldingPrice + wallPOP;

    this.ceilingPrice.emit(this.formData.totalPrice);
  }

  reset(): any {
    this.getProductFormData();
    this.ceilingPrice.emit(0);
  }

  onSubmit(): any {
    this.calculatePrice();
    window.scroll({
      top: 100,
      left: 0,
      behavior: 'smooth'
    });
  }

}
