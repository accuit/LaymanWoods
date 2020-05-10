import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { IpxRadioButtonGroupDirective } from './radio/radio-group.directive';
import { DataTypeDirective } from './data-type.directive';

@NgModule({
  declarations: [IpxRadioButtonGroupDirective, DataTypeDirective],
  exports: [IpxRadioButtonGroupDirective, DataTypeDirective],
  imports: [
    CommonModule
  ]
})
export class DirectiveModule { }
