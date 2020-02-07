import { Component, OnInit, Output, EventEmitter, Input } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
import { DataService } from 'src/app/shared/services/data.service';
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

    this.formData.A = { feet: 0, inches: 0, type: Dimension.LENGTH };
    this.formData.B = this.formData.selectedKitchen.sides > 1 ? { feet: 0, inches: 0, type: Dimension.WIDTH } : null;
    this.formData.C = this.formData.selectedKitchen.sides > 2 ? { feet: 0, inches: 0, type: Dimension.HEIGHT } : null;
  }

  initializeBrands() {
    this.product1Brands = this.kitchenProducts.filter(x => x.categoryCode === '101');
    this.formData.selectedBrand1 = _.first(this.product1Brands);

    this.product2Brands = this.kitchenProducts.filter(x => x.categoryCode === '102');
    this.formData.selectedBrand2 = _.first(this.product2Brands);

    this.product3Brands = this.kitchenProducts.filter(x => x.categoryCode === '103');
    this.formData.selectedBrand3 = _.first(this.product3Brands);

    this.product4Brands = this.kitchenProducts.filter(x => x.categoryCode === '104');
    this.formData.selectedBrand4 = null; // _.first(this.product4Brands);

    this.product5Brands = this.kitchenProducts.filter(x => x.categoryCode === '105');
    this.formData.selectedBrand5 = null; //  _.first(this.product5Brands);

    this.product6Brands = this.kitchenProducts.filter(x => x.categoryCode === '106');
    this.formData.selectedBrand6 = null; //  _.first(this.product6Brands);

    this.product7Brands = this.kitchenProducts.filter(x => x.categoryCode === '107');
    this.formData.selectedBrand7 = null; // _.first(this.product7Brands);

    this.product8Brands = this.kitchenProducts.filter(x => x.categoryCode === '200');
    this.formData.selectedBrand8 = null; //  _.first(this.product8Brands);

    this.product9Brands = this.kitchenProducts.filter(x => x.categoryCode === '300');
    this.formData.selectedBrand9 = null; //  _.first(this.product8Brands);

    this.formData.accessories = this.kitchenProducts.filter(x => x.categoryCode === '100');
    this.formData.accessories.forEach((x) => { x.isChecked = false; });

  }

  onKitchenChange(event) {
    this.formData.selectedKitchen = event;
    this.formData.B = this.formData.selectedKitchen.sides > 1 ? { feet: 0, inches: 0, type: Dimension.WIDTH } : null;
    this.formData.C = this.formData.selectedKitchen.sides > 2 ? { feet: 0, inches: 0, type: Dimension.HEIGHT } : null;
  }

  calculateCostByBrand(): number {
    const area = this.formData.totalArea;
    let totalCost: number = 0;
    totalCost = this.formData.selectedBrand1 ? +this.formData.selectedBrand1.mrp : 0;
    totalCost = this.formData.selectedBrand2 ? (totalCost + this.formData.selectedBrand2.mrp) : totalCost;
    totalCost = this.formData.selectedBrand3 ? (totalCost + this.formData.selectedBrand3.mrp) : totalCost;
    totalCost = this.formData.selectedBrand4 ? (totalCost + this.formData.selectedBrand4.mrp) : totalCost;
    totalCost = this.formData.selectedBrand5 ? (totalCost + this.formData.selectedBrand5.mrp) : totalCost;
    totalCost = this.formData.selectedBrand6 ? (totalCost + this.formData.selectedBrand6.mrp) : totalCost;
    totalCost = this.formData.selectedBrand7 ? (totalCost + this.formData.selectedBrand7.mrp) : totalCost;
    totalCost = this.formData.selectedBrand8 ? (totalCost + this.formData.selectedBrand8.mrp) : totalCost;
    totalCost = this.formData.selectedBrand9 ? (totalCost + this.formData.selectedBrand9.mrp) : totalCost;
    const cumulativeSum = Math.round(totalCost * area) + this.calculateAccessories();
    this.kitchenPrice.emit(cumulativeSum);
    this.formData.totalPrice = cumulativeSum;
    return cumulativeSum;
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
    window.scroll({ 
      top: 100, 
      left: 0, 
      behavior: 'smooth' 
    });
  }

  calculateArea = (): number => {

    const sideA = (+this.formData.A.feet + (+this.formData.A.inches) / 12); // Feet
    const sideB = +this.formData.selectedKitchen.sides > 1 ? (+this.formData.B.feet + (+this.formData.B.inches) / 12) : 0; // Feet
    const sideC = +this.formData.selectedKitchen.sides > 2 ? (+this.formData.C.feet + (+this.formData.C.inches) / 12) : 0; // Feet
    this.formData.totalArea = (sideA + sideB + sideC)

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
