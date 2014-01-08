# Quantify

### What is this?

![Quantify.io demo](http://i.imgur.com/C1HSK5q.png)

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


### Roadmap



#### /weights
* id              :integer          not null, primary key
* bmi             :float
* value           :float
* lean_mass       :float
* fat_mass        :float
* fat_percent     :float
* date            :datetime

#### /users
* name
* height
* age
* birthday

#### /workouts
?

#### /sleep
* start (datetime)
* end (datetime)

#### /nutrition
* date
* calories
* carbs (g)
* fats (g)
* protein (g)
* start
* end


### To Do
* Tests for Withings Omniauth (omniauths_callback_controller_spec, withings_account_controller_spec)
* Tests for user#has_withings_auth?, user#has_scale_auth?, user#update_bmi_for_user
* Add active model serializers
* Add basic add/edit UI for place/weight
* Validation on birthday field
* Add Strong Params
* Generic "data update" methods on login/forced - basically the sync feature
* Only include the Foundation JS that is being used
* check rails 4 version of devise
* add https://github.com/scottwater/detect_timezone_rails
