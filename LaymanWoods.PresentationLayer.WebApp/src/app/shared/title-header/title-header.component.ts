import { Component, OnInit, Input, AfterViewInit, ElementRef, ViewChild, Renderer2 } from '@angular/core';

@Component({
  selector: 'app-title-header',
  templateUrl: './title-header.component.html',
  styleUrls: ['./title-header.component.scss']
})
export class TitleHeaderComponent implements OnInit, AfterViewInit {
  loadVideo = false;
  @Input('type') type = 'image';
  @Input('url') url: string;
  @Input('title') title: string;
  @Input('subTitle') subTitle: string;
  @Input('parent') parent: string;
  @Input('parent-path') parentPath: string;
  @Input('current-page') current: string;
  @ViewChild('imageEl', { static: false }) imageEl: ElementRef;

  constructor(private readonly renderer: Renderer2) { }

  ngOnInit() {
    const defaultImage = 'http://wex.com.pk/images/calculator-banner.png';
    const defaultVideo = 'http://laymanwood.in/assets/videos/slider.mp4';
    this.url = this.type === 'image' ? ('' ? defaultImage : this.url) : ('' ? defaultVideo : this.url);
  }

  ngAfterViewInit() {
    this.loadVideo = this.type === 'video' ? true : false;
    if (this.imageEl) {
      this.renderer.setAttribute(this.imageEl.nativeElement, 'data-background', this.url);
    }

  }

}
