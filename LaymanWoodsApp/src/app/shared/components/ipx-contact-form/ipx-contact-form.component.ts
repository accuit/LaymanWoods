import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { OTP, NotificationService } from 'src/app/core/notification.service';
import { APIResponse } from '../../model/core.model';
import { MouseEvent } from '@agm/core';

// just an interface for type safety.
interface marker {
	lat: number;
	lng: number;
	label?: string;
	draggable: boolean;
}

@Component({
  selector: 'ipx-contact-form',
  templateUrl: './ipx-contact-form.component.html',
  styleUrls: ['./ipx-contact-form.component.scss']
})
export class IpxContactFormComponent implements OnInit {

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
      phone: ['', [Validators.required, Validators.minLength(10), Validators.maxLength(10)]],
      otp: ['', [Validators.minLength(6), Validators.maxLength(6)]],
      message: [''],
      companyID: [1]
    })

    this.otpForm = this.formBuilder.group({
      otp: ['', [Validators.minLength(6), Validators.maxLength(6)]]
    })
  }

  get f() {
    return this.enquiryForm.controls;
  }
  get fotp() {
    return this.otpForm.controls;
  }

  onVerifyOTP() {
    this.otpSubmitted = true;
    this.verifying = true;
    this.otpResponse.otp = this.otpForm.value.otp;
    this.service.verifyOtp(this.otpResponse)
      .then((res: APIResponse) => {
        if (res.isSuccess) {
          this.isSuccess = res.isSuccess;
          this.service.contactEnquiry(this.enquiryForm.value);
        } else {
          this.isSuccess = false;
        }

      }).catch((error) => {
        this.isSuccess = false;
        console.log("Request rejected with " + JSON.stringify(error));
      })

    this.verifying = false;
  }

  onSubmit(): any {
    this.submitted = true;
    if (this.enquiryForm.invalid) {
      return;
    }
    this.mobile = this.enquiryForm.value.phone;
    this.sendOTP(this.mobile);
  }

  resendOTP(): void {
    this.reSent = true;
    this.sendOTP(this.mobile);
  }

  sendOTP(mobile): any {
    this.service.sendOtp(mobile)
      .then((res: any) => {
        this.otpResponse = res;
        if (res.Status === 'Success') {
          this.otpSent = true;
          this.otpResponse.userID = this.enquiryForm.value.phone;
          this.otpResponse.otpStatus = 'Sent';
          this.otpResponse.guid = res.Details;
        } else {
          this.otpResponse.otpStatus = 'Failed';
          return;
        }
      }).catch((error) => {
        console.log("Request rejected with " + JSON.stringify(error));
      });
  }

}
