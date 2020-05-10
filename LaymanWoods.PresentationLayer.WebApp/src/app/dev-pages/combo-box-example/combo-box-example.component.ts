import { Component, OnInit, AfterContentInit } from '@angular/core';
import { Unit } from 'src/app/shared/model/core.model';
import { DimensionEnum } from 'src/app/shared/enums/app.enums';

@Component({
  selector: 'app-combo-box-example',
  templateUrl: './combo-box-example.component.html',
  styleUrls: ['./combo-box-example.component.scss']
})
export class ComboBoxExampleComponent implements AfterContentInit {

  dimension = DimensionEnum.LENGTH;
   A: Unit = { feet: 0, inches: 0, type: DimensionEnum.LENGTH };
   B: Unit = { feet: 0, inches: 0, type: DimensionEnum.WIDTH };
   C: Unit = { feet: 0, inches: 0, type: DimensionEnum.HEIGHT };

  constructor() { }

  ngAfterContentInit() {
     this.A = { feet: 10, inches: 20, type: DimensionEnum.LENGTH };
  }


}
