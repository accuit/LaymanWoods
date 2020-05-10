import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ComboBoxExampleComponent } from './combo-box-example/combo-box-example.component';
import { DevPagesComponent } from './dev-pages.component';
import { SharedModule } from '../shared/shared.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
import { DevPagesRoutingModule } from './dev-pages-routing.module';
import { DropdownExampleComponent } from './dropdown/dropdown-example.component';
import { RadiobuttonExampleComponent } from './radio-button/radiobutton-example.component';


@NgModule({
  declarations: [ComboBoxExampleComponent, DevPagesComponent, DropdownExampleComponent, RadiobuttonExampleComponent],
  imports: [
    CommonModule,
    FormsModule,
    RouterModule,
    DevPagesRoutingModule,
    ReactiveFormsModule,
    SharedModule
  ]
})
export class DevPagesModule { }
