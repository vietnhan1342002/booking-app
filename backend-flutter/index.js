const express = require("express");
const db = require("./src/config/connection");
const route = require("./src/routes");
const cors = require("cors");
const app = express();
const env = require("./src/config/env");

app.use(express.json());

db.connect();

app.use(cors());

app.get("/", (req, res) => {
  res.send("Hello, world!!!!");
});

// Routes init
route(app);

app.listen(env.PORT, () => {
  console.log(`Connect to server is successfully with PORT: ${env.PORT}`);
});
