import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { CalculatorModule } from './calculator/calculator.module';
import { SharedModule } from './shared/shared.module';
import { HomeComponent } from './home/home.component';
import { RouterModule } from '@angular/router';
import { DevPagesModule } from './dev-pages/dev-pages.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { AboutComponent } from './about/about.component';
import { ServicesComponent } from './services/services.component';
import { PortfolioComponent } from './portfolio/portfolio.component';
import { ContactComponent } from './contact/contact.component';
import { ServiceDetailsComponent } from './services/service-details/service-details.component';

@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    AboutComponent,
    ServicesComponent,
    PortfolioComponent,
    ContactComponent,
    ServiceDetailsComponent
  ],
  imports: [
    BrowserModule,
    RouterModule,
    FormsModule,
    ReactiveFormsModule,
    AppRoutingModule,
    CalculatorModule,
    SharedModule,
    DevPagesModule
  ],
  providers: [],
  bootstrap: [AppComponent, HomeComponent, AboutComponent, PortfolioComponent, ServicesComponent]
})
export class AppModule { }
