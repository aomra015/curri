if Curri.user
  # Identify logged in user
  mixpanel.identify(Curri.user.id)

  userData =
    $email: Curri.user.email
    classRole: Curri.user.classrole_type
    $created: Curri.user.created_at
    $first_name: Curri.user.first_name
    $last_name: Curri.user.last_name

  # Super Properties
  mixpanel.register(userData)

  # Mixpanel People Feature
  mixpanel.people.set(userData)