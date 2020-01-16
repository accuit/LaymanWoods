import { ChangeDetectionStrategy, ChangeDetectorRef, Component, ElementRef, Input, OnInit, Optional, Renderer2, Self, ViewChild } from '@angular/core';
import { NgControl } from '@angular/forms';
import * as  _ from 'underscore';
import { ElementBaseComponent } from '../element.base/element.base.component';

@Component({
  selector: 'ipx-dropdown',
  templateUrl: './ipx-dropdown.component.html',
  changeDetection: ChangeDetectionStrategy.OnPush
})

export class IpxDropdownComponent extends ElementBaseComponent implements OnInit {
  @Input() label: string;
  @Input() labelValue: string;
  @Input() set options(values: Array<any>) {
    this._options = values;
    if (this._options && this._options.length > 0) {
      this._resetInvalidSeletion(this._options);
    }
  }
  @Input() keyField: string;
  @Input() displayField: string;
  @Input() optionalValue: string;
  @ViewChild('selectref', { static: false }) select: ElementRef;
  isOptional: boolean;
  identifier: string;
  applyTranslate: boolean;
  _options = [];

  constructor(private readonly renderer: Renderer2, @Self() @Optional() public control: NgControl, public el: ElementRef, cdr: ChangeDetectorRef) {
    super(control, el, cdr);
  }

  ngOnInit(): void {
    this.identifier = this.getId('dropdown');
    this.applyTranslate = this.shouldTranslate();
    this.isOptional = this.el.nativeElement.getAttribute('required') == null ? true : false;
  }

  shouldTranslate(): boolean {
    if (!_.any(this._options)) {
      return false;
    }

    const anyItem = this.displayField ? _.first(this._options)[this.displayField]
      : _.first(this._options);

    return typeof (anyItem) === 'string';
  }

  setDisabledState(isDisabled: boolean): void {
    isDisabled ? this.renderer.setAttribute(this.select.nativeElement, 'disabled', 'disabled') : this.renderer.removeAttribute(this.select.nativeElement, 'disabled');
  }

  change = (newValue): void => {
    this.value = newValue;
    this._onChange(this.value);
    this.onChange.emit(this.value);
  };

  trackByFn = (index: number, item: any): any => {
    return item;
  };

  writeValue = (value: any) => {
    if (typeof(value) === 'string' || typeof(value) === 'number') {
      this.value = value;
    } else if (value && this.displayField)  {
      const val = _.filter(this._options, (option) => {
        return option[this.displayField] === value[this.displayField];
      });
      this.value = _.first(val);
    } else {
      this.value = value;
    }
  };

  _resetInvalidSeletion = (options: Array<any>) => {
    if (this.value) {
      if (typeof (this.value) === 'string' || typeof (this.value) === 'number') {
        if (options.filter(v => v === this.value).length === 0) {
          this.value = null;
        }
      } else if (this.displayField) {
        if (options.filter(v => v[this.displayField] === this.value[this.displayField]).length === 0) {
          this.value = null;
        }
      }
    }
  };
}
