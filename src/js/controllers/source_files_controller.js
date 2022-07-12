import { Controller } from "stimulus";
import $ from "jquery";


export default class extends Controller {

  // Defines a `this.testTarget` that you can use in your functions.
  // Attach to an element with `data-hello-target="test"`.
  static get targets() {
    return [""];
  }

  // Called whenever the controller is attached to an element on the page.
  // Attach this controller with something like `<div data-controller="hello"></div>`.
  initialize() {
    console.log("Hello from the source_files index controller!");
    var elem = document.querySelector('.grid');
    var pckry = new Packery( elem, {
      // options
      itemSelector: '.grid-item',
      gutter: 10
    });
  }

  // Can be called from within this file with `this.update_stock()`, or in an action in your HTML.
  // Call this on a button click with something like `<button data-action="click->finance#update_stock"></button>`.

}