import { Component, OnInit, EventEmitter, Output, Input } from '@angular/core';
import { DimensionEnum, InteriorEnum, CalculationCostTypeEnum } from 'src/app/shared/enums/app.enums';
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
    this.formData.area = this.calculateArea();
    let totalCost = 0;
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
    this.ceilingPrice.emit(this.formData.totalPrice);
  }

  reset(): any {
    this.getProductFormData();
    this.ceilingPrice.emit(0);
  }

  onSubmit(): any {
    this.calculatePrice();
  }

}
