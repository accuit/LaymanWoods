import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ComboTextboxComponent } from './combo-textbox/combo-textbox.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { AgmCoreModule } from '@agm/core';
import { ElementBaseComponent } from './element.base/element.base.component';
import { IpxTextFieldComponent } from './text-field/text-field.component';
import { IpxDropdownComponent } from './custom-dropdown/ipx-dropdown.component';
import { IpxRadioButtonComponent } from './radio-button/ipx-radio-button.component';
import { IpxCheckboxComponent } from './check-box/check-box.component';
import { HelpButtonComponent } from './help-button/help-button.component';
import { AddAnotherButtonComponent } from './add-another-button/add-another-button.component';
import { IpxContactFormComponent } from './ipx-contact-form/ipx-contact-form.component';

const components = [ComboTextboxComponent, IpxDropdownComponent, ElementBaseComponent, IpxTextFieldComponent, IpxRadioButtonComponent, IpxCheckboxComponent, HelpButtonComponent, AddAnotherButtonComponent, IpxContactFormComponent];
@NgModule({
  declarations: components ,
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    AgmCoreModule.forRoot({
      apiKey: 'AIzaSyBm1jgcY8vXmfYeekqCT4iXHOVE8z2pjbQ'
    })
  ],
  exports: components
})
export class ComponentsModule { }
