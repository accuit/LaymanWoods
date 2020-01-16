import { Component, OnInit, Output, EventEmitter } from '@angular/core';
import { dataTypeEnum } from 'src/app/shared/enums/app.enums';
import * as _ from 'underscore';

@Component({
  selector: 'app-paint',
  templateUrl: './paint.component.html',
  styleUrls: ['./paint.component.scss']
})
export class PaintComponent implements OnInit {


  @Output() readonly paintPrice: EventEmitter<any> = new EventEmitter<any>();
  dataType: any = dataTypeEnum;
  formData: any = {};
  constructor() { }

  paintTypes = [
    { id: 1, name: 'OBD DISTAMPER', cost: 12 },
    { id: 2, name: 'TRACTOR EMULSION DISTAMPER', cost: 22 },
    { id: 3, name: 'ASIAN ROYAL SHINE', cost: 45 },
    { id: 4, name: 'DULEX VELVET TOUCH', cost: 45 },
    { id: 5, name: 'BERGER PAINTS', cost: 45 }
  ]

  ngOnInit() {
    this.formData.totalPrice = 0;
    this.formData.area = 0;
    this.formData.selectedType = _.first(this.paintTypes);
  }

  calculateCost() {
    this.formData.totalPrice = this.formData.area * this.formData.selectedType.cost;
    this.paintPrice.emit(this.formData.totalPrice);
  }

}
