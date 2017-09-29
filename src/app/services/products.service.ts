import { Injectable } from '@angular/core';
import { Http } from '@angular/http';
import 'rxjs/add/operator/map';
// import { Observable } from 'rxjs/Observable';

@Injectable()
export class ProductsService {
  //data: Observable<Array<number>>;

  constructor(public http:Http) {

  }

  fetch() {
    return this.http.get('http://jsonplaceholder.typicode.com/users')
            .map(res => res.json());
  }

  // fetchAll(){
  //   this.data = new Observable(observer => {
  //     setTimeout(() => {
  //       observer.next(1);
  //     }, 1000);
  //
  //     setTimeout(() => {
  //       observer.next(2);
  //     }, 2000);
  //
  //     setTimeout(() => {
  //       observer.next(3);
  //     }, 3000);
  //
  //     setTimeout(() => {
  //       observer.next('Done');
  //     }, 4000);
  //
  //     setTimeout(() => {
  //       observer.complete();
  //     }, 5000);
  //   });
  //
  //   return this.data;
  // }
}
