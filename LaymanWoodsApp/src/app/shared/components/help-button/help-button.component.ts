import { Component, OnInit, Input } from '@angular/core';
import { ProductMaster } from '../../model/product';

@Component({
  selector: 'ipx-help-button',
  template: `<a  class="btn btn-default" [href]="navigateTo" target="_blank" role="button"  [ngStyle]="{'margin-left': position === 'right'? margin: 0, 'margin-right': position === 'left'? margin: 0 }">{{text}}</a>`,
  styleUrls: ['./help-button.component.scss']
})
export class HelpButtonComponent implements OnInit {

  @Input('text') text = 'Help';
  @Input('product') product: ProductMaster;
  @Input('position') position = 'left';
  @Input('margin') margin = '0';
  navigateTo: string;

  ngOnInit() {
    if(this.product)
    this.navigateTo = 'help-page/' + this.product.categoryCode + '/' + this.product.productID;
    else
    this.navigateTo = 'help-page/' + 0 + '/' + 0;
  }

}
