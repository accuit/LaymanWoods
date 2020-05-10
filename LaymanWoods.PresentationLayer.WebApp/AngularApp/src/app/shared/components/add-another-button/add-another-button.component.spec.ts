import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { AddAnotherButtonComponent } from './add-another-button.component';

describe('AddAnotherButtonComponent', () => {
  let component: AddAnotherButtonComponent;
  let fixture: ComponentFixture<AddAnotherButtonComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ AddAnotherButtonComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AddAnotherButtonComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
