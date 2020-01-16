import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { MenuHeaderComponent } from './menu-header/menu-header.component';
import { TopHeaderComponent } from './top-header/top-header.component';
import { RouterModule } from '@angular/router';
import { TitleHeaderComponent } from './title-header/title-header.component';
import { ComponentsModule } from './components/components.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { DirectiveModule } from './directive/directive.module';


@NgModule({
  declarations: [MenuHeaderComponent, TopHeaderComponent, TitleHeaderComponent],
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
    TitleHeaderComponent
  ]
})
export class SharedModule { }
