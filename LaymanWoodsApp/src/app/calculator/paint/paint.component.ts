import { Component, OnInit, Output, EventEmitter, Input } from '@angular/core';
import { dataTypeEnum } from 'src/app/shared/enums/app.enums';
import * as _ from 'underscore';
import { ProductMaster } from 'src/app/shared/model/product';
import { ProductsService } from 'src/app/shared/services/products.services';

@Component({
  selector: 'app-paint',
  templateUrl: './paint.component.html',
  styleUrls: ['./paint.component.scss']
})
export class PaintComponent implements OnInit {


  @Output() readonly paintPrice: EventEmitter<any> = new EventEmitter<any>();
  @Output() readonly addAnother: EventEmitter<any> = new EventEmitter<any>();
  @Input('next') nextProduct: number;

  dataType: any = dataTypeEnum;
  formData: any = {};
  constructor(private readonly service: ProductsService) { }

  paintTypes: ProductMaster[];

  ngOnInit() {

    this.service.getProductsByCategory(400).subscribe(result => {
      this.paintTypes = result.singleResult;

      this.formData.totalPrice = 0;
      this.formData.area = 0;
      this.formData.selectedType = _.first(this.paintTypes);
    })

  }

  calculateCost() {
    this.formData.totalPrice = this.formData.area * this.formData.selectedType.mrp;
    this.paintPrice.emit(this.formData.totalPrice);
  }

  addAnotherProduct(prod) {
    this.addAnother.emit(prod);
  }

  reset(): any {
    this.formData = {};
    this.paintPrice.emit(0);
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
