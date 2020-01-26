import { Component, OnInit, EventEmitter, Output } from '@angular/core';
import { Dimension } from 'src/app/shared/enums/app.enums';

@Component({
  selector: 'app-false-ceiling',
  templateUrl: './false-ceiling.component.html',
  styleUrls: ['./false-ceiling.component.scss', '../calculator.component.scss']
})
export class FalseCeilingComponent implements OnInit {
  @Output() readonly ceilingPrice: EventEmitter<any> = new EventEmitter<any>();
  formData: any = {};
  constructor() { }
  ngOnInit() {
    this.initializeFormData();
  }

  initializeFormData() {
    this.formData.totalPrice = 0;
    this.formData.type = {id: 2, name: 'Corner'};
    this.formData.totalArea = 0;

    this.formData.A = { feet: 0, inches: 0, type: Dimension.LENGTH };
    this.formData.B = { feet: 0, inches: 0, type: Dimension.WIDTH }
  }

  onCeilingTypeChange(item) {
    this.formData.type = item;
    this.formData.totalPrice = 0;
    this.calculatePrice();
  }

  calculateArea = (): number => {
    const sideA = (+this.formData.A.feet + (+this.formData.A.inches) / 12); // Feet
    const sideB = (+this.formData.B.feet + (+this.formData.B.inches) / 12); // Feet
    return Math.round(sideA + sideB)

  };

  calculatePrice() {
    const area = this.formData.totalArea;
    const basicPrice = area * 120;
    const sideA: number = +this.formData.A.feet + +(this.formData.A.inches / 12);
    const sideB: number = +this.formData.B.feet + +(this.formData.B.inches / 12);
    const coverPrice = 2 * area * 240;
    const mouldingPrice: number =  40 * 2 * area;
    const C = .25;
    const wallPOP: number =  22 * (2 * area + 2 * sideB * C + C * sideA);

    if (this.formData.type.name === 'Cover') {
      this.formData.totalPrice = coverPrice + mouldingPrice + wallPOP;
    } else {
      this.formData.totalPrice = basicPrice + mouldingPrice + wallPOP;
    }
    this.ceilingPrice.emit(this.formData.totalPrice);
  }

  reset(): any {
    this.formData = {};
    this.ceilingPrice.emit(0);
    this.initializeFormData();
  }

  onSubmit(): any {
    this.calculatePrice();
    window.scroll({
      top: 100,
      left: 0,
      behavior: 'smooth'
    });
  }

}
