import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators, FormControl } from '@angular/forms';
import { NotificationService, OTP } from '../core/notification.service';
import { APIResponse } from '../shared/model/core.model';

@Component({
  selector: 'app-entrepreneur',
  templateUrl: './entrepreneur.component.html',
  styleUrls: ['./entrepreneur.component.scss']
})
export class EntrepreneurComponent implements OnInit {

  investmentAmount = [];
  enquiryForm: FormGroup;
  otpForm: FormGroup;
  otpResponse: OTP;
  submitted = false;
  otpSubmitted = false;
  otpSent = false;
  isSuccess = false;
  verifying = false;
  mobile: string;
  reSent = false;
  constructor(private readonly formBuilder: FormBuilder,
    private readonly service: NotificationService) { }

  ngOnInit() {
    this.enquiryForm = this.formBuilder.group({
      name: ['', Validators.required],
      email: ['', [Validators.required, Validators.email]],
      mobile: ['', [Validators.required, Validators.minLength(10), Validators.maxLength(10)]],
      //otp: ['', [Validators.minLength(6), Validators.maxLength(6)]],
      // message: [''],
      investment: [this.investmentAmount[0], Validators.required],
      location: [''],
      profession: [''],
      companyID: [1]
    });

    this.investmentAmount = [
      { id: 0, title: 'Amount Planning To Invest' },
      { id: 2.500000, title: '2.5 Lac' },
      { id: 500000, title: '5 Lac' },
      { id: 1000000, title: '10 Lac' },
      { id: 1500000, title: '15 Lac' },
      { id: 2000000, title: '20 Lac' },
      { id: 2500000, title: '25 Lac' },
      { id: 5000000, title: '50 Lac' },
      { id: 7500000, title: '75 Lac' },
      { id: 10000000, title: '01 Crore' }];
  }

  get f() {
    return this.enquiryForm.controls;
  }

  onSubmit(): any {
    this.submitted = true;
    this.verifying = true;
    if (this.enquiryForm.invalid) {
      return;
    }

    this.service.businessEnquiry(this.enquiryForm.value)
      .subscribe((res: APIResponse) => {
        if (res.isSuccess) {
          this.isSuccess = true;
          this.verifying = false;
          this.enquiryForm.reset();
          this.submitted = false;
        } else{
          this.isSuccess = false;
        }
      })
  }

}
