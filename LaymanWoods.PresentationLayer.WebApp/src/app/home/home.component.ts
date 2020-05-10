import { Component, ViewChild, ElementRef } from '@angular/core';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent {
  @ViewChild('videoplayer', { static: true }) videoplayer: ElementRef;

  ngAfterViewInit() {
    // this.videoplayer.nativeElement.click();
  }

  onClick() {
    if (this.videoplayer.nativeElement) {
      const player: HTMLVideoElement = this.videoplayer.nativeElement;
      player.play();
    }
  }
}
