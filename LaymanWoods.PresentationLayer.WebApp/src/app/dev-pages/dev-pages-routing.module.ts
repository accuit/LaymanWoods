import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { ComboBoxExampleComponent } from './combo-box-example/combo-box-example.component';
import { DevPagesComponent } from './dev-pages.component';
import { IpxDropdownComponent } from '../shared/components/custom-dropdown/ipx-dropdown.component';
import { DropdownExampleComponent } from './dropdown/dropdown-example.component';
import { RadiobuttonExampleComponent } from './radio-button/radiobutton-example.component';


const routes: Routes = [
  {
    path: '',
    component: DevPagesComponent
  },
  {
    path: 'combo-text',
    component: ComboBoxExampleComponent
  },
  {
    path: 'dropdown',
    component: DropdownExampleComponent
  },
  {
    path: 'radio',
    component: RadiobuttonExampleComponent
  }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class DevPagesRoutingModule { }
