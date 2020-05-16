import { Component } from '@angular/core';
import { MouseEvent } from '@agm/core';

// just an interface for type safety.
interface marker {
	lat: number;
	lng: number;
	label?: string;
	draggable: boolean;
}

@Component({
  selector: 'app-contact',
  templateUrl: './contact.component.html',
  styleUrls: ['./contact.component.scss']
})
export class ContactComponent {
 // google maps zoom level
 zoom: number = 15;
  
 // initial center position for the map
 lat: number = 22.5267089;
 lng: number = 88.3449872;

 markerDragEnd(m: marker, $event: MouseEvent) {
  console.log('dragEnd', m, $event);
}

markers: marker[] = [
  {
    lat: 22.5272919,
    lng: 88.3501469,
    label: 'A',
    draggable: false
  }
]

}