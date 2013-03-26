# bodyimage

### What is this?

An open source Rails API to track 'quantified self'-type data. Right now, the biggest
players in this space are running closed systems. Let's change that.

### License

To come. GPL is likely.

### Roadmap

* /body/weight
** Weight.all_for_user.order("date DESC")
*** recorded_at
*** value
*** bmi
*** user
*** lean_mass_value
*** fat_mass_value

* /body/weight/current
** Weight.current_for_user

* /body/weight/goal
** WeightGoal.current_for_user
*** recorded_at
*** value

*/user/:id
** User.find(:id)
*** name
*** email
*** password
*** timezone
*** height
*** birthday

* /body/measurements
** Measurement.all_for_user.order("date DESC")
*** recorded_at
*** bicep, calf, chest, forearm, hips, neck, thigh, waist
*** weight, fat, bmi, muscle mass (aliases)
