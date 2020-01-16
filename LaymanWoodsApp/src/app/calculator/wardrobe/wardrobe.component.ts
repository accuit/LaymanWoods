import { Component, OnInit, Output, EventEmitter } from '@angular/core';
import { FormGroup } from '@angular/forms';
import { Product } from 'src/app/shared/model/product';
import { Dimension } from 'src/app/shared/enums/app.enums';
import { DataService } from 'src/app/shared/services/data.service';

@Component({
  selector: 'app-wardrobe',
  templateUrl: './wardrobe.component.html',
  styleUrls: ['./wardrobe.component.scss']
})
export class WardrobeComponent implements OnInit {

  @Output() readonly wardrobePrice: EventEmitter<any> = new EventEmitter<any>();
  formGroup: FormGroup;
  wardrobeProducts: Product[];
  kitchenCategoryID = 1;
  layout = 'L';
  wardrobe: any;
  formData: any = {};
  product1Brands: any;
  product2Brands: any;
  product3Brands: any;
  product4Brands: any;
  product5Brands: any;
  product6Brands: any;
  product7Brands: any;
  product8Brands: any;

  constructor(private readonly dataService: DataService) {

  }

  ngOnInit() {
    this.initializeFormData();
    this.initializeBrands();

  }

  initializeFormData() {
    this.formData.totalPrice = 0;
    this.formData.isSlider = 'No'
    this.formData.totalArea = 0;

    this.formData.A = { feet: 0, inches: 0, type: Dimension.LENGTH };
    this.formData.B = { feet: 0, inches: 0, type: Dimension.WIDTH }
  }

  initializeBrands() {
    this.product1Brands = this.dataService.getBrands().filter(x => x.productID === 1);
    this.formData.selectedBrand1 = null; //_.first(this.product1Brands);

    this.product2Brands = this.dataService.getBrands().filter(x => x.productID === 2);
    this.formData.selectedBrand2 = null;//_.first(this.product2Brands);

    this.product3Brands = this.dataService.getBrands().filter(x => x.productID === 3);
    this.formData.selectedBrand3 = null; // _.first(this.product3Brands);

    this.product4Brands = this.dataService.getBrands().filter(x => x.productID === 4);
    this.formData.selectedBrand4 = null; // _.first(this.product4Brands);

    this.product5Brands = this.dataService.getBrands().filter(x => x.productID === 5);
    this.formData.selectedBrand5 = null; //  _.first(this.product5Brands);

    this.product6Brands = this.dataService.getBrands().filter(x => x.productID === 6);
    this.formData.selectedBrand6 = null; //  _.first(this.product6Brands);

    this.product7Brands = this.dataService.getBrands().filter(x => x.productID === 7);
    this.formData.selectedBrand7 = null; // _.first(this.product7Brands);

    this.product8Brands = this.dataService.getBrands().filter(x => x.productID === 8);
    this.formData.selectedBrand8 = null; //  _.first(this.product8Brands);

  }

  calculateCostByBrand(): number {
    const area = this.formData.totalArea;
    let totalCost: number = 0;
    totalCost = this.formData.selectedBrand1 ? +this.formData.selectedBrand1.price : 0;
    totalCost = this.formData.selectedBrand2 ? (totalCost + this.formData.selectedBrand2.price) : totalCost;
    totalCost = this.formData.selectedBrand3 ? (totalCost + this.formData.selectedBrand3.price) : totalCost;
    totalCost = this.formData.selectedBrand4 ? (totalCost + this.formData.selectedBrand4.price) : totalCost;
    totalCost = this.formData.selectedBrand5 ? (totalCost + this.formData.selectedBrand5.price) : totalCost;
    totalCost = this.formData.selectedBrand6 ? (totalCost + this.formData.selectedBrand6.price) : totalCost;
    totalCost = this.formData.selectedBrand7 ? (totalCost + this.formData.selectedBrand7.price) : totalCost;
    const cumulativeSum = totalCost * area
    this.wardrobePrice.emit(cumulativeSum);
    this.formData.totalPrice = cumulativeSum;
    
    return cumulativeSum;
  }

  calculateArea = (): number => {

    const sideA = (+this.formData.A.feet + (+this.formData.A.inches) / 12); // Feet
    const sideB = (+this.formData.B.feet + (+this.formData.B.inches) / 12); // Feet

    return Math.round(sideA * sideB)

  };

}


export class Wardrobe {

}
