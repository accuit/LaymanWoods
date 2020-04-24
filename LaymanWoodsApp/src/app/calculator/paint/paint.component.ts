import { Component, OnInit, Output, EventEmitter, Input } from '@angular/core';
import { dataTypeEnum, WebPartTypeEnum, InteriorEnum, CalculationCostTypeEnum } from 'src/app/shared/enums/app.enums';
import * as _ from 'underscore';
import { ProductMaster } from 'src/app/shared/model/product';
import { ProductsService } from 'src/app/shared/services/products.services';
import { CompleteInteriorListing } from 'src/app/shared/model/interior';
import { CategoryMaster } from 'src/app/shared/model/product-category';

@Component({
  selector: 'app-paint',
  templateUrl: './paint.component.html',
  styleUrls: ['./paint.component.scss']
})
export class PaintComponent implements OnInit {


  @Output() readonly paintPrice: EventEmitter<any> = new EventEmitter<any>();
  @Output() readonly addAnother: EventEmitter<any> = new EventEmitter<any>();
  @Input('next') nextProduct: number;

  dataType: any = dataTypeEnum;
  formData: any = {};
  interiorCategories: CompleteInteriorListing[];

  constructor(private readonly service: ProductsService) { }

  ngOnInit() {
    this.service.getInteriorCategories(+InteriorEnum.Paint).subscribe(result => {
      this.interiorCategories = result;
      this.getProductFormData();
    });
  }

  getProductFormData() {
    this.formData.totalPrice = 0;
    this.formData.area = 100;
    this.formData.categories = new Array<CompleteInteriorListing>();
    this.interiorCategories.forEach(c => {
      c.selectedProduct = new ProductMaster();
      const defaultProduct = c.products.filter(x => x.isDefault);
      c.selectedProduct = _.first(defaultProduct.length ? defaultProduct : c.products);
    });
    this.formData.categories = this.interiorCategories;
  }

  calculateCost() {
    let totalCost: number = 0;
    this.formData.categories.forEach(x => {
      if (x.selectedProduct) {
        if (x.selectedProduct.measurementUnit === +CalculationCostTypeEnum.AreaMultiply) {
          totalCost = totalCost + (x.selectedProduct.mrp * x.multiplier) * (this.formData.area / x.divisor);
        } else if (x.selectedProduct.measurementUnit === +CalculationCostTypeEnum.Quantity) {
          totalCost = totalCost + x.selectedProduct.mrp;
        }
        console.log(x.selectedProduct.title + ' ( ' + x.selectedProduct.measurementUnit + ' )' + ': (' + x.selectedProduct.mrp + "*" + x.multiplier + ') * (' + this.formData.area + '/' + x.divisor + ') Total: ' + totalCost);
      }
    });

    this.formData.totalPrice = Math.round(totalCost)
    this.paintPrice.emit(this.formData.totalPrice);
  }

  addAnotherProduct(prod) {
    this.addAnother.emit(prod);
  }

  reset(): any {
    this.getProductFormData();
    this.paintPrice.emit(0);
  }

  onSubmit(): any {
    this.calculateCost();
  }

}
