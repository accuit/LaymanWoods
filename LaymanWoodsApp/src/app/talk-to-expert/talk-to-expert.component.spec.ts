import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { TalkToExpertComponent } from './talk-to-expert.component';

describe('TalkToExpertComponent', () => {
  let component: TalkToExpertComponent;
  let fixture: ComponentFixture<TalkToExpertComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ TalkToExpertComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(TalkToExpertComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
