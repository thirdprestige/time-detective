module FindByEmail
  def id_for_email email
    User.find_or_initialize_by(email: email).tap do |user|
      user.save validate: false

      # Tie the user to this account, if they aren't already
      # Since we don't mark the `accounting` record as confirmed,
      # they won't be able to cause any damage,
      # or log in to this account
      proxy_association.owner.accountings.find_or_create_by(user_id: user.id)
    end.id
  end
end
