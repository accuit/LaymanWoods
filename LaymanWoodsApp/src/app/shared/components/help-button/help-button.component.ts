import { Component, OnInit, Input } from '@angular/core';

@Component({
  selector: 'ipx-help-button',
  template: `<a class="btn btn-default" href="/help-page" role="button" style="font-size: medium;" [ngStyle]="{'margin-left': position === 'right'? '50px': 0, 'margin-right': position === 'left'? '50px': 0 }">{{text}}</a>`,
  styleUrls: ['./help-button.component.scss']
})
export class HelpButtonComponent implements OnInit {

  @Input('text') text = 'Help';
  @Input('product') product: string;
  @Input('position') position = 'left';
  constructor() { }

  ngOnInit() {
  }

}
