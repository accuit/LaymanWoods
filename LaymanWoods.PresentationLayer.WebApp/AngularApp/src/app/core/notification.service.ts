import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { environment } from 'src/environments/environment';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';
import { APIResponse } from '../shared/model/core.model';

@Injectable()
export class NotificationService {

  baseUrl = environment.apiUrl;
  headers: HttpHeaders;
  notificationUrl = 'https://2factor.in/API/V1/070815b0-3e08-11ea-9fa5-0200cd936042/SMS/';

  constructor(private readonly httpClient: HttpClient) {

    this.headers = new HttpHeaders({
      'Content-Type': 'application/json; charset=utf-8',
      'Access-Control-Allow-Origin': '*',
      'No-Auth': 'True'
    });
  }

  sendOtp(mobile: string): any {

    return this.httpClient.get(this.notificationUrl + mobile + '/AUTOGEN').toPromise();
    // promise.then((response) => {
    //   return response;
    // }).catch((error) => {
    //   console.log("Request rejected with " + JSON.stringify(error));
    // });
  }


  verifyOtp(obj: OTP): any {

    return this.httpClient.post<any>(this.baseUrl + 'api/notification/verify-otp', obj, { headers: this.headers }).toPromise();
      // .pipe(
      //   map((res: APIResponse) => {
      //     if (!res.isSuccess) {
      //       throw new Error('Something Went Wrong! Please try again');
      //     }
      //     return res;
      //   }));
  }

  sendNotification(): Observable<any> {
    return this.httpClient.get<APIResponse>(this.baseUrl + 'api/notification/send-email', { headers: this.headers })
      .pipe(
        map(res => {
          if (!res.isSuccess) {
            throw new Error(res.message);
          }
          return res.singleResult;
        }));
  }


}

export class OTP {
  userID: string;
  otp: number;
  guid: string;
  otpStatus: string;
}