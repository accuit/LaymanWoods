import { Component, OnInit, forwardRef, Output, Input, EventEmitter, HostListener, HostBinding, ViewChild, ElementRef } from '@angular/core';
import { ControlValueAccessor, NG_VALUE_ACCESSOR, NG_VALIDATORS, FormControl, Validator, AbstractControl, ValidatorFn } from '@angular/forms';
import { Dimension } from '../../enums/app.enums';
import { Unit } from '../../model/core.model';
import { ElementBaseComponent } from '../element.base/element.base.component';
import * as _ from 'underscore';

@Component({
    selector: 'ipx-combo-textbox',
    templateUrl: './combo-textbox.component.html',
    styleUrls: ['./combo-textbox.component.scss']
})
export class ComboTextboxComponent extends ElementBaseComponent<any> implements OnInit {

    @Input() step: number = 1;
    @Input('name') name: any;
    @Input('value1') value1: any;
    @Input('value2') value2: any;
    @Input('label1') label1: string;
    @Input('label2') label2: string;
    @Input('textField1') textField1: string;
    @Input('textField2') textField2: string;
    @Input('placeholder1') placeholder1: string;
    @Input('placeholder2') placeholder2: string;
    @Input() minValue: number = 0;
    @Input() maxValue: number;
    @Output() focused: EventEmitter<any> = new EventEmitter();
    @Output() blured: EventEmitter<any> = new EventEmitter();
    @Output() valueChanged: EventEmitter<any> = new EventEmitter();
    model: any;

    availableControlKeys: string[] = ['Backspace', 'Space', 'ArrowUp', 'ArrowDown'];

    identifier: string;

    ngOnInit(): any {
        this.identifier = this.getId('combo');
        this.model = {};
    }

    writeValue = (value: any) => {

        if (value == null) {
            this.value1 = '';
            this.value2 = null;
        } else {
            this.value1 = value[this.textField1 || 'text1'];
            this.value2 = value[this.textField2 || 'text2'];
            this.model[this.textField1 || 'text1'] = this.value1;
            this.model[this.textField2 || 'text2'] = this.value2;
            //this.setTextField(this.isTextDisabled);
            this.value = Object.assign(value, this.model);
        }
    };

    change = (newValue: any): void => {
        this.model[this.textField1 || 'text2'] = newValue;
        this.value = Object.assign(this.value, this.model);
        this._onChange(this.value);
    };

    change2 = (newValue: any): void => {
        this.model[this.textField2 || 'text2'] = newValue;
        this.value = Object.assign(this.value, this.model);
        this._onChange(this.value);
    };

    @HostListener('mousewheel', ['$event'])
    changeStep(event) {
        if (event.ctrlKey) {
            event.preventDefault();

            if (event.wheelDelta > 0) {
                this.step += 1;
            } else if (event.wheelDelta < 0 && this.step > 1) {
                this.step -= 1;
            }
        }
    }

    sendFocusEvent(event):void {
        this.focused.emit(event);
      }
    
      sendBlurEvent(event):void {
        this.blured.emit(event);
      }

    manageValue(event, currentValue, currentTextBox, step, arrowChanged?, clipboardValue?): number {
        event.preventDefault();

        let newValue: number;
        let usedControlKeys;
        let charCode = String.fromCharCode(event.which).toLowerCase();
        const textField = event.target.attributes['ng-reflect-name'].value;
        if (arrowChanged) {
            usedControlKeys = [arrowChanged];
        } else {
            usedControlKeys = this.availableControlKeys.filter(key => key === event.code);
        }

        if (usedControlKeys.length) {
            newValue = this.modifiedValue(usedControlKeys[0], currentValue, step);
        } else if (event.type === 'paste') {
            newValue = +this.processInsertedValue(clipboardValue, currentValue);
        } else {
            newValue = this.inputValue(event.key, currentValue);
        }
        if (textField) {
            this.model[textField] = newValue;
            this.value = Object.assign(this.value, this.model);
            this._onChange(this.value);
            this.onChange.emit(this.value);
            this.valueChanged.emit(this.value);
            if (currentTextBox === 1) {
                this.value1 = newValue;
                return this.value1;
            } else {
                this.value2 = newValue;
                return this.value2;
            }

        }
    }

    modifiedValue(usedControl, currentValue, stepChange) {

        switch (usedControl) {

            case 'Backspace':
                return `${currentValue}`.slice(0, -1);

            case 'Space':
                return currentValue;

            case 'ArrowUp':
                return this.increaseValue(currentValue, stepChange);

            case 'ArrowDown':
                return this.decreaseValue(currentValue, stepChange);

            default:
                return currentValue;
        }
    }

    increaseValue(currentValue, stepChange) {
        if (currentValue && this.maxValue) {
            return currentValue < this.maxValue ? Number(currentValue) + stepChange : currentValue;
        } else if (!currentValue && this.maxValue) {
            return stepChange < this.maxValue ? stepChange : this.maxValue;
        } else {
            return currentValue ? Number(currentValue) + stepChange : stepChange;
        }
    }

    decreaseValue(currentValue, stepChange) {
        return currentValue && currentValue > this.minValue ? Number(currentValue) - stepChange : 0;
    }

    inputValue(usedKey, currentValue) {
        if (isNaN(usedKey)) { return currentValue; }

        if (currentValue) {

            return `${currentValue}${usedKey}`;
        } else {

            return `${usedKey}`
        }
    }

    processInsertedValue(clipboardValue, currentValue) {
        const passedValue = parseInt(clipboardValue, 10);
    }

    // // change events from the textarea
    // private onChange(event) {

    //     // get value from text area
    //     let newValue = event.target.value;

    //     try {
    //         // parse it to json
    //         this.data = JSON.parse(newValue);
    //         this.parseError = false;
    //     } catch (ex) {
    //         // set parse error if it fails
    //         this.parseError = true;
    //     }

    //     // update the form
    //     this.propagateChange(this.data);
    // }

    // // the method set in registerOnChange to emit changes back to the form
    // private propagateChange = (_: any) => { };

}



