import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MenuHeaderComponent } from './menu-header/menu-header.component';
import { TopHeaderComponent } from './top-header/top-header.component';
import { RouterModule } from '@angular/router';
import { TitleHeaderComponent } from './title-header/title-header.component';
import { ComponentsModule } from './components/components.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { DirectiveModule } from './directive/directive.module';
import { ProductsService } from './services/products.services';
import { SanitizeUrlPipe } from './pipes/sanitize-url.pipe';

@NgModule({
  declarations: [MenuHeaderComponent, TopHeaderComponent, TitleHeaderComponent, SanitizeUrlPipe],
  imports: [
    FormsModule,
    ReactiveFormsModule,
    CommonModule,
    RouterModule,
    ComponentsModule,
    DirectiveModule
  ],
  exports: [
    ComponentsModule,
    DirectiveModule,
    MenuHeaderComponent,
    TopHeaderComponent,
    TitleHeaderComponent,
    SanitizeUrlPipe
  ],
  providers: [
    ProductsService
  ]
})
export class SharedModule { }
