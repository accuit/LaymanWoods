import { Component, OnInit, Output, EventEmitter } from '@angular/core';
import { FormGroup, FormBuilder } from '@angular/forms';
import { DataService } from 'src/app/shared/services/data.service';
import { Product } from 'src/app/shared/model/product';
import { Dimension } from 'src/app/shared/enums/app.enums';
import * as _ from 'underscore';

@Component({
  selector: 'app-kitchen',
  templateUrl: './kitchen.component.html',
  styleUrls: ['./kitchen.component.scss', '../calculator.component.scss']
})
export class KitchenComponent implements OnInit {

  @Output() readonly kitchenPrice: EventEmitter<any> = new EventEmitter<any>();
  formGroup: FormGroup;
  kitchenProducts: Product[];
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

  product1Brands: any;
  product2Brands: any;
  product3Brands: any;
  product4Brands: any;
  product5Brands: any;
  product6Brands: any;
  product7Brands: any;
  product8Brands: any;

  constructor(private readonly dataService: DataService) { }

  ngOnInit() {
    this.initializeFormData();
    this.initializeBrands();

    this.kitchenProducts = this.dataService.getProducts().filter(x => x.categories.filter(y => y === this.kitchenCategoryID));
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

  onKitchenChange(event) {
    this.formData.selectedKitchen = event;
    this.formData.B = this.formData.selectedKitchen.sides > 1 ? { feet: 0, inches: 0, type: Dimension.WIDTH } : null;
    this.formData.C = this.formData.selectedKitchen.sides > 2 ? { feet: 0, inches: 0, type: Dimension.HEIGHT } : null;
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
    const cumulativeSum = Math.round(totalCost * area)
    this.kitchenPrice.emit(cumulativeSum);
    this.formData.totalPrice = cumulativeSum;
    return cumulativeSum;
  }

  calculateArea = (): number => {

    const sideA = (+this.formData.A.feet + (+this.formData.A.inches) / 12); // Feet
    const sideB = +this.formData.selectedKitchen.sides > 1 ? (+this.formData.B.feet + (+this.formData.B.inches) / 12) : 0; // Feet
    const sideC = +this.formData.selectedKitchen.sides > 2 ? (+this.formData.C.feet + (+this.formData.C.inches) / 12) : 0; // Feet
    this.formData.totalArea = (sideA + sideB + sideC)
    this.calculateCostByBrand();
    return this.formData.totalArea;
  };
}

export class Kitchen {
  sides: number;
  value: string;
  name: string;
  imageUrl: string;
}
