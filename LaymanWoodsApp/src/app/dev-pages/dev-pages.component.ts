import { Component, OnInit, ViewChild } from '@angular/core';
import { FormControl, FormGroup, FormBuilder } from '@angular/forms';
import { Dimension } from '../shared/enums/app.enums';
import { Unit } from '../shared/model/core.model';
import { Kitchen } from '../calculator/kitchen/kitchen.component';
import { IpxRadioButtonGroupDirective } from '../shared/directive/radio/radio-group.directive';

class Person {
  favoriteSeason: string;

  constructor(public name: string, season?: string) {
      if (season) {
          this.favoriteSeason = season;
      }
  }
}

@Component({
  selector: 'app-dev-pages',
  templateUrl: './dev-pages.component.html',
  styleUrls: ['./dev-pages.component.scss']
})


export class DevPagesComponent implements OnInit {
  textValue = 'Hello Text';
  dimension = Dimension.LENGTH;
  A: Unit = { feet: 0, inches: 0, type: Dimension.LENGTH };
  kitchens: Kitchen[] = [
    { sides: 2, value: 'L', name: 'L Shape', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ7ab3mQ1hTGaubD5ikYglCyqCrvx0AYAU4wRCbF5Vvy6x9MWan' },
    { sides: 2, value: 'U', name: 'U Shape', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRacRyScjIqmYZnjbU6tvqKrIWmB9PtAuSSQh7wnuziq3MygiFw' },
    { sides: 2, value: 'I', name: 'Single Side I Shape', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSp-Ob2Re5RoosQmTW08Wqco81kD3Pytyere6Bi4xBXOd3Z_T2a' },
    { sides: 2, value: 'P', name: 'Parallel Shape', imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQYz187YumgO2l4JOZLdvwGtj1CMP7uKUlTaPg8Z-eVbVlgEaYw' },
  ];

  selectedItem: any =  { value: 'L', name: 'L Shape', imageUrl:'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ7ab3mQ1hTGaubD5ikYglCyqCrvx0AYAU4wRCbF5Vvy6x9MWan'};

  ngOnInit() {
  }

  phone: FormControl = new FormControl('8746232', {
    updateOn: 'blur'
  });

  @ViewChild('radioGroupZZ', { read: IpxRadioButtonGroupDirective, static: true }) public radioGroup: IpxRadioButtonGroupDirective;

  selectedValue: any;

  seasons = [
      'Winter',
      'Spring',
      'Summer',
      'Autumn',
  ];

  personBob: any = new Person('Bob', this.seasons[2]);

  newPerson: Person;
  personKirk: Person = new Person('Kirk', this.seasons[1]);
  personKirkForm: FormGroup;

  constructor(private _formBuilder: FormBuilder) {
      this._createPersonKirkForm();
  }

  get diagnostic() {
      return JSON.stringify(this.personBob);
  }

  ngAfterContentInit(): void {
      setTimeout(() => this.selectedValue = this.radioGroup.value);
  }

  onBtnClick(evt) {
      this.radioGroup.value = 'Baz';
  }

  onUpdateBtnClick(evt) {
      const formModel = this.personKirkForm.value;

      this.newPerson = new Person(formModel.name as string, formModel.favoriteSeason as string);
  }

  onRadioChange(evt) {
      this.selectedValue = evt.value;
  }

  onSubmit() {
      this.personBob.favoriteSeason = this.seasons[1];
  }

  private _createPersonKirkForm() {
      this.personKirkForm = this._formBuilder.group({
          name: '',
          favoriteSeason: ''
      });

      this.personKirkForm.setValue({
          name: this.personKirk.name,
          favoriteSeason: this.personKirk.favoriteSeason
      });
  }

}
