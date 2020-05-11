import { Component, OnInit, Input } from '@angular/core';
import { ProductsService } from '../shared/services/products.services';
import { Router, ActivatedRoute } from '@angular/router';
import { ProductMaster, ProductHelp } from '../shared/model/product';
import { APIResponse } from '../shared/model/core.model';

@Component({
  selector: 'app-help-page',
  templateUrl: './help-page.component.html',
  styleUrls: ['./help-page.component.scss']
})
export class HelpPageComponent implements OnInit {

  helpContent: ProductHelp;
  noDataFound = false;
  constructor(private readonly service: ProductsService, private router: Router, private routerAct: ActivatedRoute) {
  }

  ngOnInit() {
    this.routerAct.params.subscribe(res => {
      this.getData(res.code, res.id);
    })

  }

  getData(code = '0', id) {
    this.service.getProductHelp(code, id).subscribe((res: APIResponse) => {
      if (res.isSuccess)
        this.helpContent = res.singleResult;
        else
        this.noDataFound = true;
    });
  }

}
