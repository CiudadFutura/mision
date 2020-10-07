json.pagination do
  json.current_page @users.current_page
  json.per_page @users.per_page
  json.total_entries @users.total_entries
end

json.users @users do |user|
  json.id user.id

  json.user do
    json.id user.user.id
    json.name user.user.name
  end

  json.content user.content
  json.created_at user.created_at
end