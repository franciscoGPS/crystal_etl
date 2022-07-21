import { Controller } from "stimulus";
import * as d3 from "d3";

export default class extends Controller {

  // Defines a `this.testTarget` that you can use in your functions.
  // Attach to an element with `data-hello-target="test"`.
  static targets = [ "chart" ]

  static values = {
    columnMetadata: Array,
    columnName: String
  }

  // Called whenever the controller is attached to an element on the page.
  // Attach this controller with something like `<div data-controller="hello"></div>`.
  initialize() {
    console.log("Hello from the d3 index controller!");
    this.initD3()
  }

  initD3(){
    const data = JSON.parse(this.chartTarget.dataset.columnMetadataValue)

    const width = 200;
    const height = 100;
    const margin = { top: 5, bottom: 5, left: 5, right: 5 };
    debugger
    const svg = d3.select(`#${this.chartTarget.dataset.columnNameValue}`)
      .append('svg')
      .attr('width', width - margin.left - margin.right)
      .attr('height', height - margin.top - margin.bottom)
      .attr("viewBox", [0, 0, width, height]);
    
    const x = d3.scaleBand()
      .domain(d3.range(data.length))
      .range([margin.left, width - margin.right])
      .padding(0.1)
    
    const y = d3.scaleLinear()
      .domain([0, 100])
      .range([height - margin.bottom, margin.top])
    
    svg
      .append("g")
      .attr("fill", 'royalblue')
      .selectAll("rect")
      .data(data.sort((a, b) => d3.descending(a.value, b.value)))
      .join("rect")
        .attr("x", (d, i) => x(i))
        .attr("y", d => y(d.value))
        .attr('title', (d) => d.value)
        .attr("class", "rect")
        .attr("height", d => y(0) - y(d.value))
        .attr("width", x.bandwidth());
    
    function yAxis(g) {
      g.attr("transform", `translate(${margin.left}, 0)`)
        .call(d3.axisLeft(y).ticks(null, data.format))
        .attr("font-size", '20px')
    }
    
    function xAxis(g) {
      g.attr("transform", `translate(0,${height - margin.bottom})`)
        .call(d3.axisBottom(x).tickFormat(i => data[i].key))
        .attr("font-size", '20px')
    }
    
    svg.append("g").call(xAxis);
    svg.append("g").call(yAxis);
    debugger  
    svg.node();
  }
}