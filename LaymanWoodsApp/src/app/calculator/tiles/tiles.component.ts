import { Component, OnInit, Output, EventEmitter, Input } from '@angular/core';
import { dataTypeEnum, InteriorEnum, CalculationCostTypeEnum } from 'src/app/shared/enums/app.enums';
import * as _ from 'underscore';
import { ProductsService } from 'src/app/shared/services/products.services';
import { ProductMaster } from 'src/app/shared/model/product';
import { CompleteInteriorListing } from 'src/app/shared/model/interior';

@Component({
  selector: 'app-tiles',
  templateUrl: './tiles.component.html',
  styleUrls: ['./tiles.component.scss']
})
export class TilesComponent implements OnInit {

  @Output() readonly tilesPrice: EventEmitter<any> = new EventEmitter<any>();
  @Output() readonly addAnother: EventEmitter<any> = new EventEmitter<any>();
  @Input('next') nextProduct: number;

  dataType: any = dataTypeEnum;
  formData: any = {};
  interiorCategories: CompleteInteriorListing[];

  constructor(private readonly service: ProductsService) { }

  ngOnInit() {
    this.service.getInteriorCategories(+InteriorEnum.Tiles).subscribe(result => {
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
    let totalCost = 0;
    this.interiorCategories.forEach(x => {
      if (x.selectedProduct) {
        if (x.selectedProduct.measurementUnit === +CalculationCostTypeEnum.AreaMultiply) {
          totalCost = totalCost + (x.selectedProduct.mrp * x.multiplier) * (this.formData.area / x.divisor);
        } else if (x.selectedProduct.measurementUnit === +CalculationCostTypeEnum.Quantity) {
          totalCost = totalCost + x.selectedProduct.mrp;
        }
        console.log(x.selectedProduct.title + ': (' + x.selectedProduct.mrp + "*" + x.multiplier + ') * (' + this.formData.area + '/' + x.divisor + ')');

      }
    });
    this.tilesPrice.emit(this.formData.totalPrice);
  }

  reset(): any {
    this.formData = {};
    this.tilesPrice.emit(0);
    this.getProductFormData();
  }

  addAnotherProduct(prod) {
    this.addAnother.emit(prod);
  }

  onSubmit(): any {
    this.calculateCost();
    window.scroll({
      top: 100,
      left: 0
    });
  }

}
