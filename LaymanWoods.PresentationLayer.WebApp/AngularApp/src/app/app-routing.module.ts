import { NgModule } from "@angular/core";
import { Routes, RouterModule } from "@angular/router";
import { HomeComponent } from "./home/home.component";
import { AboutComponent } from "./about/about.component";
import { ContactComponent } from "./contact/contact.component";
import { ServicesComponent } from "./services/services.component";
import { PortfolioComponent } from "./portfolio/portfolio.component";
import { ServiceDetailsComponent } from "./services/service-details/service-details.component";
import { HelpPageComponent } from "./help-page/help-page.component";
import { TalkToExpertComponent } from "./talk-to-expert/talk-to-expert.component";
import { CalculatorComponent } from "./calculator/calculator.component";
import { PageNotFoundComponent } from "./page-not-found/page-not-found.component";

const routes: Routes = [
  {
    path: "",
    component: HomeComponent
  },
  {
    path: "home",
    component: HomeComponent
  },
  {
    path: "about-us",
    component: AboutComponent
  },
  {
    path: "contact-us",
    component: ContactComponent
  },
  {
    path: "services",
    component: ServicesComponent
  },
  {
    path: "service-details/:id",
    component: ServiceDetailsComponent
  },
  {
    path: "portfolio",
    component: PortfolioComponent
  },
  {
    path: "calculator",
    component: CalculatorComponent
  },
  {
    path: "help-page/:code/:id",
    component: HelpPageComponent
  },
  {
    path: "talk-to-expert",
    component: TalkToExpertComponent
  },
  {
    path: "**",
    component: PageNotFoundComponent
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule {}
