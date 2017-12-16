/**
 * Script for testing production build. It starts express server which serves
 * files compiled for the production.
 */
import express from 'express';
import path from 'path';
import open from 'opn';
import chalk from 'chalk';

const port = 3000;
const app = express();

app.use(express.static('docs'));

// This is single page application, therefore we route all the requests to the index.html
app.get('*', (req, res) => {
    res.sendFile(path.join(__dirname, '../docs/index.html'));
});

// Start express server
app.listen(port, (err) => {
    if (err) {
        console.log(chalk.red(err));
    } else {
        open(`http://localhost:${port}`);
        console.log(chalk.green(`Starting server on port ${port}`));
    }
});
