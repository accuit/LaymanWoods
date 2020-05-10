import { Component, OnInit, EventEmitter, Output, Input } from "@angular/core";

@Component({
  selector: "app-add-another-button",
  templateUrl: "add-another-button.component.html"
})
export class AddAnotherButtonComponent implements OnInit {
  @Output() readonly addAnother: EventEmitter<any> = new EventEmitter<any>();
  @Output() readonly reset: EventEmitter<any> = new EventEmitter<any>();
  @Input("next") nextProduct: number;
  @Input("show-add-another") showAnother = true;
  products: any;


  ngOnInit() {
    this.products = [
      { key: 1, value: "Kitchen", cost: 0 },
      { key: 2, value: "Wardrobe", cost: 0 },
      { key: 3, value: "False Ceiling", cost: 0 },
      { key: 4, value: "Paint", cost: 0 },
      { key: 5, value: "Tiles", cost: 0 }
    ];
  }

  resetForm(event){
    this.reset.emit(event);
  }

  addAnotherProduct() {
    const next = this.products.filter(x => x.key === +this.nextProduct)[0];
    this.addAnother.emit(next);
    window.scroll({
      top: 100,
      left: 0,
      behavior: "smooth"
    });
  }
}
