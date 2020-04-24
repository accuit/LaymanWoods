import { Component, OnInit, Output, EventEmitter, Input } from '@angular/core';
import { DimensionEnum, InteriorEnum, CalculationCostTypeEnum } from 'src/app/shared/enums/app.enums';
import { ProductMaster } from 'src/app/shared/model/product';
import * as _ from 'underscore';
import { ProductsService } from 'src/app/shared/services/products.services';
import { CategoryMaster } from 'src/app/shared/model/product-category';
import { CompleteInteriorListing } from 'src/app/shared/model/interior';

@Component({
  selector: 'app-wardrobe',
  templateUrl: './wardrobe.component.html',
  styleUrls: ['./wardrobe.component.scss']
})
export class WardrobeComponent implements OnInit {

  @Output() readonly wardrobePrice: EventEmitter<any> = new EventEmitter<any>();
  @Output() readonly addAnother: EventEmitter<any> = new EventEmitter<any>();
  @Input('next') nextProduct: number;

  wardrobeProducts: ProductMaster[];
  categories: CategoryMaster[];
  interiorCategories: CompleteInteriorListing[];
  kitchenCategoryID = 1;
  wardrobe: any;
  formData: any = {};

  constructor(private readonly service: ProductsService) { }

  ngOnInit() {
    this.initializeFormData();

    this.service.getInteriorCategories(+InteriorEnum.Wardrobe).subscribe(result => {
      this.interiorCategories = result;
      this.getProductFormData();
    });
  }

  getProductFormData() {
    this.formData.categories = new Array<CategoryMaster>();
    this.interiorCategories.forEach(c => {
      c.selectedProduct = new ProductMaster();
      const defaultProduct = c.products.filter(x => x.isDefault);
      c.selectedProduct = _.first(defaultProduct.length ? defaultProduct : c.products);
    });
    this.formData.categories = this.interiorCategories;
  }

  initializeFormData() {
    this.formData.totalPrice = 0;
    this.formData.isSlider = 'No'
    this.formData.totalArea = 0;

    this.formData.A = { feet: 10, inches: 0, type: DimensionEnum.LENGTH };
    this.formData.B = { feet: 10, inches: 0, type: DimensionEnum.WIDTH }
  }

  addAnotherProduct(prod) {
    this.addAnother.emit(prod);
  }

  calculateCostByBrand(): number {
    const area = this.calculateArea();
    let totalCost: number = 0;

    this.formData.categories.forEach(x => {
      if (x.selectedProduct) {
        if (x.selectedProduct.measurementUnit === +CalculationCostTypeEnum.AreaMultiply) {
          totalCost = totalCost + (x.selectedProduct.mrp * x.multiplier) * (area / x.divisor);
        } else if (x.selectedProduct.measurementUnit === +CalculationCostTypeEnum.Quantity) {
          totalCost = totalCost + x.selectedProduct.mrp;
        }
        console.log(x.selectedProduct.title + ' ( ' + x.selectedProduct.measurementUnit + ' )' + ': (' + x.selectedProduct.mrp + "*" + x.multiplier + ') * (' + area + '/' + x.divisor + ') Total: ' + totalCost);
      }
    });

    totalCost = Math.round(totalCost);
    this.wardrobePrice.emit(totalCost);
    this.formData.totalPrice = totalCost;

    return totalCost;
  }

  calculateArea = (): number => {

    const sideA = (+this.formData.A.feet + (+this.formData.A.inches) / 12); // Feet
    const sideB = (+this.formData.B.feet + (+this.formData.B.inches) / 12); // Feet

    return Math.round(sideA * sideB)

  };

  reset() {
    this.wardrobePrice.emit(0);
    this.initializeFormData();
    this.getProductFormData();
  }

  onSubmit() {
    this.calculateCostByBrand();
    window.scroll({
      top: 100,
      left: 0
    });
  }
}

