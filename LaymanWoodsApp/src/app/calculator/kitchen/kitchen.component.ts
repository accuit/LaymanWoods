import { Component, OnInit, Output, EventEmitter, Input } from '@angular/core';
import { FormGroup } from '@angular/forms';
import { ProductMaster } from 'src/app/shared/model/product';
import { Dimension } from 'src/app/shared/enums/app.enums';
import * as _ from 'underscore';
import { ProductsService } from 'src/app/shared/services/products.services';

@Component({
  selector: 'app-kitchen',
  templateUrl: './kitchen.component.html',
  styleUrls: ['./kitchen.component.scss', '../calculator.component.scss']
})
export class KitchenComponent implements OnInit {

  @Output() readonly kitchenPrice: EventEmitter<any> = new EventEmitter<any>();
  @Output() readonly addAnother: EventEmitter<any> = new EventEmitter<any>();
  @Input('next') nextProduct: number;
  formGroup: FormGroup;
  kitchenProducts: ProductMaster[];
  kitchenCategoryID = 1;
  layout = 'L';

  kitchens: Kitchen[] = [
    { sides: 2, value: 'L', name: 'L Shape', imageUrl: 'https://interioreradotin.files.wordpress.com/2019/02/l-shape-kitchen-banner-4.jpg?w=775' },
    { sides: 3, value: 'U', name: 'U Shape', imageUrl: 'http://digitalb2btrade.com/static/listing-image/1551787072u-shape.jpg' },
    { sides: 1, value: 'I', name: 'Single Side I Shape', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSp-Ob2Re5RoosQmTW08Wqco81kD3Pytyere6Bi4xBXOd3Z_T2a' },
    { sides: 2, value: 'P', name: 'Parallel Shape', imageUrl: 'http://royalkitchenworld.com/wp-content/uploads/2017/03/gallary_16_3.jpg' },
  ];

  selectedKitchen: Kitchen;
  formData: any = {};

  product1Brands: ProductMaster[];
  product2Brands: ProductMaster[];
  product3Brands: ProductMaster[];
  product4Brands: ProductMaster[];
  product5Brands: ProductMaster[];
  product6Brands: ProductMaster[];
  product7Brands: ProductMaster[];
  product8Brands: ProductMaster[];
  product9Brands: ProductMaster[];

  constructor(private readonly service: ProductsService) { }

  ngOnInit() {
    this.initializeFormData();
    this.service.getProducts().subscribe(result => {
      console.log(result);
      this.kitchenProducts = result;
      this.initializeBrands();
    })
  }

  initializeFormData() {
    this.formData.totalPrice = 0;
    this.formData.totalArea = 0;
    this.formData.selectedKitchen = _.first(this.kitchens);
    this.formData.kitchenHeight = 'Standard';

    this.formData.A = { feet: 10, inches: 0, type: Dimension.LENGTH };
    this.formData.B = this.formData.selectedKitchen.sides > 1 ? { feet: 10, inches: 0, type: Dimension.WIDTH } : null;
    this.formData.C = this.formData.selectedKitchen.sides > 2 ? { feet: 10, inches: 0, type: Dimension.HEIGHT } : null;
  }

  initializeBrands() {
    this.product1Brands = this.kitchenProducts.filter(x => x.categoryCode === '101');
    this.formData.selectedBrand1 = _.first(this.product1Brands.filter(x => x.isDefault));

    this.product2Brands = this.kitchenProducts.filter(x => x.categoryCode === '102');
    this.formData.selectedBrand2 = _.first(this.product2Brands.filter(x => x.isDefault));

    this.product3Brands = this.kitchenProducts.filter(x => x.categoryCode === '103');
    this.formData.selectedBrand3 = _.first(this.product3Brands.filter(x => x.isDefault));

    this.product4Brands = this.kitchenProducts.filter(x => x.categoryCode === '104');
    this.formData.selectedBrand4 = _.first(this.product4Brands.filter(x => x.isDefault));

    this.product5Brands = this.kitchenProducts.filter(x => x.categoryCode === '105');
    this.formData.selectedBrand5 = _.first(this.product5Brands.filter(x => x.isDefault));

    this.product6Brands = this.kitchenProducts.filter(x => x.categoryCode === '106');
    this.formData.selectedBrand6 = _.first(this.product6Brands.filter(x => x.isDefault));

    this.product7Brands = this.kitchenProducts.filter(x => x.categoryCode === '107');
    this.formData.selectedBrand7 = _.first(this.product7Brands.filter(x => x.isDefault));

    this.product8Brands = this.kitchenProducts.filter(x => x.categoryCode === '200');
    this.formData.selectedBrand8 = _.first(this.product8Brands.filter(x => x.isDefault));

    this.product9Brands = this.kitchenProducts.filter(x => x.categoryCode === '300');
    this.formData.selectedBrand9 = _.first(this.product9Brands.filter(x => x.isDefault));

    this.formData.accessories = this.kitchenProducts.filter(x => x.categoryCode === '100');
    this.formData.accessories.forEach((x) => { x.isChecked = false; });

  }

  onKitchenChange(event) {
    this.formData.selectedKitchen = event;
    this.formData.B = this.formData.selectedKitchen.sides > 1 ? { feet: 0, inches: 0, type: Dimension.WIDTH } : null;
    this.formData.C = this.formData.selectedKitchen.sides > 2 ? { feet: 0, inches: 0, type: Dimension.HEIGHT } : null;
  }

  calculateCostByBrand(): number {
    const area = this.calculateArea();
    let totalCost: number = 0;
    totalCost = this.formData.selectedBrand1 ? (+this.formData.selectedBrand1.mrp * this.formData.selectedBrand1.multiplier) * (area / this.formData.selectedBrand1.divisor) : 0;
    totalCost = this.formData.selectedBrand2 ? totalCost + (this.formData.selectedBrand2.mrp * this.formData.selectedBrand2.multiplier) * (area / this.formData.selectedBrand2.divisor) : totalCost;
    totalCost = this.formData.selectedBrand3 ? totalCost + (this.formData.selectedBrand3.mrp * this.formData.selectedBrand3.multiplier) * (area / this.formData.selectedBrand3.divisor) : totalCost;
    totalCost = this.formData.selectedBrand4 ? totalCost + (this.formData.selectedBrand4.mrp * this.formData.selectedBrand4.multiplier) * (area / this.formData.selectedBrand4.divisor) : totalCost;
    totalCost = this.formData.selectedBrand5 ? totalCost + (this.formData.selectedBrand5.mrp * this.formData.selectedBrand5.multiplier) * (area / this.formData.selectedBrand5.divisor) : totalCost;
    totalCost = this.formData.selectedBrand6 ? totalCost + (this.formData.selectedBrand6.mrp * this.formData.selectedBrand6.multiplier) * (area / this.formData.selectedBrand6.divisor) : totalCost;
    totalCost = this.formData.selectedBrand7 ? totalCost + (this.formData.selectedBrand7.mrp * this.formData.selectedBrand7.multiplier) * (area / this.formData.selectedBrand7.divisor) : totalCost;
    totalCost = this.formData.selectedBrand8 ? totalCost + (this.formData.selectedBrand8.mrp * this.formData.selectedBrand8.multiplier) * (area / this.formData.selectedBrand8.divisor) : totalCost;

    totalCost = Math.round(totalCost) + this.calculateAccessories();
    totalCost = this.formData.selectedBrand9 ? (totalCost + this.formData.selectedBrand9.mrp) : totalCost;
    this.kitchenPrice.emit(totalCost);
    this.formData.totalPrice = totalCost;
    return totalCost;
  }

  reset() {
    this.formData = {};
    this.kitchenPrice.emit(0);
    this.initializeFormData();
    this.formData.accessories = this.kitchenProducts.filter(x => x.categoryCode === '100');
    this.formData.accessories.forEach((x) => { x.isChecked = false; });
  }

  onSubmit() {
    this.calculateCostByBrand();
  }

  calculateArea = (): number => {

    const sideA = (+this.formData.A.feet + (+this.formData.A.inches) / 12); // Feet
    const sideB = +this.formData.selectedKitchen.sides > 1 ? (+this.formData.B.feet + (+this.formData.B.inches) / 12) : 0; // Feet
    const sideC = +this.formData.selectedKitchen.sides > 2 ? (+this.formData.C.feet + (+this.formData.C.inches) / 12) : 0; // Feet
    this.formData.totalArea = (sideA + sideB + sideC)
    if (this.formData.kitchenHeight === 'Standard')
      this.formData.totalArea = (this.formData.totalArea) * 5;
    else
      this.formData.totalArea = (this.formData.totalArea) * 6.5;

    return this.formData.totalArea;
  };

  addAnotherProduct(prod) {
    this.addAnother.emit(prod);
  }

  calculateAccessories = (): number => {
    let totalAccessories = 0;
    this.formData.accessories.filter(x => x.isChecked).forEach(x => {
      totalAccessories += x.mrp;
    });

    return totalAccessories;
  };
}



export class Kitchen {
  sides: number;
  value: string;
  name: string;
  imageUrl: string;
}
