import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ComboBoxExampleComponent } from './combo-box-example.component';

describe('ComboBoxExampleComponent', () => {
  let component: ComboBoxExampleComponent;
  let fixture: ComponentFixture<ComboBoxExampleComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ComboBoxExampleComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ComboBoxExampleComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
