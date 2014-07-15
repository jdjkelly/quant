# Quant

### What is this?

![Quant demo](http://i.imgur.com/x5AlmuK.png)

An open source Rails API to track "quantified self" data.

Right now, the hardware companies in this space are storing your data in closed systems.
Let's change that.

Take the Withings WiFi scale or the FitBit, for example. Both are essential pieces of
the quantified self hacker, yet both store your data in their respective, siloed databases.
What happens when one of them goes bust? Or decides to pivot towards an ad-based business
model?

This project includes a Rails + Postgres RESTful API to store your data.

### Status

[ ![Codeship Status for jdjkelly/quantify](https://www.codeship.io/projects/09ef6f10-81d4-0130-00e5-12313d26400d/status?branch=master)](https://www.codeship.io/projects/2416)

### Roadmap

#### Spring 2014 (June)
* CRUD interface for weights, meals, sleeps, and journal entries
* Basic summary graphs/charts for above
* Summary dashboard
** Easily add/remove services
** Single button click -> update all data/sync sources
* User onboarding process/wizard
* Documentation/developer guide on README

#### Summer 2014 (July)
* Working integration with Fitbit, Withings, Jawbone
* API server - Ember client app split (rebuild UI)
* Webhook support for integrations (auto updates)
* Docker image

### To Do
* Validation on birthday field
* add https://github.com/scottwater/detect_timezone_rails
* index on meals#date

### API Integrations

#### Weights
* Withings
* Jawbone (future)
* Fitbit (future)

#### Sleeps
* Fitbit (future)
* Withings
* Jawbone (future)

#### Meals
* Fitbit (future)
* Withings (future)
* Jawbone (future)

#### Places
* Foursquare
* OpenPaths (future)

### License

The MIT License (MIT)

Copyright (c) 2013 Joshua Kelly

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
