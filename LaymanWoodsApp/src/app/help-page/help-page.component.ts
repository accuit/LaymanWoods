import { Component, OnInit, Input } from '@angular/core';
import { ProductsService } from '../shared/services/products.services';
import { Router } from '@angular/router';

@Component({
  selector: 'app-help-page',
  templateUrl: './help-page.component.html',
  styleUrls: ['./help-page.component.scss']
})
export class HelpPageComponent implements OnInit {

  helpContent: any;
  product: any;
  constructor(private readonly service: ProductsService, private router: Router) {

    const navigation = this.router.getCurrentNavigation();
    this.product = navigation.extras;
  }

  ngOnInit() {

  }

}
