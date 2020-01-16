import { ChangeDetectionStrategy, Component, Input, OnInit } from '@angular/core';
import { ElementBaseComponent } from '../element.base/element.base.component';

@Component({
    selector: 'ipx-text-field',
    templateUrl: './text-field.component.html',
    changeDetection: ChangeDetectionStrategy.OnPush
})
export class IpxTextFieldComponent extends ElementBaseComponent<string> implements OnInit {
    @Input() label: string;
    @Input() rows: number | undefined;
    @Input() mask: boolean;
    @Input() placeholder: string;
    @Input() errorParam: any;

    getCustomErrorParams = () => ({
        errorParam: this.errorParam
    });
    multiLine = false;
    identifier: string;

    ngOnInit(): any {
        this.identifier = this.getId('textfield');
        this.multiLine = this.el.nativeElement.hasAttribute('multiline');
        if (this.multiLine && this.rows === undefined) {
            this.rows = 2;
        }
    }
}
