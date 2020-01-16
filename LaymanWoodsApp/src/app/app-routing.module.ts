import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { HomeComponent } from './home/home.component';
import { AboutComponent } from './about/about.component';
import { ContactComponent } from './contact/contact.component';
import { ServicesComponent } from './services/services.component';
import { PortfolioComponent } from './portfolio/portfolio.component';
import { ServiceDetailsComponent } from './services/service-details/service-details.component';

const routes: Routes = [
  {
    path: '',
    redirectTo: 'home',
    pathMatch: 'full'
  },
  {
    path: 'home',
    component: HomeComponent
  },
  {
    path: 'about-us',
    component: AboutComponent
  },
  {
    path: 'contact-us',
    component: ContactComponent
  },
  {
    path: 'services',
    component: ServicesComponent
  },
  {
    path: 'service-details/:id',
    component: ServiceDetailsComponent
  },
  {
    path: 'portfolio',
    component: PortfolioComponent
  },
  { path: 'calculator', loadChildren: () => import(`./calculator/calculator.module`).then(m => m.CalculatorModule) }
  // { path: 'example-page', loadChildren: () => import(`./dev-pages/dev-pages.module`).then(m => m.DevPagesModule) },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
