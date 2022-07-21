import { Controller } from "stimulus";
import * as d3 from "d3";

export default class extends Controller {

  // Defines a `this.testTarget` that you can use in your functions.
  // Attach to an element with `data-hello-target="test"`.
  static get targets() {
    return [""];
  }

  static values = {
    columnMetadata: Array,
    columnName: String,
  }

  // Called whenever the controller is attached to an element on the page.
  // Attach this controller with something like `<div data-controller="hello"></div>`.
  initialize() {
    console.log("Hello from the source_files index controller!");
    const packery = this.initPackery()
    const draggies = this.initDraggie(packery)
  }
  
  initPackery() {
    var elem = document.querySelector('.grid')
    return new Packery( elem, {
      // options
      itemSelector: '.grid-item',
      columnWidth: 100,
      gutter: 0
    });
  }

  initDraggie(packery) {
    // if you have multiple .draggable elements
    // get all draggie elements
    var draggableElems = document.querySelectorAll('.draggable')
    // array of Draggabillies
    var draggies = []
    // init Draggabillies
    draggableElems.forEach((elem) => {
      var draggie = new Draggabilly( elem, {
        // options...
      });
      packery.bindDraggabillyEvents( draggie )
      draggies.push( draggie )
    })

    
    return draggies
  }

  // Can be called from within this file with `this.update_stock()`, or in an action in your HTML.
  // Call this on a button click with something like `<button data-action="click->finance#update_stock"></button>`.

}