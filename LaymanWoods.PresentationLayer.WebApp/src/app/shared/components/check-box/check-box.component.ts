import { ChangeDetectionStrategy, Component, Input, OnInit } from '@angular/core';
import { ElementBaseComponent } from '../element.base/element.base.component';

@Component({
  selector: 'ipx-checkbox',
  templateUrl: './check-box.component.html',
  changeDetection: ChangeDetectionStrategy.OnPush
})
export class IpxCheckboxComponent extends ElementBaseComponent<boolean> implements OnInit {

  @Input() label: string;
  @Input() labelValues: any;
  @Input() info: any;
  @Input() infoData: any;

  ngOnInit(): void {
    // tslint:disable-next-line: strict-boolean-expressions
    this.label = this.label || '';
    const attr = this.el.nativeElement.attributes;
    if (attr.disabled) {
      this.disabled = true;
    }
  }

  onClick(): any {
    if (!this.disabled) {
      this.value = !this.value;
      this._onChange(this.value);
      this.onChange.emit(this.value);
    }
  }
}
