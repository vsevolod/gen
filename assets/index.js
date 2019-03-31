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


const amount = 100
const width = 1000

const vis = d3.select("body")
  .append("svg")
    .attr("width", width)
    .attr("height", width)

const scale = d3.scaleLinear().domain([0, amount]).range([0, width])
var data = []

function buildTik(data) {
  d3.selectAll("circle").remove();

  vis.selectAll("circles.food")
    .data(data.foods)
    .enter()
      .append("circle")
      .attr("class", "food")
      .attr("cx", (d) => scale(d.x))
      .attr("cy", (d) => scale(d.y))
      .attr("fill", "red")
      .attr("r", 8)

  vis.selectAll("circles.mite")
    .data(data.population)
    .enter()
      .append("circle")
      .attr("class", "mite")
      .attr("cx", (d) => scale(d.x))
      .attr("cy", (d) => scale(d.y))
      .attr("fill", (d) => d3.interpolateRdYlGn(1 - (d.age / 100)))
      .attr("r", 5)
}
