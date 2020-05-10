import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { FalseCeilingComponent } from './false-ceiling.component';

describe('FalseCeilingComponent', () => {
  let component: FalseCeilingComponent;
  let fixture: ComponentFixture<FalseCeilingComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ FalseCeilingComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(FalseCeilingComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
