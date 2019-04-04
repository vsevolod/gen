const socketId = Date.now()

ActionCable.startDebugging()

function showInContainer(body) {
  const container = document.getElementById('main')
  buildTik(JSON.parse(body))
}

const cable = ActionCable.createConsumer('ws://localhost:9293/cable?sid=' + socketId)
const chatChannel = cable.subscriptions.create(
  { channel: 'main' },
  {
    connected: function(){
      console.log("Connected")
    },
    disconnected: function(){
      console.log("Connected")
    },
    received: function(response){
      // console.log("Received", data)
      showInContainer(response.message)
    }
  }
)


const xAmount = 300
const yAmount = 100
const width = 3000
const height = 1000

const vis = d3.select("body")
  .append("svg")
    .attr("width", width)
    .attr("height", height)

const xScale = d3.scaleLinear().domain([0, xAmount]).range([0, width])
const yScale = d3.scaleLinear().domain([0, yAmount]).range([0, height])
var data = []

function buildTik(data) {
  d3.selectAll("circle").remove();

  vis.selectAll("circles.food")
    .data(data.foods)
    .enter()
      .append("circle")
      .attr("class", "food")
      .attr("cx", (d) => xScale(d.x))
      .attr("cy", (d) => yScale(d.y))
      .attr("fill", "red")
      .attr("r", "4")

  vis.selectAll("circles.mite")
    .data(data.population)
    .enter()
      .append("circle")
      .attr("class", "mite")
      .attr("cx", (d) => xScale(d.x))
      .attr("cy", (d) => yScale(d.y))
      .attr("fill", (d) => d3.interpolateRdYlGn(1 - (d.age / 100)))
      .attr("r", 10)
}
