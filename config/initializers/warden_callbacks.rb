Warden::Manager.after_authentication do |user,auth,opts|
  user.sync_all_provider_data
end
