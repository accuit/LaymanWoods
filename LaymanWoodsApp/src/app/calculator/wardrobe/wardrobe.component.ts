import { Component, OnInit, Output, EventEmitter, Input } from '@angular/core';
import { Dimension } from 'src/app/shared/enums/app.enums';
import { ProductMaster } from 'src/app/shared/model/product';
import * as _ from 'underscore';
import { ProductsService } from 'src/app/shared/services/products.services';

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
  kitchenCategoryID = 1;
  wardrobe: any;
  formData: any = {};
  product1Brands: ProductMaster[];
  product2Brands: ProductMaster[];
  product3Brands: ProductMaster[];
  product4Brands: ProductMaster[];
  product5Brands: ProductMaster[];
  // product6Brands: ProductMaster[];
  product7Brands: ProductMaster[];
  product8Brands: ProductMaster[];
  product9Brands: ProductMaster[];

  constructor(private readonly service: ProductsService) { }

  ngOnInit() {
    this.initializeFormData();
    this.service.getProducts().subscribe(result => {
      console.log(result);
      this.wardrobeProducts = result;
      this.initializeBrands();
    })

  }

  initializeFormData() {
    this.formData.totalPrice = 0;
    this.formData.isSlider = 'No'
    this.formData.totalArea = 0;

    this.formData.A = { feet: 10, inches: 0, type: Dimension.LENGTH };
    this.formData.B = { feet: 10, inches: 0, type: Dimension.WIDTH }
  }

  addAnotherProduct(prod) {
    this.addAnother.emit(prod);
  }

  initializeBrands() {
    this.product1Brands = this.wardrobeProducts.filter(x => x.categoryCode === '101');
    this.formData.selectedBrand1 = _.first(this.product1Brands.filter(x => x.isDefault));

    this.product2Brands = this.wardrobeProducts.filter(x => x.categoryCode === '102');
    this.formData.selectedBrand2 = _.first(this.product2Brands.filter(x => x.isDefault));

    this.product3Brands = this.wardrobeProducts.filter(x => x.categoryCode === '103');
    this.formData.selectedBrand3 = _.first(this.product3Brands.filter(x => x.isDefault));

    this.product4Brands = this.wardrobeProducts.filter(x => x.categoryCode === '104');
    this.formData.selectedBrand4 = _.first(this.product4Brands.filter(x => x.isDefault));

    this.product5Brands = this.wardrobeProducts.filter(x => x.categoryCode === '105');
    this.formData.selectedBrand5 = _.first(this.product5Brands.filter(x => x.isDefault));

    // this.product6Brands = this.wardrobeProducts.filter(x => x.categoryCode === '106');
    // this.formData.selectedBrand6 = _.first(this.product6Brands.filter(x => x.isDefault));

    this.product7Brands = this.wardrobeProducts.filter(x => x.categoryCode === '107');
    this.formData.selectedBrand7 = _.first(this.product7Brands.filter(x => x.isDefault));

    this.product8Brands = this.wardrobeProducts.filter(x => x.categoryCode === '200');
    this.formData.selectedBrand8 = _.first(this.product8Brands.filter(x => x.isDefault));

    this.product9Brands = this.wardrobeProducts.filter(x => x.categoryCode === '300');
    this.formData.selectedBrand9 = _.first(this.product9Brands.filter(x => x.isDefault));

  }

  calculateCostByBrand(): number {
    const area = this.calculateArea();
    let totalCost: number = 0;
    totalCost = this.formData.selectedBrand1 ? (+this.formData.selectedBrand1.mrp * this.formData.selectedBrand1.multiplier) * (area / this.formData.selectedBrand1.divisor) : 0;
    totalCost = this.formData.selectedBrand2 ? totalCost + (this.formData.selectedBrand2.mrp * this.formData.selectedBrand2.multiplier) * (area / this.formData.selectedBrand2.divisor) : totalCost;
    totalCost = this.formData.selectedBrand3 ? totalCost + (this.formData.selectedBrand3.mrp * this.formData.selectedBrand3.multiplier) * (area / 20) : totalCost;
    totalCost = this.formData.selectedBrand4 ? totalCost + (this.formData.selectedBrand4.mrp * this.formData.selectedBrand4.multiplier) * (area / 6) : totalCost;
    totalCost = this.formData.selectedBrand5 ? totalCost + (this.formData.selectedBrand5.mrp * this.formData.selectedBrand5.multiplier) * (area / 12) : totalCost;
    totalCost = this.formData.selectedBrand7 ? totalCost + (this.formData.selectedBrand7.mrp * this.formData.selectedBrand7.multiplier) * (area / 10) : totalCost;
    totalCost = this.formData.selectedBrand8 ? totalCost + (this.formData.selectedBrand8.mrp * this.formData.selectedBrand8.multiplier) * (area / this.formData.selectedBrand8.divisor) : totalCost;
    totalCost = this.formData.selectedBrand9 ? (totalCost + 190 * area) : totalCost;
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
    this.formData = {};
    this.wardrobePrice.emit(0);
    this.initializeFormData();
  }

  onSubmit() {
    this.calculateCostByBrand();
    window.scroll({
      top: 100,
      left: 0,
      behavior: 'smooth'
    });
  }
}

