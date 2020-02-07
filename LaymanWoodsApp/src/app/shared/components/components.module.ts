import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ComboTextboxComponent } from './combo-textbox/combo-textbox.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { ElementBaseComponent } from './element.base/element.base.component';
import { IpxTextFieldComponent } from './text-field/text-field.component';
import { IpxDropdownComponent } from './custom-dropdown/ipx-dropdown.component';
import { IpxRadioButtonComponent } from './radio-button/ipx-radio-button.component';
import { IpxCheckboxComponent } from './check-box/check-box.component';
import { HelpButtonComponent } from './help-button/help-button.component';
import { AddAnotherButtonComponent } from './add-another-button/add-another-button.component';



@NgModule({
  declarations: [ComboTextboxComponent, IpxDropdownComponent, ElementBaseComponent, IpxTextFieldComponent, IpxRadioButtonComponent, IpxCheckboxComponent, HelpButtonComponent, AddAnotherButtonComponent],
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule
  ],
  exports: [ComboTextboxComponent, HelpButtonComponent, IpxDropdownComponent, ElementBaseComponent, IpxTextFieldComponent, IpxRadioButtonComponent, IpxCheckboxComponent, AddAnotherButtonComponent]
})
export class ComponentsModule { }
