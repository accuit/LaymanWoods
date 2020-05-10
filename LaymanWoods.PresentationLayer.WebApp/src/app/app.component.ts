import { Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  title = 'LaymanWoods';

  constructor(private readonly router: Router) {
    // this.router.navigate(["/"]).then(result=>{window.location.href = '/home.html';})
    // window.location.href= '/home.html';
    // router.navigate(['localhost:4200/home.html']);
  }
}
