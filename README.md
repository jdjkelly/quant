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
* Weight.all_for_user.order("date DESC")
* recorded_at
* value
* bmi
* user
* lean_mass_value
* fat_mass_value

#### /weights/current
* Weight.current_for_user

#### /weights/goal
* WeightGoal.current_for_user
* recorded_at
* value

#### /user/:id
* User.find(:id)
* name
* email
* password
* timezone
* height
* birthday

#### /measurements
* Measurement.all_for_user.order("date DESC")
* recorded_at
* bicep, calf, chest, forearm, hips, neck, thigh, waist
* weight, fat, bmi, muscle mass (aliases)

#### /lifts

#### /sleep

#### /nutrition


### To Do
* Tests for Withings Omniauth (omniauths_callback_controller_spec, withings_account_controller_spec)
* Tests for user#has_withings_auth?, user#has_scale_auth?, user#update_bmi_for_user
* Add active model serializers
* Add basic add/edit UI for location/weight/measurements
* Validation on birthday field
* Add Strong Params
* Upgrade to Rails 4
* Generic "data update" methods on login/forced - basically the sync feature
* Only include the Foundation JS that is being used
* check rails 4 version of devise
* remove measurement - move that to the user
* upgrade to strong params
