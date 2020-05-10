import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { KitchenComponent } from './kitchen/kitchen.component';
import { CalculatorComponent } from './calculator.component';
import { RouterModule } from '@angular/router';
import { CalculatorRoutingModule } from './calculator-routing.module';
import { SharedModule } from '../shared/shared.module';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { PriceEstimateComponent } from './price-estimate/price-estimate.component';
import { WardrobeComponent } from './wardrobe/wardrobe.component';
import { FalseCeilingComponent } from './false-ceiling/false-ceiling.component';
import { PaintComponent } from './paint/paint.component';
import { TilesComponent } from './tiles/tiles.component';



@NgModule({
  declarations: [KitchenComponent, CalculatorComponent, PriceEstimateComponent, WardrobeComponent, FalseCeilingComponent, PaintComponent, TilesComponent],
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    RouterModule,
    CalculatorRoutingModule,
    SharedModule
  ]
})
export class CalculatorModule { }
