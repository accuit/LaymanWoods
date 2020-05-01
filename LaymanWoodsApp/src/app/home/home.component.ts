import { Component, OnInit, ViewChild, ElementRef, AfterViewInit, Renderer2 } from '@angular/core';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements AfterViewInit {
  @ViewChild('videoplayer', { static: true }) videoplayer: ElementRef;

  ngAfterViewInit() {
    this.videoplayer.nativeElement.click();
  }

  onClick() {
    const player: HTMLVideoElement = this.videoplayer.nativeElement;
    player.play();
  }

}
