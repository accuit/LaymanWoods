import { Component, OnInit, Output, EventEmitter } from '@angular/core';
import { dataTypeEnum } from 'src/app/shared/enums/app.enums';
import * as _ from 'underscore';

@Component({
  selector: 'app-tiles',
  templateUrl: './tiles.component.html',
  styleUrls: ['./tiles.component.scss']
})
export class TilesComponent implements OnInit {

  @Output() readonly tilesPrice: EventEmitter<any> = new EventEmitter<any>();
  dataType: any = dataTypeEnum;
  formData: any = {};
  constructor() { }

  tileTypes = [
    { id: 1, name: 'Basic Tile 2X2', cost: 110 },
    { id: 2, name: 'Basic Tile 2X4', cost: 250 },
  ]

  ngOnInit() {
    this.formData.totalPrice = 0;
    this.formData.area = 0;
    this.formData.selectedType = _.first(this.tileTypes);
  }

  calculateCost() {
    this.formData.totalPrice = this.formData.area * this.formData.selectedType.cost;
    this.tilesPrice.emit(this.formData.totalPrice);
  }

}
