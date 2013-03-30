# bodyimage

### What is this?

An open source Rails API to track "quantified self" data.

Right now, the hardware companies in this space are storing your data in closed systems.
Let's change that.

Take the Withings WiFi scale or the FitBit, for example. Both are essential pieces of
the quantified self hacker, yet both store your data in their respective, siloed databases.
What happens when one of them goes bust? Or decides to pivot towards an ad-based business
model?

This project includes a Rails + MySQL RESTful API to store your data.

### License

TBD. GPL is likely. Open an issue to have input.

### Roadmap

#### /body/weight
* Weight.all_for_user.order("date DESC")
* recorded_at
* value
* bmi
* user
* lean_mass_value
* fat_mass_value

#### /body/weight/current
* Weight.current_for_user

#### /body/weight/goal
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

#### /body/measurements
* Measurement.all_for_user.order("date DESC")
* recorded_at
* bicep, calf, chest, forearm, hips, neck, thigh, waist
* weight, fat, bmi, muscle mass (aliases)
