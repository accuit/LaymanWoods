import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ComboTextboxComponent } from './combo-textbox.component';

describe('ComboTextboxComponent', () => {
  let component: ComboTextboxComponent;
  let fixture: ComponentFixture<ComboTextboxComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ComboTextboxComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ComboTextboxComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
