import { Controller } from "stimulus";
import $ from "jquery";
import * as d3 from "d3";

export default class extends Controller {

  // Defines a `this.testTarget` that you can use in your functions.
  // Attach to an element with `data-hello-target="test"`.
  static targets = ["uploaded_files", "uploadInput", "upload_form"];
  

  // Called whenever the controller is attached to an element on the page.
  // Attach this controller with something like `<div data-controller="hello"></div>`.
  initialize() {
    console.log("Hello! StimulusJS is working!");
    const div = d3.selectAll("div");    
  }

  // Can be called from within this file with `this.update_stock()`, or in an action in your HTML.
  // Call this on a button click with something like `<button data-action="click->finance#update_stock"></button>`.

  renderSheet(response) {
    var options = {
      "container": 'luckysheet', //luckysheet is the container id
      "title": response.title, // set the name of the table
      "lang": "en", // set language
      "data": [{
        "name": response.title, //Worksheet name
        "celldata": response.data.map((item) => { return JSON.parse(item) })
      }]
    }
    debugger
    const sheetContainer = document.getElementById('luckysheet') 
    
    sheetContainer.style.margin = "0px";
    sheetContainer.style.padding = "0px";
    sheetContainer.style.position = "absolute";
    sheetContainer.style.width = "100%";
    sheetContainer.style.height = "100%";
    sheetContainer.style.left = "0px";
    sheetContainer.style.top = "0px";
    luckysheet.create(options)
  }

  send_file(){
    console.log("Sending file... ");
    var data = new FormData();

    $.each(this.uploadInputTarget.files, function(i, file) {
        data.append('source_file:lucky_file', file);
    });

    // If you want to add an extra field for the FormData
    // data.append("CustomField", "This is some extra data, testing");
    // disabled the submit button
    // $("#btn_submit_upload").prop("disabled", true);

    // attachable_id = $("#attachable_id").val();
    // attachment_file_type = $("#attachment_file_type").val();
    // attachablefile_type = $("#attachment_attachable").val();
    // data.append("file_type", attachment_file_type);
    // data.append("attachable", attachablefile_type);

    $.ajax({
      url: '/source_files/',
      type: "post",
      contentType: false,
      processData: false,
      cache: true,
      data: data,
      headers: {
        "Accept": "application/json",
        "contentType": "application/json; charset=utf-8",
        "token": document.head.querySelector('meta[name="csrf-token"]').content,
      },
      success: function (response) {
        console.log(response);
      
        //renderSheet(response)
        console.log("Success ");

      },
      error: function (error) {
        console.log("ERROR : ", error);
        
      }
    });
  }
}