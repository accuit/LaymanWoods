import { Component, OnInit, AfterContentInit, ViewChild } from '@angular/core';

@Component({
  selector: 'app-calculator',
  templateUrl: './calculator.component.html',
  styleUrls: ['./calculator.component.scss']
})
export class CalculatorComponent implements OnInit, AfterContentInit {

  formData: any = {};
  constructor() { }

  ngOnInit() {
    this.formData.totalPrice = 0;
    this.formData.products = [
      { key: 1, value: 'Kitchen', cost: 0 },
      { key: 2, value: 'Wardrobe', cost: 0 },
      { key: 3, value: 'False Ceiling', cost: 0 },
      { key: 4, value: 'Paint', cost: 0 },
      { key: 5, value: 'Tiles', cost: 0 }
    ];
  }

  ngAfterContentInit(): void {
    this.formData.product = { key: 1, value: 'Kitchen' };
  }

  getPrice(cost, productType) {
    this.formData.products.find(x => x.key === productType).cost = cost;

    this.formData.totalPrice  = this.formData.products.reduce((a, b) => a + b.cost, 0);
  }

  onRadioChange(event): any {
    this.formData.product = event;
  }

}

export class MainProduct {
  key: number;
  value: string;
  cost: number;
}
