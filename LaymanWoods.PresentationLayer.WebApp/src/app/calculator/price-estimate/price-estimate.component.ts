import { Component, OnInit, Input } from '@angular/core';

@Component({
  selector: 'app-price-estimate',
  templateUrl: './price-estimate.component.html',
  styleUrls: ['./price-estimate.component.scss', '../calculator.component.scss']
})
export class PriceEstimateComponent implements OnInit {
  @Input('items') items: Item[];
  @Input('title') title: string;
  @Input('value') value: string;
  constructor() { }

  ngOnInit() {
  }

}

export class Item {
  key: string;
  value: string;
  cost: number;
  image: string = 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcT0am_nWvMKukVez3g9-l2Go0xg3pkjB7DMfTvcGwHRwZmG5i7u';
}
