import { Component, OnInit, Output, EventEmitter, Input } from '@angular/core';
import { dataTypeEnum } from 'src/app/shared/enums/app.enums';
import * as _ from 'underscore';
import { ProductsService } from 'src/app/shared/services/products.services';
import { ProductMaster } from 'src/app/shared/model/product';

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
  tileTypes: ProductMaster[];
  constructor(private readonly service: ProductsService) { }

  ngOnInit() {

    this.service.getProductsByCategory(500).subscribe(result => {
      this.tileTypes = result.singleResult;

      this.formData.totalPrice = 0;
      this.formData.area = 0;
      this.formData.selectedType = _.first(this.tileTypes);
    })
  }

  calculateCost() {
    this.formData.totalPrice = this.formData.area * this.formData.selectedType.mrp;
    this.tilesPrice.emit(this.formData.totalPrice);
  }

  reset(): any {
    this.formData = {};
    this.tilesPrice.emit(0);
  }

  addAnotherProduct(prod) {
    this.addAnother.emit(prod);
  }

  onSubmit(): any {
    this.calculateCost();
    window.scroll({
      top: 100,
      left: 0,
      behavior: 'smooth'
    });
  }

}
