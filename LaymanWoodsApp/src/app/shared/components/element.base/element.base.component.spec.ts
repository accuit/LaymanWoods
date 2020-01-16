import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { Element.BaseComponent } from './element.base.component';

describe('Element.BaseComponent', () => {
  let component: Element.BaseComponent;
  let fixture: ComponentFixture<Element.BaseComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ Element.BaseComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(Element.BaseComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
