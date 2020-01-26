import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { environment } from 'src/environments/environment';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';

@Injectable()
export class NotificationService {

    baseUrl = environment.apiUrl;
    headers: HttpHeaders;
    notificationUrl: 'https://2factor.in/API/V1/070815b0-3e08-11ea-9fa5-0200cd936042/SMS/';
  
    constructor(private readonly httpClient: HttpClient) {

      this.headers = new HttpHeaders({
        'Content-Type': 'application/json; charset=utf-8',
        'Access-Control-Allow-Origin': '*',
        'No-Auth': 'True'
      });
    }

  sendOtp(mobile : string): Observable<any> {

    return this.httpClient.get<any>(this.notificationUrl + mobile + '/AUTOGEN', { headers: this.headers })
    .pipe(
        map(res => {
          if (!res) {
            throw new Error('Something Went Wrong! Please try again');
          }
          return res;
        }));
  }

  
  verifyOtp(obj : Otp): Observable<any> {

    return this.httpClient.get<any>(this.notificationUrl + 'VERIFY/' + obj.guid + '/' + obj.otp, { headers: this.headers })
    .pipe(
        map(res => {
          if (!res) {
            throw new Error('Something Went Wrong! Please try again');
          }
          return res;
        }));
  }
}

export class Otp {
    id: string;
    otp: string;
    guid: string;
    isActive: boolean;
}
