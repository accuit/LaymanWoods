import { Component, OnInit, Output, EventEmitter, Input } from '@angular/core';
import { FormGroup } from '@angular/forms';
import { ProductMaster } from 'src/app/shared/model/product';
import { DimensionEnum, WebPartTypeEnum, InteriorEnum, CalculationCostTypeEnum } from 'src/app/shared/enums/app.enums';
import * as _ from 'underscore';
import { ProductsService } from 'src/app/shared/services/products.services';
import { CompleteInteriorListing } from 'src/app/shared/model/interior';

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
  interiorCategories: CompleteInteriorListing[];

  kitchens: Kitchen[] = [
    { sides: 2, value: 'L', name: 'L Shape', imageUrl: 'https://interioreradotin.files.wordpress.com/2019/02/l-shape-kitchen-banner-4.jpg?w=775' },
    { sides: 3, value: 'U', name: 'U Shape', imageUrl: 'http://digitalb2btrade.com/static/listing-image/1551787072u-shape.jpg' },
    { sides: 1, value: 'I', name: 'Single Side I Shape', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSp-Ob2Re5RoosQmTW08Wqco81kD3Pytyere6Bi4xBXOd3Z_T2a' },
    { sides: 2, value: 'P', name: 'Parallel Shape', imageUrl: 'http://royalkitchenworld.com/wp-content/uploads/2017/03/gallary_16_3.jpg' },
  ];

  selectedKitchen: Kitchen;
  formData: any = {};

  constructor(private readonly service: ProductsService) { }

  ngOnInit() {
    this.initializeFormData();
    this.service.getInteriorCategories(+InteriorEnum.Kitchen).subscribe(result => {
      this.interiorCategories = result;
      this.getProductFormData();
    });
  }

  getProductFormData() {
    this.formData.categories = new Array<CompleteInteriorListing>();
    this.interiorCategories.forEach(c => {
      c.selectedProduct = new ProductMaster();
      const defaultProduct = c.products.filter(x => x.isDefault);
      c.selectedProduct = _.first(defaultProduct.length ? defaultProduct : c.products);
      if (c.webPartType === WebPartTypeEnum.Checkbox) {
        c.selectedProduct = null;
        c.products.forEach((x) => { x.isChecked = false; });
      }
    });
    this.formData.categories = this.interiorCategories;
  }

  specialProductRules(product: ProductMaster): void {
    if (product.skuCode === 'ENTC') {
      this.interiorCategories.splice(6, 1); //x => x.category.categoryCode != '106');
    }
  }

  initializeFormData() {
    this.formData.totalPrice = 0;
    this.formData.totalArea = 0;
    this.formData.selectedKitchen = _.first(this.kitchens);
    this.formData.kitchenHeight = 'Standard';

    this.formData.A = { feet: 10, inches: 0, type: DimensionEnum.LENGTH };
    this.formData.B = this.formData.selectedKitchen.sides > 1 ? { feet: 10, inches: 0, type: DimensionEnum.WIDTH } : null;
    this.formData.C = this.formData.selectedKitchen.sides > 2 ? { feet: 10, inches: 0, type: DimensionEnum.HEIGHT } : null;
  }

  onKitchenChange(event) {
    this.formData.selectedKitchen = event;
    this.formData.B = this.formData.selectedKitchen.sides > 1 ? { feet: 10, inches: 0, type: DimensionEnum.WIDTH } : null;
    this.formData.C = this.formData.selectedKitchen.sides > 2 ? { feet: 10, inches: 0, type: DimensionEnum.HEIGHT } : null;
  }

  calculateCostByBrand(): number {
    const area = this.calculateArea();
    let totalCost: number = 0;
    this.interiorCategories.forEach(x => {
      if (x.selectedProduct) {
        if (x.selectedProduct.measurementUnit === +CalculationCostTypeEnum.AreaMultiply) {
          totalCost = totalCost + (x.selectedProduct.mrp * x.multiplier) * (area / x.divisor);
        } else if (x.selectedProduct.measurementUnit === +CalculationCostTypeEnum.Quantity) {
          totalCost = totalCost + x.selectedProduct.mrp;
        }
        console.log(x.selectedProduct.title + ': (' + x.selectedProduct.mrp + "*" + x.multiplier + ') * (' + area + '/' + x.divisor + ')');
     
      }
      
      x.products.forEach(x => {
        totalCost = x.isChecked ? totalCost + x.mrp : totalCost;
      });
    });

    totalCost = Math.round(totalCost)
    this.kitchenPrice.emit(totalCost);
    this.formData.totalPrice = totalCost;
    return totalCost;
  }

  reset() {
    this.kitchenPrice.emit(0);
    this.initializeFormData();
    this.getProductFormData();
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
