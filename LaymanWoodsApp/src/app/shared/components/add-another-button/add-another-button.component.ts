import { Component, OnInit, EventEmitter, Output, Input } from '@angular/core';

@Component({
  selector: 'app-add-another-button',
  template: '<button type="button" class="btn btn-md btn-danger" (click)="addAnotherProduct()">Add Another Product</button>'
})
export class AddAnotherButtonComponent implements OnInit {

  @Output() readonly addAnother: EventEmitter<any> = new EventEmitter<any>();
  products: any;
   @Input('next')nextProduct: number;
  constructor() { }

  ngOnInit() {
    this.products = [
      { key: 1, value: 'Kitchen', cost: 0 },
      { key: 2, value: 'Wardrobe', cost: 0 },
      { key: 3, value: 'False Ceiling', cost: 0 },
      { key: 4, value: 'Paint', cost: 0 },
      { key: 5, value: 'Tiles', cost: 0 }
    ];
  }

  addAnotherProduct() {
    const next = this.products.filter(x=>x.key === +this.nextProduct)[0];
    this.addAnother.emit(next);
    window.scroll({ 
      top: 100, 
      left: 0, 
      behavior: 'smooth' 
    });
  }
  

}
