import { Component, OnInit, Input } from '@angular/core';
import { ProductsService } from '../shared/services/products.services';
import { Router } from '@angular/router';
import { ProductMaster, ProductHelp } from '../shared/model/product';

@Component({
  selector: 'app-help-page',
  templateUrl: './help-page.component.html',
  styleUrls: ['./help-page.component.scss']
})
export class HelpPageComponent implements OnInit {

  helpContent: ProductHelp;
  product: ProductMaster;
  constructor(private readonly service: ProductsService, private router: Router) {

    const navigation = this.router.getCurrentNavigation();
    this.product = navigation.extras as ProductMaster;
  }

  ngOnInit() {
    this.service.getProductHelp(this.product.productID).subscribe((res: any) => {
      this.helpContent = res;
    }
    );

  }

}
