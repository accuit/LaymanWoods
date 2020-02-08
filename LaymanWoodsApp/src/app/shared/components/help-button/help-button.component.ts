import { Component, OnInit, Input } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'ipx-help-button',
  template: `<button class="btn btn-default" (click)="navigate()" role="button" style="font-size: medium;" [ngStyle]="{'margin-left': position === 'right'? '50px': 0, 'margin-right': position === 'left'? '50px': 0 }">{{text}}</button> {{product | json}}`,
  styleUrls: ['./help-button.component.scss']
})
export class HelpButtonComponent implements OnInit {

  @Input('text') text = 'Help';
  @Input('product') product: any;
  @Input('position') position = 'left';

  constructor(private readonly router: Router) { }

  ngOnInit() {
  }

  navigate() {
    if (this.product)
      this.router.navigate(['help-page'], this.product);
  }

}
