import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { IpxContactFormComponent } from './ipx-contact-form.component';

describe('IpxContactFormComponent', () => {
  let component: IpxContactFormComponent;
  let fixture: ComponentFixture<IpxContactFormComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ IpxContactFormComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(IpxContactFormComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
