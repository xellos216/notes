const express = require('express');
const app = express();
app.get('/', (_req, res) => res.send('Hello from Express in Docker!'));
app.listen(3000, '0.0.0.0');
