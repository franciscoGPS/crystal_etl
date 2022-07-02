import { Controller } from "stimulus";
import $ from "jquery";


export default class extends Controller {

  // Defines a `this.testTarget` that you can use in your functions.
  // Attach to an element with `data-hello-target="test"`.
  static targets = ["uploaded_files", "uploadInput", "upload_form"];
  

  // Called whenever the controller is attached to an element on the page.
  // Attach this controller with something like `<div data-controller="hello"></div>`.
  initialize() {
    console.log("Hello! StimulusJS is working!");
  }

  // Can be called from within this file with `this.update_stock()`, or in an action in your HTML.
  // Call this on a button click with something like `<button data-action="click->finance#update_stock"></button>`.


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
      success: function (data) {
        console.log(data);
        console.log("Success ");
      },
      error: function (error) {
        console.log("ERROR : ", error);
        
      }
    });
  }
}