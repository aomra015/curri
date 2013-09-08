# Curri App

## Getting Started

1. Clone it down to your computer (don't fork it please).
2. cd curry
3. bundle install
4. rake db:migrate
5. rake db:seed

### Start development environment
- `$ foreman start`

### Run tests
- Terminal Tab 1: `$ rackup private_pub.ru -s thin -E test`
- Terminal Tab 2: `$ rake`

## To do

### Front-end View
- Success criteria pop-over style needs to be fixed
- Give students an indication that their rating was saved to the database. Maybe a "Last Rating at: <time>" somewhere on the page.
- When on a track, the side menu should indicate current track (prehaps with a colour or icon)
- Give information about who is logged in (maybe in top right corner)
- Hide teacher interface from students by using the new 'teacher?' method.

Example:

```
<% if current_user.teacher? %>
  # Analytics link here
<% end %>
```

### Forms
- Create form for adding a track and its associated checkpoints.

### Invitations
- ability to invite multiple students at once (discuss this)

### Analytics
- individual student analytics (discuss this)
- aggregated analytics over time (discuss this)

## Done

### Invitations
- ~~student with account can claim invitation without sign up~~
- ~~currently logged in student can claim invitation without sign up~~

### Ratings
- ~~checkpoint ratings should be associated with a student~~

### Forms
- ~~add validations to forms~~
- ~~add dynamic_forms gem for form errors~~

### Teacher Authorization
- ~~only teachers should access analytics view~~
- ~~only teachers should be able to add/edit/delete classrooms/tracks/checkpoints~~

### Student Authorization
- ~~only students should be able to rate checkpoints~~
