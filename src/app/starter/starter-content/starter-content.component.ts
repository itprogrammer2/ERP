import { Component, OnInit } from '@angular/core';
import { ProductsService } from '../../services/products.service';
// Variable in assets/js/scripts.js file
declare var AdminLTE: any;

@Component({
  selector: 'app-starter-content',
  templateUrl: './starter-content.component.html',
  styleUrls: ['./starter-content.component.css']
})
export class StarterContentComponent implements OnInit {
  products: any[] = [];

  constructor(public productService:ProductsService) {
    // this.productService.fetchAll().subscribe(data => {
    //   this.products.push(data);
    // });

    this.productService.fetch().subscribe(data => {
      console.log(data);
      this.products = data;
    });
  }

  ngOnInit() {
    // Update the AdminLTE layouts
    AdminLTE.init();
  }

}
