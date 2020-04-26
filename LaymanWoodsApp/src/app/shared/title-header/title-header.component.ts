import { Component, OnInit, Input, AfterViewInit, ElementRef, ViewChild, Renderer2 } from '@angular/core';

@Component({
  selector: 'app-title-header',
  templateUrl: './title-header.component.html',
  styleUrls: ['./title-header.component.scss']
})
export class TitleHeaderComponent implements OnInit, AfterViewInit {

  @Input('type') type: string;
  @Input('bg-image') bgImage: string;
  @Input('title') title: string;
  @Input('subTitle') subTitle: string;
  @Input('parent') parent: string;
  @Input('parent-path') parentPath: string;
  @Input('current-page') current: string;
  @ViewChild('image', { static: true }) imageEl: ElementRef;

  constructor(private readonly el: ElementRef, private readonly renderer: Renderer2) { }

  ngOnInit() {
    this.bgImage = '' ? 'http://wex.com.pk/images/calculator-banner.png' : this.bgImage;
  }

  ngAfterViewInit() {
    this.renderer.setAttribute(this.imageEl.nativeElement, 'data-background', this.bgImage);
  }

}
