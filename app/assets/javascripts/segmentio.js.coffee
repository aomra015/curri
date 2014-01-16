if @Curri && @Curri.user
  userData =
    email: Curri.user.email
    classRole: Curri.user.classrole_type
    created: Curri.user.created_at
    firstName: Curri.user.first_name || 'No'
    lastName: Curri.user.last_name || 'Name'

  analytics.identify(Curri.user.id, userData)