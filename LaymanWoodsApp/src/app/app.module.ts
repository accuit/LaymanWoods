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
import { HelpPageComponent } from './help-page/help-page.component';
import { HttpClientModule } from '@angular/common/http';
import { TalkToExpertComponent } from './talk-to-expert/talk-to-expert.component';
import { NotificationService } from './core/notification.service';
import { PageNotFoundComponent } from './page-not-found/page-not-found.component';
import { EntrepreneurComponent } from './entrepreneur/entrepreneur.component';

@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    AboutComponent,
    ServicesComponent,
    PortfolioComponent,
    ContactComponent,
    ServiceDetailsComponent,
    HelpPageComponent,
    TalkToExpertComponent,
    PageNotFoundComponent,
    EntrepreneurComponent
  ],
  imports: [
    BrowserModule,
    RouterModule,
    FormsModule,
    ReactiveFormsModule,
    AppRoutingModule,
    CalculatorModule,
    SharedModule,
    DevPagesModule,
    HttpClientModule
  ],
  providers: [NotificationService],
  bootstrap: [AppComponent, HomeComponent, AboutComponent, PortfolioComponent, ServicesComponent]
})
export class AppModule { }
